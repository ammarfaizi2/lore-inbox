Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265852AbSIRJR5>; Wed, 18 Sep 2002 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265856AbSIRJR5>; Wed, 18 Sep 2002 05:17:57 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:61120 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265852AbSIRJR4>;
	Wed, 18 Sep 2002 05:17:56 -0400
Date: Wed, 18 Sep 2002 11:22:54 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jonathan Corbet <corbet@lwn.net>
Cc: gen-lists@blueyonder.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Problems accessing USB Mass Storage
Message-ID: <20020918092254.GA14568@win.tue.nl>
References: <20020917181513.9217.qmail@eklektix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020917181513.9217.qmail@eklektix.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 12:15:13PM -0600, Jonathan Corbet wrote:

> SmartMedia cards are weird in that they have a (seemingly) random amount of
> waste space at the beginning of the card.  Your 8MB card, in particular,
> has nothing of interest in the first 25 sectors.  Some cards have a
> reasonable partition table in the first sector, and some don't.  Modern
> Windows systems (and cameras, of course) seem to be able to access the
> filesystem on the card without needing to see a partition table.
> 
> A little while I posted a Lexar SmartMedia driver patch which hacked around
> this by substituting a fake partition table when the first sector was read.

The structure of SmartMedia cards is well-known and precisely documented.
See, e.g., http://www.win.tue.nl/~aeb/linux/smartmedia/SmartMedia_Format.pdf
What varies is how readers present this to the outside world.

The card starts with the CIS, followed by a remapping table that tells
where on the card a given user sector lives. There are also sector checksums
and information about bad sectors.

Some readers have this as built-in knowledge, and present to card to
the outside world as an ordinary block device.

Some readers give direct access to the bits on the card, and then
understanding this remapping business is a job for the driver.

If you see non-understood space at the beginning of the card,
then one might suspect that your reader is of the latter kind.
The partition table will be on the card, but not on sector zero.

Andries

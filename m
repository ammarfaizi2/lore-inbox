Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUC2XiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbUC2XiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:38:21 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9195 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263207AbUC2XiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:38:20 -0500
Date: Tue, 30 Mar 2004 01:38:13 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andries.Brouwer@cwi.nl, greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       USB Storage List <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [patch] datafab fix and unusual devices
Message-ID: <20040329233812.GA17179@apps.cwi.nl>
References: <UTC200403292244.i2TMi9f11131.aeb@smtp.cwi.nl> <20040329231508.GH28472@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329231508.GH28472@one-eyed-alien.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 03:15:08PM -0800, Matthew Dharm wrote:
> On Tue, Mar 30, 2004 at 12:44:09AM +0200, Andries.Brouwer@cwi.nl wrote:
> > datafab.c has an often-seen bug: the SCSI READ_CAPACITY command
> > does not need the number of sectors but the last sector.
> 
> The first part of the patch (which fixes this bug) certainly looks good to
> me for 2.6 -- we need to check that 2.4 doesn't also have the problem.
> 
> The second part of your patch I don't like (it seems to violate the
> 'principal of least suprise' to me).... but I'm also ready and willing to
> consider a beter alternative.  What do you suggest?

Well, the entire patch should be applied. Nothing wrong with it.

That will enable people to use (0x0c0b,0xa109) to read CF,
or to read SM, but not both. (Without the patch the device
does not work at all.)
The situation is precisely the same as that for (0x07c4,0xa109).

To do something better we need infrastructure that does not exist today,
at least not in the vanilla kernel. That is why I call for discussion.

The points are ordinary use and error recovery.
For ordinary use the main point seems to be the us->extra
pointer to private data. Since each driver needs private data,
a single pointer does not suffice.

Andries

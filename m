Return-Path: <linux-kernel-owner+w=401wt.eu-S932566AbXABBlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXABBlp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 20:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXABBlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 20:41:44 -0500
Received: from flex.com ([206.126.0.13]:49895 "EHLO flex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800AbXABBlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 20:41:44 -0500
Message-ID: <4599B809.1000300@flex.com>
Date: Mon, 01 Jan 2007 17:40:25 -0800
From: David Kahn <dmk@flex.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: segher@kernel.crashing.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       wmb@firmworks.com, hch@infradead.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>	<20070101.005714.35017753.davem@davemloft.net>	<385664dfd55cfdfb9f9651fc90bf46b0@kernel.crashing.org> <20070101.150831.17863014.davem@davemloft.net>
In-Reply-To: <20070101.150831.17863014.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Miller wrote:

> We have some extensive code in fs/openpromfs/inode.c that
> determines whether a property is text or not.  I can't
> guarentee it works %100, but it's very context dependant
> (only the driver "knows") but it works for all the cases
> I've tried.

The problem with guessing, as you've noted, is that you
can't be 100% correct for device specific stuff.

Sure, you can guess that standard properties defined
by the core spec like "ranges" and "reg" consist of
integer data, but you can't make any guess about
device-specific stuff. (The heuristics you mentioned
just look at the data to see if it consists of printable
characters as far as I can tell, and that too isn't
foolproof, as you noted.)

Properties that consist of simple string data will just
show up as printable string data, but it's usually best to
leave the interpretation of binary properties up to the
entity that's consuming them, since they have to
know how to interpret them.

Also, the sparc port doesn't have to deal with
endian issues, since prop-encoding is big-endian.
There's really no way to "guess" properly.

A userland library or program can do whatever
it wants to as a helper. The interpretation of
the data should be done by the entity that consumes
it.

If that doesn't fit the model of /sys or /proc,
I suppose it could be done in a separate file
system, but that's overkill, isn't it?

-David


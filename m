Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbWJRQjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbWJRQjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWJRQjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:39:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20699 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161229AbWJRQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:39:52 -0400
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Adam Belay <abelay@MIT.EDU>
In-Reply-To: <20061018162042.GT22289@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org>
	 <45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org>
	 <1161186652.9363.68.camel@localhost.localdomain>
	 <20061018162042.GT22289@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 17:39:52 +0100
Message-Id: <1161189592.9363.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 10:20 -0600, ysgrifennodd Matthew Wilcox:
> I don't see how that's possible.  If the driver forgets to call
> pci_unblock_user_cfg_access(), that's a bug in the kernel driver.

Lets leave bugs aside thats a different problem. The goal isn't to be
bug proof

> The current user is limited to a two-second delay and the one I'm
> proposing introducing is a delay measued in milli- or microseconds.
> An extra two-second delay while you BIST your IPR device and change
> modes in X at the same time (does X really scan all devices when it's
> changing mode settings?  That's odd) doesn't strike me as a huge failure.

X scans all the devices when it sets up so only a video device one would
hang mid mode set.

> You fail the operation if it returns busy.  Or you loop.  It's really up
> to you, the driver author.  You know what operation you're trying to do,
> you know what makes more sense.

But I've no idea who, what or why and that makes it hard to handle. If
the thing refcounts then if there are two reasons to be blocked we are
fine and the last reason goes away we resume - it does make it more easy
to make mistakes. If it isnt ref counting I'd prefer block repeated is a
BUG() not a "driver figure this out"

> It seemed to me there was consensus that blocking was a better approach
> than returning a cached value or returning an error.  If we're
> decided that returning a cached value is the better approach, then
> the patch to fix it is trivial; move the pci_set_state() call from the
> pci_block_user_cfg_access() function to the IPR driver.  Done and dusted.

That would have been my choice but the blocking approach seems to be
getting somewhere so it seems worth thrashing out in full.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUBRQrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266340AbUBRQrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:47:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7403 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266458AbUBRQrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:47:06 -0500
Date: Wed, 18 Feb 2004 16:46:59 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: module unload deadlock
Message-ID: <20040218164659.GA31035@parcelfarce.linux.theplanet.co.uk>
References: <20040217172646.GT4478@dualathlon.random> <20040218041527.052222C510@lists.samba.org> <20040218043555.GY8858@parcelfarce.linux.theplanet.co.uk> <20040218154040.GZ4478@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218154040.GZ4478@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 04:40:41PM +0100, Andrea Arcangeli wrote:
> On Wed, Feb 18, 2004 at 04:35:55AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> It's clear this could be fixed by making sure parport won't call
> request_module from cleanup_module, the primary reason I fixed it in the
> module code is that I don't know if other drivers are doing this, do
> you? What parport did was legitimate, and it was working fine in the
> past, sure the parport code could be made slightly more complex and
> aware about the fact it doesn't worth to try loading the lowlevel module
> in cleanup_exit, but it wasn't obviously wrong, the cleanup/init module
> are slow paths, it didn't matter if parport tried to load a lowlevel
> module there.

Sigh...

No, it wasn't legitimate.  As the matter of fact, _nothing_ outside of
parport/share.c has any business looking at the list of ports.  IOW,
parport_enumerate() should be removed regardless of the request_module()
crap.

In particular, parport_pc should keep track of the ports it had created
instead of messing with parport_enumerate().

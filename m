Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUJEO3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUJEO3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269231AbUJEO3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:29:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269125AbUJEO24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:28:56 -0400
Date: Tue, 5 Oct 2004 15:28:55 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: lazy umount not working (udev & tmpfs on /dev)
Message-ID: <20041005142855.GK23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.44.0410051306400.16512-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0410051306400.16512-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 01:11:33PM +0300, Meelis Roos wrote:
> Hi, I'm running 2.6.9-rc3+BK (as of yesterday, 20041004) on a couple of
> x86 Debian unstable machines with udev and I'm having problems.
> 
> In 2.6.3-rc2 all was OK. Don't know exactly about plain -rc3.
> 
> In current BK, lazy umount is not working sometimes. udev start script
> mounts tmpfs on /dev and stop script does umount -l /dev. This doesn't
> return failure but nothing happens, /dev remain mounted and I can't

	It might be not umount, actually - if you get double mount for any
reason, the first umount -l will strip the top layer, leaving whatever's
beneath it.

	Could you add printk to sys_mount() and sys_umount(), so that
we could at least see which one is a problem?  Just "called mount"/"called
umount", nothing fancy with arguments...

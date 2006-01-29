Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWA2Xd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWA2Xd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWA2Xd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:33:27 -0500
Received: from ns.suse.de ([195.135.220.2]:2259 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932079AbWA2Xd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:33:27 -0500
From: Neil Brown <neilb@suse.de>
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
Date: Mon, 30 Jan 2006 10:33:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17373.20667.838469.977966@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID autodetection not working when booting with initramfs
In-Reply-To: message from Dimitris Zilaskos on Monday January 30
References: <Pine.LNX.4.64.0601300103110.2016@tassadar.physics.auth.gr>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 30, dzila@tassadar.physics.auth.gr wrote:
> 
>  	Hi ,
> 
>  	I am building a diskless system with 2.6.15.1 kernel. Eveyrthing is built 
> in the kernel ( no modules). It is booting with the help of pxelinux and 
> then proceeds to nfsmount its root filesystem etc.The system has a raid1 
> array on two scsi disks.
>  	Recently I added an initramfs image to the boot procedure (append 
> initrd=initramfs.img) for some tests. Since then the raid array is not 
> autodetected (with identical kernel). If I remove the initramfs line and 
> reboot , the array is autodetected. When I am using initramfs I can 
> manually activate it using mdadm.
> 
>  	Is this by design or something is wrong ?

To quote from init/main.c:
	/*
	 * check if there is an early userspace init.  If yes, let it do all
	 * the work
	 */

So yes, it is by design.  Assembling arrays with mdadm gives you a
lot more control than the kernel-autodetect so as you have an
initramfs, it is a good idea to make use of it.

If you *really* want to use the autodetect functionality, you can look
around for a program called 'raidautorun'.  It does triggers the
autodetect function from userspace.

NeilBrown

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWFPPef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWFPPef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWFPPef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:34:35 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20952 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751458AbWFPPee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:34:34 -0400
Date: Fri, 16 Jun 2006 17:34:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: colin <colin@realtek.com.tw>
cc: linux-kernel@vger.kernel.org
Subject: Re: Solve the problem that umount will fail when an opened file
 isn't closed
In-Reply-To: <043701c690f0$71f15530$106215ac@realtek.com.tw>
Message-ID: <Pine.LNX.4.61.0606161733030.13577@yvahk01.tjqt.qr>
References: <043701c690f0$71f15530$106215ac@realtek.com.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi all,
>I have implemented an auto-mount & auto-umount facility based on USB
>hotplug.
>An annoying problem will occur when some process doesn't close its open file
>and auto-umount is trying to umount that mount point after usb disk has been
>unplugged.
>Is there any way to force it to be umounted in this situation?
>

fs/super.c:

    /* Forget any remaining inodes */
    if (invalidate_inodes(sb)) {
        printk("VFS: Busy inodes after unmount of %s. "
           "Self-destruct in 5 seconds.  Have a nice day...\n",
           sb->s_id);
    }

That's what happens if you eject a CD. The box won't explode though.


Jan Engelhardt
-- 

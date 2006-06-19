Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWFSH1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWFSH1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWFSH1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:27:51 -0400
Received: from mf2.realtek.com.tw ([60.248.182.46]:38673 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S932208AbWFSH1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:27:50 -0400
Message-ID: <014501c69371$db472c20$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
References: <043701c690f0$71f15530$106215ac@realtek.com.tw> <Pine.LNX.4.61.0606161733030.13577@yvahk01.tjqt.qr>
Subject: Re: Solve the problem that umount will fail when an opened file isn't closed
Date: Mon, 19 Jun 2006 15:27:44 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/19 =?Bog5?B?pFWkyCAwMzoyNzo0NA==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/19 =?Bog5?B?pFWkyCAwMzoyNzo0Ng==?=,
	Serialize complete at 2006/06/19 =?Bog5?B?pFWkyCAwMzoyNzo0Ng==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jan,
I found that if the process doesn't close the file after usb disk is
unplugged, generic_shutdown_super won't be invoked.
generic_shutdown_super will be invoked right after all opened files are
closed.

Regards,
Colin


----- Original Message ----- 
From: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, June 16, 2006 11:34 PM
Subject: Re: Solve the problem that umount will fail when an opened file
isn't closed


> >
> >Hi all,
> >I have implemented an auto-mount & auto-umount facility based on USB
> >hotplug.
> >An annoying problem will occur when some process doesn't close its open
file
> >and auto-umount is trying to umount that mount point after usb disk has
been
> >unplugged.
> >Is there any way to force it to be umounted in this situation?
> >
>
> fs/super.c:
>
>     /* Forget any remaining inodes */
>     if (invalidate_inodes(sb)) {
>         printk("VFS: Busy inodes after unmount of %s. "
>            "Self-destruct in 5 seconds.  Have a nice day...\n",
>            sb->s_id);
>     }
>
> That's what happens if you eject a CD. The box won't explode though.
>
>
> Jan Engelhardt
> --


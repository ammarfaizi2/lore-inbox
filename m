Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265240AbTLFUPk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 15:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbTLFUPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 15:15:40 -0500
Received: from web14914.mail.yahoo.com ([216.136.225.241]:36870 "HELO
	web14914.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265240AbTLFUPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 15:15:24 -0500
Message-ID: <20031206201522.44780.qmail@web14914.mail.yahoo.com>
Date: Sat, 6 Dec 2003 12:15:22 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] FIx  'noexec' behavior
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Ulrich Drepper <drepper@redhat.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <87n0a590th.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to fix it:

[jonsmirl@smirl mm]$ bk diffs
===== mmap.c 1.94 vs edited =====
481c481
<       if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
---
>       if (file && (prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXE
C))
[jonsmirl@smirl mm]$

Although I didn't have any oops on my console, in dmesg or messages.


--- OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> Ulrich Drepper <drepper@redhat.com> writes:
> 
> 	if (file && (!file->f_op || !file->f_op->mmap))
> 		return -ENODEV;
> 
> 	if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
> 		return -EPERM;
> 
> Probably he get the oops, because file can be NULL.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/

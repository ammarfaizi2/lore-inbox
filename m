Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284800AbRLLA51>; Tue, 11 Dec 2001 19:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284808AbRLLA5R>; Tue, 11 Dec 2001 19:57:17 -0500
Received: from www3.aname.net ([62.119.28.103]:51330 "EHLO www3.aname.net")
	by vger.kernel.org with ESMTP id <S284800AbRLLA5J>;
	Tue, 11 Dec 2001 19:57:09 -0500
From: "Johan Ekenberg" <johan@ekenberg.se>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: SV: Lockups with 2.4.14 and 2.4.16
Date: Wed, 12 Dec 2001 01:56:26 +0100
Message-ID: <000c01c182a7$d3a093b0$050010ac@FUTURE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <E16Dwct-0007QB-00@the-village.bc.nu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another thing to try is
>
> touch /foo &
> hit return
> (should report it finished)
> touch /var/spool/foo &
> (if this never returns you know you /var/spool choked for some reason)

BTW, these commands don't work over SSH, ie the '&' doesn't produce a
background job + report-when-finished when running like:
   ssh badserver "touch /foo &"
If I run without '&', would that just touch a file somewhere in the
cache-memory, ie not flushed to disk, or would it still detect if a disk is
hung? What's the point of running it in the bg anyway?

Is there any chance the lockup could be with one of the IDE disks running
swap or backups? Could that produce a global lockup of this kind?

## /etc/fstab:
/dev/rd/c0d0   /           reiserfs   defaults,usrquota,noatime,notail 1 1
/dev/rd/c0d1   /var/spool  reiserfs   defaults,usrquota,noatime,notail 1 1
/dev/hdb1      /backup     reiserfs   defaults,noatime,notail 0 0
/dev/hda1      /boot       ext2       defaults  1  1
/dev/hda2      swap        swap       defaults  0  0
/dev/hda3      swap        swap       defaults  0  0
none           /dev/pts    devpts     gid=5,mode=620  0   0
none           /proc       proc       defaults   0   0

Best regards,
/Johan Ekenberg


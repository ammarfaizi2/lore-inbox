Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281577AbRKMJ6v>; Tue, 13 Nov 2001 04:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281580AbRKMJ6k>; Tue, 13 Nov 2001 04:58:40 -0500
Received: from [195.25.229.189] ([195.25.229.189]:23156 "EHLO
	mailrennes.rennes.si.fr.atosorigin.com") by vger.kernel.org
	with ESMTP id <S281576AbRKMJ4x> convert rfc822-to-8bit; Tue, 13 Nov 2001 04:56:53 -0500
Message-ID: <010e01c16c29$2dce2c70$8a140237@rennes.si.fr.atosorigin.com>
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
To: <srinivas.surabhi@wipro.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF11605.335EBC76@wipro.com>
Subject: Re: % more space reqd. when dd is used? 
Date: Tue, 13 Nov 2001 10:54:25 +0100
Organization: ENIB - Anciens
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 13 Nov 2001 09:54:26.0085 (UTC) FILETIME=[2DCB6D50:01C16C29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasu,

> hi all,
> I have two  physical harddisks /dev/hda1 and /hdb

You have two physical hard disks /dev/hda and /dev/hdb.
 - hda contains a partition /dev/hda1 you want to backup.
 - hdb contains at least one partition /dev/hdb1 on which you want to
   put the backup (unless you use the raw HD formatted).

I'll assume you'll backup to a file in /dev/hdb1.

> 1) i want to copy drive (take backup) to a file ( in /hdb)using dd.
> So how much space( in terms percentage)more is required in /hdb
> for it to be copied successfully.

Don't know the right answer. That shall not need too much overhead.

But I would point out that /dev/hda1 can _not_ be a live filesystem
(I mean you can't do that if /dev/hda1 is mounted, for example as
your root FS), if it is, you'll end up with a backup containing errors
(due to cache).

$ umount /dev/hda1
$ mount /dev/hdb1 /hdb
$ dd if=/dev/hda1 of=/hdb/backup

But if you want, you can also do this:
$ umount /dev/hda1 /dev/hdb1
$ dd if=/dev/hda1 of=/dev/hdb1

That way, /dev/hdb1 needs to be exactly the size of /dev/hda1

> 2) After copying using dd if=/dev/hda1 of=/hdb/backup
> how to retrive it back again in terms of directories and
> sub-directories and files.

Two solutions here:
 - you want to restore /dev/hda1 at the state it was at backup, then
   you dd if=/hdb/backup of=/dev/hda1 (Note that once again /dev/hda1
   must _not_ be mounted)
 - or you just want to access the backup. In this case you need
   a loop device:  mount -o loop /hdb/backup /mnt/backup
   You'll need loop support in your kernel (either built-in or
   module). That way, you can compare the FS against the backup,
   and/or restore part of it (by cp'ing files/directories).

Correct me where I'm wrong.

Regards,
Yann E. MORIN.

--
.---------------------------.----------------------.------------------.
|       Yann E. MORIN       |  Real-Time Embedded  | ASCII RIBBON /"\ |
| phone (+33/0) 299 055 231 |  Software  Designer  |   CAMPAIGN   \ / |
|   fax (+33/0) 299 055 221 °----------------------:   AGAINST     X  |
| yann.morin@atosorigin.com    www.atosorigin.com  |  HTML MAIL   / \ |
°--------------------------------------------------°------------------°



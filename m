Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269974AbUJTOMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269974AbUJTOMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270326AbUJTOJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:09:28 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:30591 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S269974AbUJTODo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:03:44 -0400
Message-ID: <028501c4b6ad$cb6a5f40$155110ac@hebis>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
Subject: File corruption report from SuSE 8/Opteron; Fw: MySQL Database Corruption (InnoDB), according to Innodb Hot Backup
Date: Wed, 20 Oct 2004 17:05:02 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I apologize that this problem report is vague, but this is the best we can
get about strange crashes and problems with Linux/AMD Opteron.

In this case, the platform is a dual Opteron machine running SuSE 8
Enterprise (64-bit). The file corruption might be associated with an LSI
RAID card. See below the emails from the MySQL mailing list.

I am the developer of InnoDB, which is a transactional engine under MySQL.
My general impression is that there a quite a few strange crash reports from
Linux/Opteron. I would be grateful if someone familiar with Linux kernels on
Opteron could enlighten us about the OS bug/hardware fault situation of that
platform. A brief Googling did not reveal much.

Best regards,

Heikki Tuuri
Innobase Oy
http://www.innodb.com

----- Alkuperäinen viesti ----- 
Lähettäjä: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
Vastaanottaja: <mysql@lists.mysql.com>
Lähetetty: Wednesday, October 20, 2004 4:31 PM
Aihe: Re: MySQL Database Corruption (InnoDB), according to Innodb Hot Backup


> David,
>
> ----- Alkuperäinen viesti ----- 
> Lähettäjä: "David Griffiths" <dgriffiths@boats.com>
> Vastaanottaja: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
> Kopio: <mysql@lists.mysql.com>
> Lähetetty: Tuesday, October 19, 2004 9:33 PM
> Aihe: Re: MySQL Database Corruption (InnoDB), according to Innodb Hot
Backup
>
>
> > No worries about the late reply.
> >
> > We took down the master, took a hot backup from the slave (I still need
> > to convert that 30-day license into a permanent one), moved it to the
> > master, started the master, and then took a hot backup and
> > re-initialized the slave. Took all of a few hours, and things are good.
> >
> > We did have some weird crashing issues with this machine while using an
> > LSI RAID card (RAID 5) - ie creating an index killed mysql. We switched
> > to a 3ware SATA card (almost as fast in RAID 0+1, and much cheaper even
> > with wasting more disk space for mirroring) and the problems
disappeared.
>
> good.
>
> > Unfort, this corruption occurred about 4 months into setting up
> > MySQL/Innodb - I hope we don't have to go through this every few months.
> > Taking an additional backup from the slave should give us extra
> redundancy.
> >
> > Corruption and weird crashes could be the result of specific
> > drivers/hardware and/or specific versions of Linux.
> >
> > Do you have any suggestions for tracking these issues, so that any
> > platform/distro issues can be avoided (and hopefully addressed by OEMs
> >and developers)??
>
> I will forward your message to the Linux kernel mailing list. There is
> little hope of tracking down what exactly is wrong with Opteron platforms.
> There have been quite many corruption issues with the ordinary 32-bit x86,
> too. For an unknown reason, x86 corruption became less frequent around the
> kernel 2.4.20.
>
> You can try reporting this problem to your hardware and OS vendors.
>
> The following thread contains some virtual memory page fault patch for
> AMD/Opteron:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0309.1/1091.html
> But I did not find information about what kind of bugs it can provoke in
> Linux.
>
> IBM has the Linux Test Project http://www.linuxtestproject.org. I think
> rigorous (and expensive) testing is the only way to improve the quality of
> Linux computers.
>
> > David
>
> Best regards,
>
> Heikki
> Innobase Oy
> InnoDB - transactions, row level locking, and foreign keys for MySQL
> InnoDB Hot Backup - a hot backup tool for InnoDB which also backs up
MyISAM
> tables
> http://www.innodb.com/order.php
>
> Order MySQL support from http://www.mysql.com/support/index.html
>
>
> > Heikki Tuuri wrote:
> >
> > >David,
> > >
> > >I am sorry for a late reply.
> > >
> > >The corruption clearly is in the ibdata file of the production
database.
> > >InnoDB Hot Backup checks the page checksums when it copies the ibdata
> files.
> > >
> > >Since CHECK TABLE fails, the corruption probably is in that table. You
> can
> > >try to repair the corruption by dump + DROP + reimport of that table.
> > >
> > >innodb_force_recovery cannot fix any kind of corruption.
> > >
> > >
> > >
> > >>InnoDB: Page lsn 3 1070601164, low 4 bytes of lsn at page end
1070609127
> > >>
> > >>
> > >
> > >The corruption has almost certainly happened in the OS or the hardware,
> > >because InnoDB checks page checksums before writing them to the ibdata
> > >files. Since the lsn stored at the page start differs from what is
> stamped
> > >at the page end, there is corruption at either end of the page. We have
> > >received quite a few reports of strange crashes in Opteron/Linux boxes.
> That
> > >suggests there are still OS bugs or hardware flaws in that platform.
> > >
> > >Best regards,
> > >
> > >Heikki
> > >Innobase Oy
> > >InnoDB - transactions, row level locking, and foreign keys for MySQL
> > >InnoDB Hot Backup - a hot backup tool for InnoDB which also backs up
> MyISAM
> > >tables
> > >http://www.innodb.com/order.php
> > >
> > >Order MySQL support from http://www.mysql.com/support/index.html
> > >
> > >
> > >......................
> > >From: David Griffiths (dgriffiths@boats.com)
> > >Subject: MySQL Database Corruption (InnoDB), according to Innodb Hot
> Backup
> > >This is the only article in this thread
> > >View: Original Format
> > >Newsgroups: mailing.database.myodbc
> > >Date: 2004-09-30 12:23:37 PST
> > >
> > >I went to do some work on our database last night (dropping large
> > >indexes, which can be time consuming). I checked to ensure that the
> > >backup of that evening had run, but noticed that the size of the backup
> > >was too small compared to previous days (I'm kicking myself for not
> > >emailing the results of the backup to myself every night - I just have
a
> > >job that verifies that the backup actually ran).
> > >
> > >So I ran the backup by hand. We have 8 data files, the first 7 being 4
> > >gig in size, and the last being a 10-meg autoextend. This is MySQL
> > >4.0.20 64bit, running on a dual Opteron machine running SuSE 8
> > >Enterprise (64-bit). We are using ibbackup 2.0 beta (which is 64-bit
for
> > >the Opteron).
> > >
> > >ibbackup (the Innodb backup utility) complains on the first file.
> > >
> > >ibbackup: Re-reading page at offset 0 3272818688 in
> > >/usr/local/mysql/var/ywdata1
> > >
> > >this repeats a few hundred times
> > >
> > >Then it dumps some ascii:
> > >
> > >040930 11:44:14  InnoDB: Page dump in ascii and hex (16384 bytes):
> > > len 16384; hex 55c3ee4d00030c4d00030c4c000374.....
> > >
> > >And at the bottom,
> > >
> > >040930 11:44:14  InnoDB: Page checksum 1522485550, prior-to-4.0.14-form
> > >checksum 1015768137
> > >InnoDB: stored checksum 1438903885, prior-to-4.0.14-form stored
checksum
> > >4028531590
> > >InnoDB: Page lsn 3 1070601164, low 4 bytes of lsn at page end
1070609127
> > >InnoDB: Page number (if stored to page already) 199757,
> > >InnoDB: space id (if created with >= MySQL-4.1.1 and stored already) 0
> > >InnoDB: Page may be an index page where index id is 0 680
> > >ibbackup: Error: page at offset 0 3272818688 in
> > >/usr/local/mysql/var/ywdata1 seems corrupt!
> > >
> > >While we no longer seem to have a backup, we do have a slave (not sure
> > >if the corruption propigated to the slave; I know it can happen in
> Oracle).
> > >
> > >I have a few questions:
> > >
> > >1) Is InnoDB backup correct? This might be a false positive (doubt it
> > >though).
> > >
> > >2) What are the risks of stopping and starting the database? There is a
> > >force-recovery option in inndb, which might fix the corruption. Note
> > >that I answered this myself. I ran a "check table" on one of our larger
> > >tables (600,000 rows) which killed the database. It came back up fine.
I
> > >re-ran the backup - same issue, with the same page checksums, etc.
> > >
> > >3) Anyone have any experience with this? Keep in mind that this might
be
> > >an Opteron/MySQL-64bit issue. Or it might be a general issue in MySQL.
> > >
> > >Thanks,
> > >David
> > >
> > >
> > >
> > >
> >
>


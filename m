Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSFBAgq>; Sat, 1 Jun 2002 20:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317088AbSFBAgp>; Sat, 1 Jun 2002 20:36:45 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:11525 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S317072AbSFBAgo>;
	Sat, 1 Jun 2002 20:36:44 -0400
Message-ID: <3CF96804.D25F623B@torque.net>
Date: Sat, 01 Jun 2002 20:34:12 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.19-pre9 and sym53c8xx problem
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Thalinger wrote:
> Since 2.4.19-pre8 cdrecord does not work anymore. It worked with -pre6,
> -pre7 i've missed, don't know about this one. Maybe i'll try it after
> this mail.
> 
> [root@sector17:/proc/scsi]# uname -a
> Linux sector17.home.at 2.4.19-pre9 #2 SMP Sat Jun 1 19:31:25 CEST 2002 
> i686 unknown
> [root@sector17:/proc/scsi]# cdrecord -scanbus
> Cdrecord 1.11a08 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
> cdrecord: No such file or directory. Cannot open '/dev/pg*'. Cannot open 
> SCSI driver.
> cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you are 
> root.

Christian,
What does the output of "cat /proc/scsi/sg/*" look like?

Cdrecord should see your plextor writer both as /dev/scd0
and /dev/sg0 (assuming you don't have any other scsi devices).
Cdrecord goes on to scan the parallel generic devices (i.e. /dev/pg*)
if it doesn't find anything suitable on its /dev/sg* scan.

Your post doesn't supply any information that would link
this problem with the sym53c8xxx driver. If there is some
problem then there will be some "noise" in the /var/log/messages
file [typically showing multiple scsi bus resets].

BTW The "-vv" switch (and/or "-VV") on cdrecord will yield more
debug information. strace may also be useful.

Doug Gilbert

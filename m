Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSLTUcW>; Fri, 20 Dec 2002 15:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSLTUcW>; Fri, 20 Dec 2002 15:32:22 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:65309 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S265039AbSLTUcU> convert rfc822-to-8bit; Fri, 20 Dec 2002 15:32:20 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Torben Frey'" <kernel@mailsammler.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Date: Fri, 20 Dec 2002 14:40:30 -0600
Message-ID: <002f01c2a868$0ab3b5d0$3b41d03f@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3E00C738.1070506@mailsammler.de>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope I'm not entering this discussion too late to be of help.

> We are running a 3ware Escalade 7850 Raid controller
> with 7 IBM Deskstar GXP 180 disks in Raid 5 mode, so
> it builds a 1.11TB disk.

Raid 0 is better in terms of speed.

> There's one partition on it, /dev/sda1, formatted
> with ReiserFS format 3.6.

Oh no! This is bad news, both in terms of speed and security.

Lumping everything into one partition makes it impossible to protect against
the SUID/GUID security vulnerability (security), and requires all reads and
writes to be funneled through one partition (speed). 

At an absolute MINIMUM, your partitions should be divided into:
/boot	032 MB
/tmp	512 MB
swap	1.5 - 3.0 times the amount of RAM,
	not to exceed a 2 GB per swap partition limit
/root	  5 GB
/var	 10 GB
/usr	20% of what is leftover
/home	50% of what is leftover,
	or at least 32 MB per user
/	30% of what is leftover

The above numbers are my recommendations for your 1.1 TB Raid Array ONLY.
Please don't flame me about how those numbers aren't right for everybody's
systems.

Additionally, in your case, I'd add a /data partition to store this huge
amount of rapidly generated data you're talking about.  That way, if you
should need to reformat, remount, whatever, the partition with the data, you
won't have to take down or redo the whole system.

> Or could it come from running an SMP kernel
> although I have only one CPU in my board?

This is a bad idea.  The SMP kernel includes a whole load of extra code
which is totally unnecessary in a Uniprocessor environment.  All that extra
code will do is slow down your system and take up extra memory.

Switch to a Uniprocessor kernel, or see my next point.

> The Board is an MSI 6501 (K7D Master) with 1GB RAM
> but only one processor.

Upgrade to 4 GB of RAM (if possible) and add a second processor (if
possible).

>From what you're telling me, you're going to need all the RAM you can get.

Further, SCSI really works better with two or more processors.  SCSI is
designed to take advantage of multiple processors.  If you're not running
multiple processors, you might as well be running IDE, IMHO.

> Watching vmstat 1 shows me that "bo" drops quickly
> down from rates in the 10 or 20 thousands to low rates
> of about 2 or 3 thousands when the runs take so long.

I'm willing to bet that your system is spending all of its time flushing the
buffers.  When you're generating gigabytes of data, your buffers are going
to need to be huge.

I have no idea how to do this.

Hope this helped.

Joseph Wagner


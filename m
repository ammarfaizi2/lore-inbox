Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbRCHMHw>; Thu, 8 Mar 2001 07:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131343AbRCHMHm>; Thu, 8 Mar 2001 07:07:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61707 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131341AbRCHMH0>; Thu, 8 Mar 2001 07:07:26 -0500
Subject: Re: Linux kernel - and regular sync'ing?
To: dushaw@munk.apl.washington.edu (Brian Dushaw)
Date: Thu, 8 Mar 2001 12:09:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org,
        dushaw@munk.apl.washington.edu (Brian Dushaw)
In-Reply-To: <Pine.LNX.4.30.0103071959050.17257-100000@munk.apl.washington.edu> from "Brian Dushaw" at Mar 07, 2001 08:21:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14azEv-0002qR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> at irregular intervals of 10-30 seconds, most likely calls to sync, so
> that the disk never gets to sleep for long.  I've followed advice in the
> various HOWTO's, e.g. modifying the line "ud::once:/sbin/update" in
> /etc/inittab to only sync once an hour, to no avail.  Watching "top", it

Thats actually I think poor advice - it wont help and its asking to lose data

>    Can you offer me any advice?  Any tweeks I can make to tell the system
> that sync'ing only once every 5 minutes is o.k.?

You machine can sync continually - providing it isnt writing data. The real
question is not 'why is it syncing' but 'what is it syncing'.

The normal answer is file access times, and you can turn those off with the
noatime mount option.

To quote the linux on palmax page

   For startup my /etc/rc.d/rc.local contains the following lines.
mount -o remount,rw,noatime /
/sbin/hdparm -S 15 /dev/hda

   The  "noatime"  setting  turns off the writing back of 'last accessed'
   times  to  files. This means reading/opening files does not cause disk
   wakeups.  The  hdparm -S 15 command sets the disk to spin down after 1
   minute  15 seconds (you can play with the value).

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280922AbRKLT5q>; Mon, 12 Nov 2001 14:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280949AbRKLT5h>; Mon, 12 Nov 2001 14:57:37 -0500
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:6404 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S280922AbRKLT52>;
	Mon, 12 Nov 2001 14:57:28 -0500
Date: Mon, 12 Nov 2001 20:55:51 +0100
From: Frank de Lange <lkml-frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: Abysmal interactive performance on 2.4.linus
Message-ID: <20011112205551.A14132@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a 768 MB SMP box (2x466 MHz Celeron), I see some weird problems with
interactive performance on 2.4.15pre{1,2}. A good example of this is the
following scenario:

 - copy a large file (eg. an iso image file) to a directory on the same
   (reiserfs in this case) filesystem, or...
 - do a filesystem comparison between a CD and the original file (with cmp
   /mnt/cdrom/<filename> /mnt/reiserfs/1/data/<original_file_location>, using a
   PLEXTOR Model: CD-ROM PX-40TS SCSI CD-ROM drive),

 - and THEN (while the copy or comparison runs) try any simple command (like
   'ls /mnt/reiserfs/1/data' or 'top' or anything else...). 

Response time is abysmal, a simple 'ls /some/dir' takes tens of seconds to
start. Once the command is running, performance is normal. Try this when a
cdrecord session is running and you'll get a buffer underrun.

The box has 768 MB of RAM, 512 MB of swap. There is no significant load on the
system (according to an already running copy of top) neither before nor during
the test. Try tab-completing a command in a terminal, and that terminal freezes
for tens of seconds, usually until after the file system load has gone down.

In a few words, heavy filesystem activity seems to wreak havoc on the system.
Not by loading the CPU (it hardly breaks out a sweat at 178% idle (SMP...)).

Turning off swap (swapoff -a) does not change the observed behaviour.

Anyone else seen something like this?

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \ lkml-frank@unternet.org  /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]

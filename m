Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282707AbRL0VqP>; Thu, 27 Dec 2001 16:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282705AbRL0VqG>; Thu, 27 Dec 2001 16:46:06 -0500
Received: from mail.zmailer.org ([194.252.70.162]:50048 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S282693AbRL0Vp7>;
	Thu, 27 Dec 2001 16:45:59 -0500
Date: Thu, 27 Dec 2001 23:45:42 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Bug? 2.4.17-rc1 RAID1, SMP, 750MB+ -> hangups...
Message-ID: <20011227234542.C1072@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had problems with  2.4.17-rc1, but also with
2.4.10-ac1, and few others in between.


System with problems:
  2.4.17-rc1, 2.4.10
  Dual P-III 750 MHz
  750 MB (or 1024 MB)
  SCSI disks with RAID1 mirroring of all partitions (including swap)
  (Had IDE-disks in previous incarnation, same behaviour.)
  EXT3
  Some 410 000 files in filesystems
  (no cmdline parameters)
    --> hangups


Systems without (apparently) problems:
  2.4.17 (release)
  Dual P-II 266 MHz
  256 MB
  IDE disks with RAID1 mirroring of all partitions (including swap)
  (these disks were used at the trouble machine)
  EXT3
  Some 130 000 files in filesystems
  (no cmdline parameters)
     --> works

  rh2.4.16-0.9custom
  Dual P-III 800 MHz
  512 MB
  IDE disks with RAID1 mirroring of all partitions (including swap)
  EXT2
  Some 1.2 million files in filesystems
  (no cmdline parameters)
     --> works
  
  2.4.10
  Dual PPro200
  128 MB
  IDE disks wirth RAID1 mirroring of all partitions (including swap)
  EXT2
  Some 200 000 files in filesystems
  ("noapic" -- machine has faulty MP dataset)
     --> works


Elsewere talking about the problems, I got a comment that the problem
does appear with largeish memory SMP machines with RAID1 (mirror)
disks, and the problem seem to go away when "noapic" option is used
forcing all IO interrupts to fall into one processor.

As I understood, 2.4.9 does not exhibit this problem, but 2.4.10 thru
2.4.13 do,  the commentator returned to 2.4.9 for production systems...
Apparently the problem appears all the way thru to 2.4.17.

The problem appears as complete hungup of the system, when something
is run at 4:00 - 4:20 AM by cron (at a RedHat system: updatedb, and/or
"catman -w", and/or ...)

Machine attached keyboard can not command anything when the hangup
has happened.  Configured magic-sysrq doesn't work during hangup.

Problem machine is now being run with: "noapic nosmp nmi_watchdog=1"
which may (or may not) help.   Seen comments give an impression,
that "nosmp" could be removed, as long as "noapic" is present for
stable operation.


I can't test the problem, the machine now running in forced
uniprocessor mode is mission-criticalish box, and anyway trying
to trigger the problem does appear rather difficult -- besides
of it being nearly guaranteed to happen at 4 AM - if not tonight,
within 2-3 nights anyway.


/Matti Aarnio  <matti.aarnio@zmailer.org>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319121AbSIJNv7>; Tue, 10 Sep 2002 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319122AbSIJNv7>; Tue, 10 Sep 2002 09:51:59 -0400
Received: from angband.namesys.com ([212.16.7.85]:1152 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S319121AbSIJNv6>; Tue, 10 Sep 2002 09:51:58 -0400
Date: Tue, 10 Sep 2002 17:56:39 +0400
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu, axboe@suse.de, andre@linux-ide.org
Subject: 2.5.34 BUG at kernel/sched.c:944 (partitions code related?)
Message-ID: <20020910175639.A830@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    Starting with yesterday I am seeing kernel BUG at sched.c:944 
    on 2.5.3[34], I've seen similar report for 2.5.31 in the list with no
    responces, however 2.5.31 was working fine for me.

    Stack trace for the BUG was entirely within idle task (default_idle,
    rest_init, cpu_idle, ...)

    It explodes immediatelly after printing:
 hda: hda1 hda2 hda3 hda4 < hda5

    Then panics trying to kill interrupt handler.

    On 2.4 this partition layout looks like this:
 hda: [PTBL] [7476/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 >

   Box itself is Dual Athlon MP 1700+. IDE only, 1G RAM, highmem enabled.

   Other strange thing that caught my attention is this, if in 2.5.31 I had
   this order or disk detection:
<4>hda: IC35L060AVER07-0, ATA DISK drive
<4>hdb: IC35L060AVER07-0, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hda: host protected area => 1
<6>hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
<4>hdb: host protected area => 1
<6>hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
<6> hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
<6> hdb: hdb1

   Now it does it in reverse like this:
hdb: host protected area => 1
hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
hdb: hdb1
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
hda: hda1 hda2 hda3 hda4 < hda5PANIC

   Is anybody interested in more information/whatever?

Bye,
    Oleg

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSKTTmP>; Wed, 20 Nov 2002 14:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSKTTmO>; Wed, 20 Nov 2002 14:42:14 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:46721 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S262448AbSKTTmM>; Wed, 20 Nov 2002 14:42:12 -0500
Date: Wed, 20 Nov 2002 20:49:14 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.5.48-bk1
Message-ID: <20021120194914.GA3360@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've tried that kernel on my box - amd thunderbird 1.2GHz, MB asus a7v, 512mb
ram. Promise 20265 ata100 controler with seagate ST380021A as hda, ibm
IBM-DTLA-307045 as hdc. I've ide=reverse to have promse as ide0 and ide1.

I've enabled ata tag queuing and kernel locks up when reading partition from
hdc. Without enabling that kernel boots but when I viewed /proc/net/dev I've got
this:

kernel: Call Trace:
Nov 20 17:41:18 hell kernel:  [real_lookup+46/272] real_lookup+0x2e/0x110
Nov 20 17:41:18 hell kernel:  [do_lookup+282/368] do_lookup+0x11a/0x170
Nov 20 17:41:18 hell kernel:  [link_path_walk+1005/1936] link_path_walk+0x3ed/0x
790
Nov 20 17:41:18 hell kernel:  [open_namei+128/1024] open_namei+0x80/0x400
Nov 20 17:41:18 hell kernel:  [proc_destroy_inode+27/32] proc_destroy_inode+0x1b
/0x20
Nov 20 17:41:18 hell kernel:  [filp_open+67/112] filp_open+0x43/0x70
Nov 20 17:41:18 hell kernel:  [sys_open+91/144] sys_open+0x5b/0x90
Nov 20 17:41:18 hell kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


and this one in infinite recursion ended with kernel panic.
Nov 20 17:41:18 hell kernel: Call Trace:
Nov 20 17:41:18 hell kernel:  [schedule+758/768] schedule+0x2f6/0x300
Nov 20 17:41:18 hell kernel:  [schedule_timeout+177/192] schedule_timeout+0xb1/0
xc0
Nov 20 17:41:18 hell kernel:  [tty_poll+129/176] tty_poll+0x81/0xb0
Nov 20 17:41:18 hell kernel:  [do_select+271/576] do_select+0x10f/0x240
Nov 20 17:41:18 hell kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Nov 20 17:41:18 hell kernel:  [sys_select+742/1248] sys_select+0x2e6/0x4e0
Nov 20 17:41:18 hell kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


I'm using ide-scsi emulation with start paramerer
hde=ide-scsi 

Nov 20 17:28:38 hell kernel: SCSI subsystem driver Revision: 1.00
Nov 20 17:28:38 hell kernel: ERROR: This is not a safe way to run your SCSI host
Nov 20 17:28:38 hell kernel: ERROR: The error handling must be added to this dri
ver
Nov 20 17:28:38 hell kernel: Call Trace:
Nov 20 17:28:38 hell kernel:  [scsi_register+739/752] scsi_register+0x2e3/0x2f0
Nov 20 17:28:38 hell kernel:  [put_driver+37/144] put_driver+0x25/0x90
Nov 20 17:28:38 hell kernel:  [idescsi_detect+34/128] idescsi_detect+0x22/0x80
Nov 20 17:28:38 hell kernel:  [scsi_register_host+51/208] scsi_register_host+0x3
3/0xd0
Nov 20 17:28:38 hell kernel:  [init+53/352] init+0x35/0x160
Nov 20 17:28:38 hell kernel:  [init+0/352] init+0x0/0x160
Nov 20 17:28:38 hell kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0
x5/0x18

Is it ok?

-- 
Luká¹ Hejtmánek

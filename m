Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLDIbz>; Mon, 4 Dec 2000 03:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLDIbp>; Mon, 4 Dec 2000 03:31:45 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:9491 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129183AbQLDIb3>; Mon, 4 Dec 2000 03:31:29 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 4 Dec 2000 09:00:49 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.0test11: some issues and a possible show stopper
Message-ID: <3A2B5D39.24615.34797F@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the article in the German computer magazine c't that Linux 2-4 
is scheduled for release in December, and that Linux complained people 
do not want to test the new kernel, I decided to test it.

The Hardware was: Spacewalker/Shuttle AV11 (VIA Apollo Pro chipset), 
Intel Celeron-500 ("boxed"), 128MB PC133 SD-ROM (Infineon, no crap),
EIDE IBM hardisk (4GB, supporting UDMA 33).

[If you need more detail, I can provide them]

First the lesser important issues:

During config I noticed that documentation is missing for CONFIG_INPUT 
(which is later required for USB), CONFIG_NLS_UTF8 (which is probably 
even less clear as 88591 or CP850).

Some source files produced an assembler warning about an Indirect lcall 
without '*'

When booting, the kernel said
"Unknow bridge resource 0; assuming transparent". I don't know what 
this means.

When typing "cat /proc/kmsg" I noticed that the process is not 
interuptible.

Loading the keymap failed, but it seems SuSE Linux 7.0 is not quite 3.4-
ready (util-linux, modutils, e2fsprogs too old).

I also got "EXT2 check option not supported", "can't locate module 
"vfat", probably because of old modutils however).

During some heavy disk I/O I got the impression that buffer writes are 
delayed significantly, and that reading can be delayed by several 
seconds when there is "writing back dirty buffers".

Finally I got a "gzip -t" CRC error on the kernel tar archive that was 
without error when tried with 2.2.17. This is the possible show 
stopper. The syslog messages did not report any problem (harddisk 
operating in UDMA 33 mode, using a proper cable).

Documentation/sysctl/kernel.txt still is 2.2.10!

After hacking the kernel I got a conflict between <linux/spinlock.h> 
and <asm/spinlock.h>, but it was too late to investigate. (I had done 
over 4 hours merging rejected diffs, and I was tired from pressing C-d 
C-d C-n in Emacs ;-))

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

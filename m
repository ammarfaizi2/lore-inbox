Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbTAPHti>; Thu, 16 Jan 2003 02:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbTAPHti>; Thu, 16 Jan 2003 02:49:38 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:24079 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S263837AbTAPHtg>; Thu, 16 Jan 2003 02:49:36 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Thu, 16 Jan 2003 08:58:20 +0100
MIME-Version: 1.0
Subject: dosemu causes "invalid operand" in system_call
Message-ID: <3E26740D.28818.344BEC@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.13/Sophos-3.65+2.10+2.03.098+06 January 2003+79043@20030116.075026Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a bug report for SuSE-8.1, featuring a 2.4.19 variant of the kernel. Maybe it's 
interesting anyway. When contacting SuSE, you might refer to SuSE's bug #22913...

---------begin screen shot----------
Linux DOS emulator 1.0.2.0 $Date: 2001/06/10 $
Last configured at Wed Sep 11 16:40:24 UTC 2002 on linux
DPMI-Server Version 0.9 installed

DOS called with UMB,HIGH
DOSEMU ? detected XMS driver at f800:0000
Kernel: allocated 6 Diskbuffers = 3156 Bytes in HMA
/usr/bin/dosemu: line 327:  1112 Speicherzugriffsfehler  
$DOSEMU_BIN_PATH/bin/dosemu.bin $XFLAG --Flibdir $BOOT_DIR_PATH/conf --Fimagedir 
$BOOT_DIR_PATH -f $BOOT_DIR_PATH/conf/dosemurc $OPT_I $STRING_I -O $@ 
2>$BOOT_DIR_PATH/boot.log
------------end screen shot--------

When trying to run a DOS device driver for a serial device in DOSEMU
1.0.2, the dosemu process unexpectedly died (obviously when loading
the device driver). Only later I dicovered that a kernel oops was
generated every time as well. Here is the OOPS:

Jan 11 21:01:59 elf kernel: invalid operand: 0000 2.4.19-4GB #1 Fri Sep 13 13:14:56 UTC 
2002
Jan 11 21:01:59 elf kernel: CPU:    0
Jan 11 21:01:59 elf kernel: EIP:    0000:[<00000053>]    Not tainted
Jan 11 21:01:59 elf kernel: EFLAGS: 00030206
Jan 11 21:01:59 elf kernel: eax: 000000db   ebx: 000030b6   ecx: 00002a06   edx: 
00003098
Jan 11 21:01:59 elf kernel: esi: 00000011   edi: 00000001   ebp: 000030a8   esp: 
c9ae7f24
Jan 11 21:01:59 elf kernel: ds: 0000   es: 0000   ss: 0018
Jan 11 21:01:59 elf kernel: Process dosemu.bin (pid: 1734, stackpage=c9ae7000)
Jan 11 21:01:59 elf kernel: Stack: 00003088 00009cec 00009cec 00000000 00000000 
00000000 00000000 00000000 
Jan 11 21:01:59 elf kernel:        00000003 00000000 00088108 00000000 00000000 
00000000 00000000 00000000 
Jan 11 21:01:59 elf kernel:        000000c0 00000000 00001000 00000000 00000000 
00000000 00000000 00000000 
Jan 11 21:01:59 elf kernel: Call Trace:    [system_call+51/64]
Jan 11 21:01:59 elf kernel: Call Trace:    [<c0108e63>]
Jan 11 21:01:59 elf kernel: Code:  Bad EIP value.

Here is the last part of the dosemu boot.log:
Running unpriviledged in low feature mode
kernel CPU speed is 501000143 Hz
Running on CPU=586, FPU=1
using stderr for debug-output
debug flags: +a
debug flags: +dARWDCvXkiTsm#pQgcwhIExMnPrSgZ
INT21: rv_all: 0 + 1 = 1
CONF: config variable parser_version_3 set
...
CONF: mostly running as USER: uid=500 (cached 500) gid=100 (cached 100)
TIMER: using new gettimeofday with microsecond resolution
DBG_FD already set
MAPPING: got IPC shm mem pool: id=229377, addr=0x40271000 size=1008000
MAPPING: using the IPC shared memory mapping driver
DOSEMU-1.0.2.0 is coming up on Linux version 2.4.19-4GB
CONF: reserving 640Kb at 0x00000 for 'd' (Base DOS memory (first 640K))
CONF: reserving 64Kb at 0xF0000 for 'r' (Dosemu reserved area)
...
SERIAL $Header: /usr/src/dosemu0.60/serial/RCS/ser_init.c,v 1.1 1995/05/06 16:26:19 
root Exp root $
SER: Running serial_init, 0 serial ports
...
MFS: Close file 9 (/home/windl/dosemu/drives/c/spmdriv/spmdriv.sys)
MFS: Handle cnt 1
MFS: Close file succeeds
MFS: close: not setting file date/time
MFS: Finished dos_fs_redirect
INT21 (0) at c010:019f: AX=0900, BX=30b4, CX=0001, DX=002d, DS=c010, ES=9cec
int 0x21, ax=0x0900
Doing REP insb(0x3096) 1 bytes at 0x9cec0, DF 0
PORTb: 3096 not available for read

Unfortunately I cannot supply the driver in question, because it's
copyrighted.

Regards,
Ulrich Windl


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSGGKcs>; Sun, 7 Jul 2002 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSGGKcs>; Sun, 7 Jul 2002 06:32:48 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:63922 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314938AbSGGKcr>; Sun, 7 Jul 2002 06:32:47 -0400
Date: Sun, 7 Jul 2002 12:53:17 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ata_special_intr, ide_do_drive_cmd deadlock
Message-ID: <Pine.LNX.4.44.0207071251530.1441-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trace is quite nice on this one.

CPU:    0
EIP:    0010:[<c024d7f3>]    Not tainted
EFLAGS: 00000086
eax: c0455d9c   ebx: c15d2d34   ecx: 00000000   edx: cdfcdd24
esi: c0455ee4   edi: c0455ed0   ebp: c0455ee4   esp: cdfcdcbc
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 668, threadinfo=cdfcc000 task=cee0ed00)
Stack: 00000046 00000000 00000001 dead4ead cdfcdcec cdfcdcec ff5aff5a ff5aff5a 
       ff5aff5a 00000000 00000001 dead4ead cdfcdcec cdfcdcec ff5aff5a ff5aff5a
       ff5aff5a c0455ed0 c0455ed0 cdfcdd8c 00000088 c024d7ed c0455ed0 cdfcdd24
Call Trace: [<c024d7ed>] [<c011cefe>] [<c024f641>] [<c024d590>] [<c024cef3>]
   [<c024d021>] [<c024f8ba>] [<c024fd47>] [<c024fe13>] [<c0230d89>] [<c023113d>] 
   [<c0146ae1>] [<c0146bf8>] [<c0134a5f>] [<c0134f80>] [<c013507c>] [<c0134f80>] 
   [<c014999c>] [<c0107efa>] [<c0149bea>] [<c01075ab>] 

Code: 80 3b 00 f3 90 7e f9 e9 c1 fc ff ff 80 3b 00 f3 90 7e f9 e9 

>>EIP; c024d7f3 <.text.lock.ide_taskfile+0/1d>   <=====
Trace; c024d7ed <ide_raw_taskfile+4d/53>
Trace; c011cefe <printk+1ae/210>
Trace; c024f641 <do_recalibrate+51/70>
Trace; c024d590 <ata_special_intr+0/210>
Trace; c024cef3 <ata_busy_poll+23/70>
Trace; c024d021 <ata_status_poll+a1/c0>
Trace; c024f8ba <start_request+ca/220>
Trace; c024fd47 <queue_commands+e7/170>
Trace; c024fe13 <do_request+43/70>
Trace; c0230d89 <generic_unplug_device+119/170>
Trace; c023113d <blk_run_queues+13d/150>
Trace; c0146ae1 <do_page_cache_readahead+161/180>
Trace; c0146bf8 <page_cache_readahead+f8/100>
Trace; c0134a5f <do_generic_file_read+7f/3c0>
Trace; c0134f80 <file_read_actor+0/80>
Trace; c013507c <generic_file_read+7c/130>
Trace; c0134f80 <file_read_actor+0/80>
Trace; c014999c <vfs_read+9c/160>
Trace; c0107efa <common_interrupt+22/28>
Trace; c0149bea <sys_read+2a/40>
Trace; c01075ab <syscall_call+7/b>
Code;  c024d7f3 <.text.lock.ide_taskfile+0/1d>
00000000 <_EIP>:
Code;  c024d7f3 <.text.lock.ide_taskfile+0/1d>   <=====
   0:   80 3b 00                  cmpb   $0x0,(%ebx)   <=====
Code;  c024d7f6 <.text.lock.ide_taskfile+3/1d>
   3:   f3 90                     repz nop
Code;  c024d7f8 <.text.lock.ide_taskfile+5/1d>
   5:   7e f9                     jle    0 <_EIP>
Code;  c024d7fa <.text.lock.ide_taskfile+7/1d>
   7:   e9 c1 fc ff ff            jmp    fffffccd <_EIP+0xfffffccd> c024d4c0 <ide_do_drive_cmd+e0/1b0>
Code;  c024d7ff <.text.lock.ide_taskfile+c/1d>
   c:   80 3b 00                  cmpb   $0x0,(%ebx)
Code;  c024d802 <.text.lock.ide_taskfile+f/1d>
   f:   f3 90                     repz nop
Code;  c024d804 <.text.lock.ide_taskfile+11/1d>
  11:   7e f9                     jle    c <_EIP+0xc> c024d7ff
<.text.lock.ide_taskfile+c/1d>
Code;  c024d806 <.text.lock.ide_taskfile+13/1d>
  13:   e9 00 00 00 00            jmp    18 <_EIP+0x18> c024d80b
<.text.lock.ide_taskfile+18/1d>

--
function.linuxpower.ca


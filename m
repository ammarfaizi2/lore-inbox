Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTAAWsE>; Wed, 1 Jan 2003 17:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbTAAWsE>; Wed, 1 Jan 2003 17:48:04 -0500
Received: from mx7.mail.ru ([194.67.57.17]:22800 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id <S265134AbTAAWsD>;
	Wed, 1 Jan 2003 17:48:03 -0500
Date: Wed, 1 Jan 2003 23:55:34 +0100 (CET)
From: Guennadi Liakhovetski <lyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Oops 2.4.20 + ppp + ide-scsi / usb
Message-ID: <Pine.LNX.4.44.0301012306380.3378-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This is not the first time I'm getting an Oops with 2.4.20 and they always
seem to appear when ppp is active AND another activity takes place. This
time it was reading a CD over the IDE-SCSI driver (I was trying to verify
the error reported earlier on this list - see Subj. "ide-scsi CD-recorder
error reading burned disks"). But earlier I saw these Oopses before I even
installed the CD-Writer, before I had them when using a USB-printer, while
also testing ppp. For some reason, it always happens when I am using
"local" ppp - over a null-modem, but not when dialing a provider. These
Oopses happen in the interrupt handler, so, I have to copy the
Oops-message manually. I could use a serial terminal, but I need ppp to
trigger them:-) ...and these modern boxes only have 1 serial port:-(

So, after re-typing the Oops and running ksymoops (after restoring the
original module configuration), I've got the following:

ksymoops 2.4.3 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)
Oops: 0000
CPU:    0
EIP:    0010:[<c8b597f8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c26c3ec0   ebx: c02ae448   ecx: c61901c0   edx: c61901c0
esi: 00000000   edi: c02ae448   ebp: c0271e7c   exp: c0271e5c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0271000)
Stack: c02ae448 c02ae404 c02ae448 c0271e88 c01b164b 000010c6 00000000 c26c3ec0
       c0271e90 c8b599ca c02ae448 00000000 00000000 c0271ec0 c01b19f5 c02ae448
       c61901c0 00000000 c61901c0 c02ae404 c02ae448 00000000 c02ae404 00000000
Call Trace:    [<c01b164b>] [<c8b599ca>] [<c01b19f5>] [<c0115ff8>] [<c01b1d42>]
  [<c01b200f>] [<c01b1e70>] [<c011d598>] [<c0119fac>] [<c0119ed9>] [<c0119cbb>]
  [<c01082dd>] [<c0105240>] [<c0105240>] [<c010a5b8>] [<c0105240>] [<c0105240>]
  [<c0105266>] [<c01052e2>] [<c0105000>] [<c010502a>]
Code: 8b 56 18 c7 45 f4 00 00 00 00 89 70 04 8b 46 1c c7 46 10 00

>>EIP; c8b597f8 <[ide-scsi]idescsi_issue_pc+18/1a0>   <=====
Trace; c01b164a <ide_wait_stat+ba/110>
Trace; c8b599ca <[ide-scsi]idescsi_do_request+4a/60>
Trace; c01b19f4 <start_request+194/200>
Trace; c0115ff8 <printk+108/120>
Trace; c01b1d42 <ide_do_request+272/2c0>
Trace; c01b200e <ide_timer_expiry+19e/1b0>
Trace; c01b1e70 <ide_timer_expiry+0/1b0>
Trace; c011d598 <timer_bh+248/360>
Trace; c0119fac <bh_action+1c/50>
Trace; c0119ed8 <tasklet_hi_action+48/70>
Trace; c0119cba <do_softirq+4a/a0>
Trace; c01082dc <do_IRQ+9c/b0>
Trace; c0105240 <default_idle+0/30>
Trace; c0105240 <default_idle+0/30>
Trace; c010a5b8 <call_do_IRQ+6/e>
Trace; c0105240 <default_idle+0/30>
Trace; c0105240 <default_idle+0/30>
Trace; c0105266 <default_idle+26/30>
Trace; c01052e2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Trace; c010502a <rest_init+2a/30>
Code;  c8b597f8 <[ide-scsi]idescsi_issue_pc+18/1a0>
00000000 <_EIP>:
Code;  c8b597f8 <[ide-scsi]idescsi_issue_pc+18/1a0>   <=====
   0:   8b 56 18                  mov    0x18(%esi),%edx   <=====
Code;  c8b597fa <[ide-scsi]idescsi_issue_pc+1a/1a0>
   3:   c7 45 f4 00 00 00 00      movl   $0x0,0xfffffff4(%ebp)
Code;  c8b59802 <[ide-scsi]idescsi_issue_pc+22/1a0>
   a:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c8b59804 <[ide-scsi]idescsi_issue_pc+24/1a0>
   d:   8b 46 1c                  mov    0x1c(%esi),%eax
Code;  c8b59808 <[ide-scsi]idescsi_issue_pc+28/1a0>
  10:   c7 46 10 00 00 00 00      movl   $0x0,0x10(%esi)

 <0>Kernel panic: Aiee, killing interrupt handler!

5 warnings issued.  Results may not be reliable.

Thanks
Guennadi
---
Guennadi Liakhovetski






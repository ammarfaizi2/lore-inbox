Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTFKNrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 09:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTFKNrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 09:47:37 -0400
Received: from d-216-195-190-132.metrocast.net ([216.195.190.132]:16753 "EHLO
	timemachine.dsbcpas.com") by vger.kernel.org with ESMTP
	id S261741AbTFKNrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 09:47:23 -0400
Message-ID: <3EE73622.3070704@dsbcpas.com>
Date: Wed, 11 Jun 2003 10:01:06 -0400
From: scott <scott@dsbcpas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PATCH: dpt_i2o memory leak comments
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adaptec 2400A

Hi Mark (mark_salyzyn@adaptec.com),

Sorry to report that the test rpm you sent me last week did not solve 
our high load kernel panic crash problem we are experiencing, RH 
distribution of kernel 2.4.20-13.7smp.

I have been keeping better score of what happens and I can recreate the 
problem by running our search engine indexer in thread mode. Ksymoops 
and screen dumps by most recent date follow.  My rookie observation is 
that the 6.3.2003 kernel panic is a bit different then the older 5.29.03 
crash, but he ksymoops are similar.

Thank you for looking at this.

Very Truly Yours,
Scott

Your RPM was applied 6.7.2003. System is an Athlon dual 1800 mps on an 
Asus A7M266-D main board.

*Crash of 6.7.2003 AFTER your rpm was applied:

*_/Ksymoops Report after reboot:/ (6.7.2003)_
ksymoops 2.4.4 on i686 2.4.20-13.7smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-13.7smp/ (default)
     -m /boot/System.map-2.4.20-13.7smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/dpt_i2o.o) for dpt_i2o
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a 
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module dpt_i2o to a 
unique module object.  Trace may not be reliable.
Reading Oops report from the terminal

_/Kernel panic screen dump: /__(6.7.2003)_

EIP is at __scsi_end_request [scsi_mod] 0xa4(2.4.20-13.7smp)

eax: d9e7dde0 ebx 00000008 ecx:00400000  edx: 00000000

esi:f7fc8268 edi: 00400000  ebp: 00000000  esp:f6a9feb0

ds:0018  es:0018 ss:0018
Process mysqld (pid: 1702, stackpage=f6a9f000)
Stack:     c3679618 f7fc8200 e3e52000 e3e52000 00000008
    f88154c8 f7fc8200 00000001 00000008 00000001
    00000001 f67ff234 00000000 f6a9ff3c
    f7fc82b8 c3679618 00000008 00000000 00000001
    00000008 00000000 f7fc8200 00000008 00000001

Call Trace: [<f88154c8>] scsi_io_completion_rsmp.6cd6
f415 [scsi_mod] 0x208 (0xf6a9fec4))

[<f8829de3>] rw_intr [sd_mod] 0x243 (0xf6a9ff10))
[<f8831155>] adpt_i2o_to_scsi [dpt_i2o] 0x3a5(0xf6a9ff2c))
[<f880e2ff>] scsi_finish_command [scsi_mod] 0xcf (0xf6a9ff44))
[<f880e08f>] scsi_bottom_half_handler [scsi_mod] 0xbf (0xf6a9ff5c))
[<c012110b>] bh_action [kernel] 0x4b (0xf6a9ff6c))
[<c0120fd0>] tasklet_hi_action [kernel] 0x60 (0xf6a9ff74))
[<c0120d6b>] do_softirq [kernel] 0x7b (0xf6z9ff8c))
[<c010a7de>] do_IRQ [kernel] 0xfe (0xf6a9ffa8))

Code:0f b7 41 08 66 c1 e8 09 0f b7 c0 39 c2 89 46 38 89 46 3c 73

<0> Kernel panic : Aiee, killing interupt handler!
In interupt handler - not syncing


*Crash of 6.3.2003 BEFORE your rpm was applied:*

_/Ksymoops Report after reboot:/ (6.3.2003)_
ksymoops 2.4.4 on i686 2.4.20-13.7smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-13.7smp/ (default)
     -m /boot/System.map-2.4.20-13.7smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/dpt_i2o.o) for dpt_i2o
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a 
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module dpt_i2o to a 
unique module object.  Trace may not be reliable.
Reading Oops report from the terminal

_/Kernel panic screen dump: /__(6.3.2003)_

EIP is at timer_bh [kernel] 0x1ff (2.4.20-13.7smp)
eax: c03a4584   ebx: c03a4584   ecx:d9fda278   edx: 00000000
esi: c03a454c   edi: f7a2223c   ebp: c03a436o   esp: f7fbdf00
ds: 0018   es: 0018   ss:0018
Process swapper (pidi 0, stackpage=f7fbd000)
Stack:  c023e914 f7fbdf0c 00000001 f7fbdf0c f7fbdf0c
    00000000 00000001 00000040 00000000 c012110b
    c03a3880 c0120fd0 00000000 00000001 c0377940
    fffffffe 00000001 c0120d6b c0377940 00000046
    00000001 c0370800 00000000 c03026c8

Call trace:     [<c012110b>] bh_action [kernel] 0x4b (0xf7fbdf24))
        [<c0120fd0>] tasklet_hi_action [kernel] ox6o (0xf7bdf2c))
        [<c0120d6b>] do_softirq [kernel] ox7b (oxf7fbdf44))
        [<c010a7de>] do_irq [kernel] 0xfe (0xf7fbdf60))
        [<c0106df0>] default_idle [kernel] 0x0 (0xf7fbdf68))
        [<c0106df0>] default_idle [kernel] 0x0 (0xf7fbdf74))
        [<c0106df0>] default_idle [kernel] 0x0 (0xf7fbdf7c))
        [<c0106df0>] default_idle [kernel] 0x0 (0xf7fbdf90))
        [<c0106df0>] default_idle [kernel] 0x2c (0xf7fbdfa4))
        [<c0106eb2>] cpu_idle [kernel] 0x52 (0xf7fbdfb0))
        [<c011c4e9>] call_console_drivers [kernel] oxe9 (0xf7fbdfe0))

Code:     8b 02 89 58 04 89 53 04 89 1a 89
    fb 39 f3 0f 85 2b ff

<0> kernel panic: Aiee, killing interrupt handler! 
In interrupt handler - not syncing


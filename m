Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314194AbSDQXV2>; Wed, 17 Apr 2002 19:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314196AbSDQXV1>; Wed, 17 Apr 2002 19:21:27 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:44534 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S314194AbSDQXVZ>;
	Wed, 17 Apr 2002 19:21:25 -0400
Message-ID: <02ac01c1e666$95ddac70$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Dave Jones" <davej@suse.de>
Cc: "Martin Dalecki" <dalecki@evision-ventures.com>,
        "Jens Axboe" <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.8-dj1 reading /proc/ide/.../identify
Date: Wed, 17 Apr 2002 19:21:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following oops is reproducable on 2.5.8-dj1 here.

cat /proc/ide/ide0/hda/identify a few times and *bang*.

The system usually takes one more command after the oops,
then locks solid. The oops never makes it to syslog.

--Adam

ksymoops 2.4.1 on i686 2.5.8-dj1+smpboot-fix.  Options used
     -v /usr/src/linux-2.5.8-dj1+smpboot-fix/vmlinux (specified)
     -k /proc/ksyms (default)
     -L (specified)
     -O (specified)
     -m /usr/src/linux-2.5.8-dj1+smpboot-fix/System.map (specified)

Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in vmlinux.
  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_set_cpus_allowed not found in
vmlinux.  Ignoring ksyms_base entry
Oops: 0002
CPU:    0
EIP:    0010:[<c0247319>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c17d5e20   ebx: c03d0014   ecx: c17d5e1c   edx: 00000000
esi: 00000000   edi: c17d5e24   ebp: c17d5e0c   esp: c17d5c90
ds: 0018   es: 0018   ss: 0018
Stack: 00000202 010de591 c9cf1140 010de591 c03d0014 c9cf1140 c03cff20 c023eda6
       c03d0014 c9cf1140 010de591 00001000 c9cf1140 c03d0020 c03d0014 c9fb9e00
       c023f10f c03d0014 c9cf1140 00000000 ffffffff c03cff20 c03d0014 c9fb9e00
Call Trace: [<c023eda6>] [<c023f10f>] [<c023f1fe>] [<c023f272>] [<c0222fc0>]
   [<c011dffe>] [<c0138862>] [<c020d500>] [<c0138983>] [<c012b862>] [<c012bdcc>]
   [<c012bcd0>] [<c01429fc>] [<c01430da>] [<c014360a>] [<c014488e>] [<c0105b10>]
   [<c01071db>]
Code: 89 02 89 f0 c7 41 f0 00 00 00 00 89 59 f4 c7 41 f8 00 00 00

>>EIP; c0247319 <idedisk_do_request+c9/250>   <=====
Trace; c023eda6 <start_request+2a6/330>
Trace; c023f10f <ide_queue_commands+14f/1e0>
Trace; c023f1fe <ide_do_request+5e/80>
Trace; c023f272 <do_ide_request+12/20>
Trace; c0222fc0 <generic_unplug_device+30/40>
Trace; c011dffe <__run_task_queue+5e/70>
Trace; c0138862 <do_page_cache_readahead+142/160>
Trace; c020d500 <n_tty_receive_buf+bb0/be0>
Trace; c0138983 <page_cache_readahead+103/110>
Trace; c012b862 <do_generic_file_read+92/310>
Trace; c012bdcc <generic_file_read+7c/130>
Trace; c012bcd0 <file_read_actor+0/80>
Trace; c01429fc <kernel_read+4c/60>
Trace; c01430da <prepare_binprm+11a/120>
Trace; c014360a <do_execve+10a/1e0>
Trace; c014488e <getname+5e/a0>
Trace; c0105b10 <sys_execve+30/60>
Trace; c01071db <syscall_call+7/b>
Code;  c0247319 <idedisk_do_request+c9/250>
00000000 <_EIP>:
Code;  c0247319 <idedisk_do_request+c9/250>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c024731b <idedisk_do_request+cb/250>
   2:   89 f0                     mov    %esi,%eax
Code;  c024731d <idedisk_do_request+cd/250>
   4:   c7 41 f0 00 00 00 00      movl   $0x0,0xfffffff0(%ecx)
Code;  c0247324 <idedisk_do_request+d4/250>
   b:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0247327 <idedisk_do_request+d7/250>
   e:   c7 41 f8 00 00 00 00      movl   $0x0,0xfffffff8(%ecx)


2 warnings issued.  Results may not be reliable.



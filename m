Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSKER20>; Tue, 5 Nov 2002 12:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265052AbSKER20>; Tue, 5 Nov 2002 12:28:26 -0500
Received: from attila.bofh.it ([213.92.8.2]:60110 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S265051AbSKER2Y>;
	Tue, 5 Nov 2002 12:28:24 -0500
Date: Tue, 5 Nov 2002 18:34:52 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: oops 2.5.46 snd_timer_free
Message-ID: <20021105173452.GA659@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened after I run rmmod the second time: it segfaulted and the
system locked up after about one second.

(missing do_select symbol is my fault)

$ ksymoops --vmlinux=/usr/src/linux-2.5.46/vmlinux --ksyms=/var/log/ksymoops/20021105181356.ksyms --no-lsmod --system-map=/usr/src/linux-2.5.46/System.map --object=/lib/modules/2.5.46/ < /tmp/oops 
ksymoops 2.4.6 on i686 2.4.19-rc1.  Options used
     -v /usr/src/linux-2.5.46/vmlinux (specified)
     -k /var/log/ksymoops/20021105181356.ksyms (specified)
     -L (specified)
     -o /lib/modules/2.5.46/ (specified)
     -m /usr/src/linux-2.5.46/System.map (specified)

Warning (compare_maps): ksyms_base symbol do_select_R__ver_do_select not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol page_states__per_cpu_R__ver_page_states__per_cpu not found in vmlinux.  Ignoring ksyms_base entry
Nov  5 18:13:56 wonderland kernel: Unable to handle kernel paging request at virtual address e10e1130
Nov  5 18:13:56 wonderland kernel: e10e1130
Nov  5 18:13:56 wonderland kernel: *pde = 1f7e8067
Nov  5 18:13:56 wonderland kernel: Oops: 0000
Nov  5 18:13:56 wonderland kernel: CPU:    0
Nov  5 18:13:56 wonderland kernel: EIP:    0060:[<e10e1130>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  5 18:13:56 wonderland kernel: EFLAGS: 00010286
Nov  5 18:13:56 wonderland kernel: eax: e10e1130   ebx: df73bec0   ecx: e10d56d8   edx: e10d56c4
Nov  5 18:13:56 wonderland kernel: esi: df73bfa0   edi: df73bec0   ebp: e10d56d8   esp: d0beff60
Nov  5 18:13:56 wonderland kernel: ds: 0068   es: 0068   ss: 0068
Nov  5 18:13:56 wonderland kernel: Stack: e10d2e72 df73bec0 e10d56d8 e10d3053 df73bec0 df73bc98 e10d2000 e10c9000 
Nov  5 18:13:56 wonderland kernel:        e10d2000 e10d402b df73bec0 d0bee000 c01196e7 d0bee000 e10d2000 e10c9000 
Nov  5 18:13:56 wonderland kernel:        00000001 c0118b98 e10d2000 00000001 d0bee000 00000061 bfffe838 bfffe838 
Nov  5 18:13:56 wonderland kernel: Call Trace:
Nov  5 18:13:56 wonderland kernel:  [<e10d2e72>] snd_timer_free+0x12/0x30 [snd-timer]
Nov  5 18:13:56 wonderland kernel:  [<e10d56d8>] register_mutex+0x0/0x14 [snd-timer]
Nov  5 18:13:56 wonderland kernel:  [<e10d3053>] snd_timer_unregister+0x93/0xa0 [snd-timer]
Nov  5 18:13:56 wonderland kernel:  [<e10d402b>] cleanup_module+0x2b/0x65 [snd-timer]
Nov  5 18:13:56 wonderland kernel:  [<c01196e7>] free_module+0x17/0xc0
Nov  5 18:13:56 wonderland kernel:  [<c0118b98>] sys_delete_module+0x1e8/0x280
Nov  5 18:13:56 wonderland kernel:  [<c010897b>] syscall_call+0x7/0xb
Nov  5 18:13:56 wonderland kernel: Code:  Bad EIP value.


>>EIP; e10e1130 <[snd].bss.end+19d2d/33c5d>   <=====

>>eax; e10e1130 <[snd].bss.end+19d2d/33c5d>
>>ebx; df73bec0 <_end+1f32b8c8/20438a68>
>>ecx; e10d56d8 <[snd].bss.end+e2d5/33c5d>
>>edx; e10d56c4 <[snd].bss.end+e2c1/33c5d>
>>esi; df73bfa0 <_end+1f32b9a8/20438a68>
>>edi; df73bec0 <_end+1f32b8c8/20438a68>
>>ebp; e10d56d8 <[snd].bss.end+e2d5/33c5d>
>>esp; d0beff60 <_end+107df968/20438a68>

Trace; e10d2e72 <[snd].bss.end+ba6f/33c5d>
Trace; e10d56d8 <[snd].bss.end+e2d5/33c5d>
Trace; e10d3053 <[snd].bss.end+bc50/33c5d>
Trace; e10d402b <[snd].bss.end+cc28/33c5d>
Trace; c01196e7 <free_module+17/c0>
Trace; c0118b98 <sys_delete_module+1e8/280>
Trace; c010897b <syscall_call+7/b>


2 warnings issued.  Results may not be reliable.

-- 
ciao,
Marco

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271773AbRIHRec>; Sat, 8 Sep 2001 13:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271775AbRIHReX>; Sat, 8 Sep 2001 13:34:23 -0400
Received: from s340-modem2946.dial.xs4all.nl ([194.109.171.130]:53893 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S271773AbRIHReP>;
	Sat, 8 Sep 2001 13:34:15 -0400
Date: Sat, 8 Sep 2001 19:33:35 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Feedback on preemptible kernel patch
In-Reply-To: <999928066.903.18.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109081920540.3542-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robert,


I tried 2.4.10-pre4 with patch-rml-2.4.10-pre4-preempt-kernel-1.
But it seems to hit highmem (see below) (i do have 1.5GB ram)
2.4.10-pre4 plain runs just fine.

With the kernel option mem=850M the patched kernel boots an seems to run
fine. However i didn't do any stress testing yet, but i still notice
hickups while playing mp3 files at -10 nice level with mpg123 on a 1.1GHz
Athlon, and removing for example a _large_ file (reiser-on-lvm).

My syslog output with highmem:

Sep  8 18:10:16 sjoerd kernel: kernel BUG at /usr/src/linux-2.4.10-pre4/include/asm/highmem.h:95!
Sep  8 18:10:16 sjoerd kernel: invalid operand: 0000
Sep  8 18:10:16 sjoerd kernel: CPU:    0
Sep  8 18:10:16 sjoerd kernel: EIP:    0010:[do_wp_page+636/1088]
Sep  8 18:10:16 sjoerd kernel: EFLAGS: 00010282
Sep  8 18:10:16 sjoerd kernel: eax: 00000043   ebx: 080bdd5c   ecx: f5764260   edx: f4d4c000
Sep  8 18:10:16 sjoerd kernel: esi: c26cca60   edi: ffffffff   ebp: c26ca134   esp: f4d4dec8
Sep  8 18:10:16 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 18:10:16 sjoerd kernel: Process S11dhcpd (pid: 2507, stackpage=f4d4d000)
Sep  8 18:10:16 sjoerd kernel: Stack: c0210bd2 c0210cc0 0000005f 080bdd5c f5805f00 ffffffff 00000001 c012437d
Sep  8 18:10:16 sjoerd kernel:        f5805f00 f4d49a00 080bdd5c f4c822f4 55d54065 f4d4c000 f4d49a00 f5805f00
Sep  8 18:10:16 sjoerd kernel:        f5805f1c c0111a17 f5805f00 f4d49a00 080bdd5c 00000001 f4d4c000 00000007
Sep  8 18:10:16 sjoerd kernel: Call Trace: [handle_mm_fault+141/224] [do_page_fault+375/1136] [do_page_fault+0/1136] [__mmdrop+58/64] [do_exit+595/640]
Sep  8 18:10:16 sjoerd kernel:    [error_code+52/64]
Sep  8 18:10:16 sjoerd kernel:
Sep  8 18:10:16 sjoerd kernel: Code: 0f 0b 83 c4 0c 8b 15 e8 2f 2a c0 89 f0 2b 05 ac ba 2a c0 69
Sep  8 18:10:16 sjoerd kernel: MAC unknown INTRUDERS?? (tf) IN=eth0 OUT= MAC= SRC=192.168.0.5 DST=192.168.0.255 LEN=241 TOS=0x02 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=138 DPT=138 LEN=221
Sep  8 18:10:16 sjoerd kernel: MAC unknown INTRUDERS?? (tf) IN=eth0 OUT= MAC= SRC=192.168.0.5 DST=192.168.0.255 LEN=96 TOS=0x02 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=76
Sep  8 18:10:16 sjoerd kernel: kernel BUG at /usr/src/linux-2.4.10-pre4/include/asm/highmem.h:95!
Sep  8 18:10:16 sjoerd kernel: invalid operand: 0000
Sep  8 18:10:16 sjoerd kernel: CPU:    0
Sep  8 18:10:16 sjoerd kernel: EIP:    0010:[do_anonymous_page+130/368]
Sep  8 18:10:16 sjoerd kernel: EFLAGS: 00010286
Sep  8 18:10:16 sjoerd kernel: eax: 00000043   ebx: 080c501c   ecx: f5764260   edx: f4d4c000
Sep  8 18:10:16 sjoerd kernel: esi: c26c4fec   edi: f5805f00   ebp: f4d497c0   esp: f4d4dea0
Sep  8 18:10:16 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 18:10:16 sjoerd kernel: Process dhcpd (pid: 2508, stackpage=f4d4d000)
Sep  8 18:10:16 sjoerd kernel: Stack: c0210bd2 c0210cc0 0000005f 080c501c f4d497c0 f5805f00 00000001 c012420f
Sep  8 18:10:16 sjoerd kernel:        f5805f00 f4d497c0 f4c63314 00000001 080c501c 080c501c f5805f00 ffffffff
Sep  8 18:10:16 sjoerd kernel:        00000001 c012434e f5805f00 f4d497c0 080c501c 00000001 f4c63314 f4d4c000
Sep  8 18:10:16 sjoerd kernel: Call Trace: [do_no_page+47/272] [handle_mm_fault+94/224] [do_page_fault+375/1136] [do_page_fault+0/1136] [do_munmap+86/640]
Sep  8 18:10:16 sjoerd kernel:    [fput+116/224] [do_brk+176/368] [sys_brk+187/240] [error_code+52/64]
Sep  8 18:10:16 sjoerd kernel:
Sep  8 18:10:16 sjoerd kernel: Code: 0f 0b 83 c4 0c 8b 15 e8 2f 2a c0 89 f0 2b 05 ac ba 2a c0 69
Sep  8 18:10:16 sjoerd kernel: kernel BUG at /usr/src/linux-2.4.10-pre4/include/asm/highmem.h:95!
Sep  8 18:10:16 sjoerd kernel: invalid operand: 0000
Sep  8 18:10:16 sjoerd kernel: CPU:    0
Sep  8 18:10:16 sjoerd kernel: EIP:    0010:[do_anonymous_page+130/368]
Sep  8 18:10:16 sjoerd kernel: EFLAGS: 00010282
Sep  8 18:10:16 sjoerd kernel: eax: 00000043   ebx: 40017000   ecx: f5735f7c   edx: f4c88000
Sep  8 18:10:16 sjoerd kernel: esi: c26c9298   edi: f5805d80   ebp: f4c945c0   esp: f4c89dc8
Sep  8 18:10:16 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 18:10:16 sjoerd kernel: Process python (pid: 2456, stackpage=f4c89000)
Sep  8 18:10:16 sjoerd kernel: Stack: c0210bd2 c0210cc0 0000005f 40017000 f4c945c0 f5805d80 00000001 c012420f
Sep  8 18:10:16 sjoerd kernel:        f5805d80 f4c945c0 f4c9c05c 00000001 40017000 40017000 f5805d80 ffffffff
Sep  8 18:10:16 sjoerd kernel:        00000001 c012434e f5805d80 f4c945c0 40017000 00000001 f4c9c05c f4c88000
Sep  8 18:10:16 sjoerd kernel: Call Trace: [do_no_page+47/272] [handle_mm_fault+94/224] [do_page_fault+375/1136] [do_page_fault+0/1136] [block_read_full_page+240/688]
Sep  8 18:10:16 sjoerd kernel:    [error_code+52/64] [file_read_actor+113/224] [do_generic_file_read+505/1344] [generic_file_read+99/128] [file_read_actor+0/224] [sys_read+150/208]
Sep  8 18:10:16 sjoerd kernel:    [system_call+51/56]
Sep  8 18:10:16 sjoerd kernel:
Sep  8 18:10:16 sjoerd kernel: Code: 0f 0b 83 c4 0c 8b 15 e8 2f 2a c0 89 f0 2b 05 ac ba 2a c0 69
Sep  8 18:10:16 sjoerd kernel: kernel BUG at /usr/src/linux-2.4.10-pre4/include/asm/highmem.h:95!
Sep  8 18:10:16 sjoerd kernel: kernel BUG at /usr/src/linux-2.4.10-pre4/include/asm/highmem.h:95!
Sep  8 18:10:16 sjoerd kernel: invalid operand: 0000
Sep  8 18:10:16 sjoerd kernel: CPU:    0
Sep  8 18:10:16 sjoerd kernel: EIP:    0010:[do_wp_page+636/1088]
Sep  8 18:10:16 sjoerd kernel: EFLAGS: 00010282
Sep  8 18:10:16 sjoerd kernel: eax: 00000043   ebx: bffff960   ecx: f5764260   edx: f4ce4000
Sep  8 18:10:16 sjoerd kernel: esi: c26d04d0   edi: ffffffff   ebp: c26ca4a8   esp: f4ce5ec8
Sep  8 18:10:16 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 18:10:16 sjoerd kernel: Process rc (pid: 2514, stackpage=f4ce5000)
Sep  8 18:10:16 sjoerd kernel: Stack: c0210bd2 c0210cc0 0000005f bffff960 f5805780 ffffffff 00000001 c012437d
Sep  8 18:10:16 sjoerd kernel:        f5805780 f4c54dc0 bffff960 f4ca8ffc 55e30065 f4ce4000 f4c54dc0 f5805780
Sep  8 18:10:16 sjoerd kernel:        f580579c c0111a17 f5805780 f4c54dc0 bffff960 00000001 f4ce4000 00000007
Sep  8 18:10:16 sjoerd kernel: Call Trace: [handle_mm_fault+141/224] [do_page_fault+375/1136] [do_page_fault+0/1136] [__mmdrop+58/64] [do_exit+595/640]
Sep  8 18:10:16 sjoerd kernel:    [error_code+52/64]
Sep  8 18:10:16 sjoerd kernel:
Sep  8 18:10:16 sjoerd kernel: Code: 0f 0b 83 c4 0c 8b 15 e8 2f 2a c0 89 f0 2b 05 ac ba 2a c0 69
Sep  8 18:10:16 sjoerd kernel: kernel BUG at /usr/src/linux-2.4.10-pre4/include/asm/highmem.h:95!
Sep  8 18:10:16 sjoerd kernel: invalid operand: 0000
Sep  8 18:10:16 sjoerd kernel: CPU:    0
Sep  8 18:10:16 sjoerd kernel: EIP:    0010:[filemap_nopage+300/1344]
Sep  8 18:10:16 sjoerd kernel: EFLAGS: 00010282
Sep  8 18:10:16 sjoerd kernel: eax: 00000043   ebx: 00000001   ecx: f5764260   edx: f4c3e000
Sep  8 18:10:16 sjoerd kernel: esi: c297ac20   edi: 00000015   ebp: c270df9c   esp: f4c3fb30
Sep  8 18:10:16 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 18:10:16 sjoerd kernel: Process ncpserv (pid: 2513, stackpage=f4c3f000)
Sep  8 18:10:16 sjoerd kernel: Stack: c02110b2 c0211160 0000005f 40016000 f4c54f00 f4c62140 00000001 00000019
Sep  8 18:10:16 sjoerd kernel:        f7af9960 f74f7a24 f74f7980 f4db9c40 c0124252 f4c54f00 40016000 00000001
Sep  8 18:10:16 sjoerd kernel:        400162a8 f4c62140 ffffffff 00000001 c012434e f4c62140 f4c54f00 400162a8
Sep  8 18:10:16 sjoerd kernel: Call Trace: [do_no_page+114/272] [handle_mm_fault+94/224] [do_page_fault+375/1136] [do_page_fault+0/1136] [file_read_actor+177/224]
Sep  8 18:10:16 sjoerd kernel:    [update_atime+68/80] [do_generic_file_read+1333/1344] [do_munmap+86/640] [update_atime+68/80] [error_code+52/64] [clear_user+46/64]
Sep  8 18:10:16 sjoerd kernel:    [padzero+28/32] [load_elf_interp+619/704] [load_elf_binary+1959/2704] [load_elf_binary+0/2704] [nfsd:__insmod_nfsd_O/lib/modules/2.4.10-pre4/kernel/fs/nfsd/nfsd+-13721617/96] [search_binary_handler+152/496]
Sep  8 18:10:16 sjoerd kernel:    [do_execve+380/496] [do_execve+403/496] [sys_execve+47/96] [system_call+51/56]
Sep  8 18:10:16 sjoerd kernel:
Sep  8 18:10:16 sjoerd kernel: Code: 0f 0b 83 c4 0c 8b 15 e8 2f 2a c0 89 f0 2b 05 ac ba 2a c0 69
Sep  8 18:10:16 sjoerd kernel: LOOUT REJECT TCP IN= OUT=lo SRC=127.0.0.1 DST=127.0.0.1 LEN=356 TOS=0x02 PREC=0x00 TTL=64 ID=32512 PROTO=TCP SPT=32775 DPT=15607 WINDOW=32767 RES=0x00 ACK PSH FIN URGP=0
Sep  8 18:10:16 sjoerd kernel: invalid operand: 0000
Sep  8 18:10:16 sjoerd kernel: CPU:    0
Sep  8 18:10:16 sjoerd kernel: EIP:    0010:[do_wp_page+636/1088]
Sep  8 18:10:16 sjoerd kernel: EFLAGS: 00010282
Sep  8 18:10:16 sjoerd kernel: eax: 00000043   ebx: 080b170c   ecx: f4ce4260   edx: f5946000
Sep  8 18:10:16 sjoerd kernel: esi: c26dec2c   edi: ffffffff   ebp: c26ca2cc   esp: f5947ec8
Sep  8 18:10:16 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 18:10:16 sjoerd kernel: Process rc (pid: 156, stackpage=f5947000)
Sep  8 18:10:16 sjoerd kernel: Stack: c0210bd2 c0210cc0 0000005f 080b170c f752a080 ffffffff 00000001 c012437d
Sep  8 18:10:16 sjoerd kernel:        f752a080 f75282c0 080b170c f59de2c4 56197065 f5946000 f75282c0 f752a080
Sep  8 18:10:16 sjoerd kernel:        f752a09c c0111a17 f752a080 f75282c0 080b170c 00000001 f5946000 00000007
Sep  8 18:10:16 sjoerd kernel: Call Trace: [handle_mm_fault+141/224] [do_page_fault+375/1136] [do_page_fault+0/1136] [copy_thread+136/160] [do_fork+1619/1792]
Sep  8 18:10:16 sjoerd kernel:    [write_chan+0/544] [sys_fork+20/32] [error_code+52/64]
Sep  8 18:10:16 sjoerd kernel:
Sep  8 18:10:16 sjoerd kernel: Code: 0f 0b 83 c4 0c 8b 15 e8 2f 2a c0 89 f0 2b 05 ac ba 2a c0 69
Sep  8 18:10:16 sjoerd kernel: kernel BUG at /usr/src/linux-2.4.10-pre4/include/asm/highmem.h:95!
Sep  8 18:10:16 sjoerd kernel: invalid operand: 0000
Sep  8 18:10:16 sjoerd kernel: CPU:    0
Sep  8 18:10:16 sjoerd kernel: EIP:    0010:[do_wp_page+636/1088]
Sep  8 18:10:16 sjoerd kernel: EFLAGS: 00010282
Sep  8 18:10:16 sjoerd kernel: eax: 00000043   ebx: 080b04e0   ecx: f5735f7c   edx: c299a000
Sep  8 18:10:16 sjoerd kernel: esi: c2962850   edi: ffffffff   ebp: c292d82c   esp: c299bec8
Sep  8 18:10:16 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 18:10:16 sjoerd kernel: Process init (pid: 1, stackpage=c299b000)
Sep  8 18:10:16 sjoerd kernel: Stack: c0210bd2 c0210cc0 0000005f 080b04e0 f752a140 ffffffff 00000001 c012437d
Sep  8 18:10:16 sjoerd kernel:        f752a140 f7528180 080b04e0 f751a2c0 5f910065 c299a000 f7528180 f752a140
Sep  8 18:10:16 sjoerd kernel:        f752a15c c0111a17 f752a140 f7528180 080b04e0 00000001 c299a000 00000007
Sep  8 18:10:16 sjoerd kernel: Call Trace: [handle_mm_fault+141/224] [do_page_fault+375/1136] [do_page_fault+0/1136] [copy_thread+136/160] [do_fork+1619/1792]
Sep  8 18:10:16 sjoerd kernel:    [sys_fork+20/32] [error_code+52/64]
Sep  8 18:10:16 sjoerd kernel:
Sep  8 18:10:16 sjoerd kernel: Code: 0f 0b 83 c4 0c 8b 15 e8 2f 2a c0 89 f0 2b 05 ac ba 2a c0 69

-- 
Arjan Filius
mailto:iafilius@xs4all.nl


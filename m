Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbTLKKQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264871AbTLKKQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:16:45 -0500
Received: from cust.19.202.adsl.cistron.nl ([62.216.19.202]:28801 "EHLO
	foko.komputilo.org") by vger.kernel.org with ESMTP id S264868AbTLKKQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:16:36 -0500
Date: Thu, 11 Dec 2003 11:16:35 +0100
From: Joost Witteveen <joost@foko.komputilo.org>
To: linux-kernel@vger.kernel.org
Subject: OOPS: test11, VIA VT8601 gcc 3.3.2
Message-ID: <20031211101635.GA1917@foko.komputilo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.0test11 is running rather unstable here; it's halted
for no reason several times already (no network, keyboard hangs,
and no graphics output (monitor says "No Signal"), usually
after a couple of days of uptime. Each time there was no
trace to be found in /var/log/*, but this time there was.

I was doing `nothign' with the computer, the last thing before
the oops I could find in /var/log/syslog were: some dhclient
00:21:10: dhclient: No DHCPOFFERS received.
00:21:23: sendmail recieving email
00:22:02: cron starting a perl script, connects to mysql
00:22:36: sendmail again
00:23:01: cron testing for existance of file

So, basically, linux was doing nothing at 00:23:18


I remember reading that 2.6 shouldn't be compiled with gcc 3.3,
which I did, but I hope that eighter my oops doesn't relate to
gcc, or, that my oops may help linux be compiled with 3.3


ksymoops 2.4.9 on i686 2.6.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test11/ (default)
     -m /boot/System.map-2.6.0-test11 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Dec 11 00:23:18 foko kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Dec 11 00:23:18 foko kernel: c0117839
Dec 11 00:23:18 foko kernel: *pde = 00000000
Dec 11 00:23:18 foko kernel: Oops: 0002 [#1]
Dec 11 00:23:18 foko kernel: CPU:    0
Dec 11 00:23:18 foko kernel: EIP:    0060:[<c0117839>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 11 00:23:18 foko kernel: EFLAGS: 00010097
Dec 11 00:23:18 foko kernel: eax: 00000001   ebx: cb540cc0   ecx: cb540ce0   edx: 0d8ea388
Dec 11 00:23:18 foko kernel: esi: 00000000   edi: daabfd20   ebp: daabfcbc   esp: daabfc78
Dec 11 00:23:18 foko kernel: ds: 007b   es: 007b   ss: 0068
Dec 11 00:23:18 foko kernel: Stack: c4ef1210 c732ac00 00000003 daabfcc8 c03324b0 00000002 df791900 dc906480 
Dec 11 00:23:18 foko kernel:        00000000 cb5412e0 cb541300 000010e1 0d8eb469 000024a9 00000000 7fffffff 
Dec 11 00:23:18 foko kernel:        daabfd20 daabfcf8 c012371d 00000000 daabfdc0 c034ee87 c732ac00 c0331550 
Dec 11 00:23:18 foko kernel: Call Trace:
Dec 11 00:23:18 foko kernel:  [<c03324b0>] ip_push_pending_frames+0x3a0/0x400
Dec 11 00:23:18 foko kernel:  [<c012371d>] schedule_timeout+0xad/0xb0
Dec 11 00:23:18 foko kernel:  [<c034ee87>] raw_sendmsg+0x397/0x580
Dec 11 00:23:18 foko kernel:  [<c0331550>] ip_generic_getfrag+0x0/0xc0
Dec 11 00:23:18 foko kernel:  [<c0318380>] wait_for_packet+0xb0/0x110
Dec 11 00:23:18 foko kernel:  [<c0119400>] autoremove_wake_function+0x0/0x50
Dec 11 00:23:18 foko kernel:  [<c0119400>] autoremove_wake_function+0x0/0x50
Dec 11 00:23:18 foko kernel:  [<c031847b>] skb_recv_datagram+0x9b/0x100
Dec 11 00:23:18 foko kernel:  [<c034f1f7>] raw_recvmsg+0x67/0x170
Dec 11 00:23:18 foko kernel:  [<c0358fa4>] inet_recvmsg+0x54/0x70
Dec 11 00:23:18 foko kernel:  [<c0312a05>] sock_recvmsg+0x95/0xb0
Dec 11 00:23:18 foko kernel:  [<c0168883>] update_atime+0x93/0xe0
Dec 11 00:23:18 foko kernel:  [<c01375fb>] __alloc_pages+0xab/0x350
Dec 11 00:23:18 foko kernel:  [<c03126fa>] sockfd_lookup+0x1a/0x80
Dec 11 00:23:18 foko kernel:  [<c0313eb4>] sys_recvfrom+0x94/0x100
Dec 11 00:23:18 foko kernel:  [<c0115fe0>] do_page_fault+0x360/0x57e
Dec 11 00:23:18 foko kernel:  [<c0314803>] sys_socketcall+0x1d3/0x290
Dec 11 00:23:18 foko kernel:  [<c012358b>] sys_alarm+0x3b/0x50
Dec 11 00:23:18 foko kernel:  [<c010953b>] syscall_call+0x7/0xb
Dec 11 00:23:18 foko kernel: Code: ff 0e 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20 00 


>>EIP; c0117839 <schedule+f9/590>   <=====

>>ebx; cb540cc0 <_end+b068778/3fb25ab8>
>>ecx; cb540ce0 <_end+b068798/3fb25ab8>
>>edi; daabfd20 <_end+1a5e77d8/3fb25ab8>
>>ebp; daabfcbc <_end+1a5e7774/3fb25ab8>
>>esp; daabfc78 <_end+1a5e7730/3fb25ab8>

Trace; c03324b0 <ip_push_pending_frames+3a0/400>
Trace; c012371d <schedule_timeout+ad/b0>
Trace; c034ee87 <raw_sendmsg+397/580>
Trace; c0331550 <ip_generic_getfrag+0/c0>
Trace; c0318380 <wait_for_packet+b0/110>
Trace; c0119400 <autoremove_wake_function+0/50>
Trace; c0119400 <autoremove_wake_function+0/50>
Trace; c031847b <skb_recv_datagram+9b/100>
Trace; c034f1f7 <raw_recvmsg+67/170>
Trace; c0358fa4 <inet_recvmsg+54/70>
Trace; c0312a05 <sock_recvmsg+95/b0>
Trace; c0168883 <update_atime+93/e0>
Trace; c01375fb <__alloc_pages+ab/350>
Trace; c03126fa <sockfd_lookup+1a/80>
Trace; c0313eb4 <sys_recvfrom+94/100>
Trace; c0115fe0 <do_page_fault+360/57e>
Trace; c0314803 <sys_socketcall+1d3/290>
Trace; c012358b <sys_alarm+3b/50>
Trace; c010953b <syscall_call+7/b>

Code;  c0117839 <schedule+f9/590>
00000000 <_EIP>:
Code;  c0117839 <schedule+f9/590>   <=====
   0:   ff 0e                     decl   (%esi)   <=====
Code;  c011783b <schedule+fb/590>
   2:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c011783e <schedule+fe/590>
   5:   8b 43 20                  mov    0x20(%ebx),%eax
Code;  c0117841 <schedule+101/590>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0117844 <schedule+104/590>
   b:   89 02                     mov    %eax,(%edx)
Code;  c0117846 <schedule+106/590>
   d:   c7 41 04 00 02 20 00      movl   $0x200200,0x4(%ecx)

Dec 11 00:23:18 foko kernel: Call Trace:
Dec 11 00:23:18 foko kernel:  [<c0117cc5>] schedule+0x585/0x590
Dec 11 00:23:18 foko kernel:  [<c013fb0e>] unmap_page_range+0x4e/0x80
Dec 11 00:23:18 foko kernel:  [<c013fd08>] unmap_vmas+0x1c8/0x220
Dec 11 00:23:18 foko kernel:  [<c0143a38>] exit_mmap+0x78/0x190
Dec 11 00:23:18 foko kernel:  [<c01196b6>] mmput+0x66/0xc0
Dec 11 00:23:18 foko kernel:  [<c011d5f8>] do_exit+0x118/0x3d0
Dec 11 00:23:18 foko kernel:  [<c0115c80>] do_page_fault+0x0/0x57e
Dec 11 00:23:18 foko kernel:  [<c0109e01>] die+0xe1/0xf0
Dec 11 00:23:18 foko kernel:  [<c0115e7c>] do_page_fault+0x1fc/0x57e
Dec 11 00:23:18 foko kernel:  [<c0332a80>] ip_finish_output2+0xc0/0x1b0
Dec 11 00:23:18 foko kernel:  [<c032537d>] nf_hook_slow+0xed/0x140
Dec 11 00:23:18 foko kernel:  [<c03329c0>] ip_finish_output2+0x0/0x1b0
Dec 11 00:23:18 foko kernel:  [<c03305f5>] ip_finish_output+0x205/0x210
Dec 11 00:23:18 foko kernel:  [<c03329c0>] ip_finish_output2+0x0/0x1b0
Dec 11 00:23:18 foko kernel:  [<c0115c80>] do_page_fault+0x0/0x57e
Dec 11 00:23:18 foko kernel:  [<c0109745>] error_code+0x2d/0x38
Dec 11 00:23:18 foko kernel:  [<c0117839>] schedule+0xf9/0x590
Dec 11 00:23:18 foko kernel:  [<c03324b0>] ip_push_pending_frames+0x3a0/0x400
Dec 11 00:23:18 foko kernel:  [<c012371d>] schedule_timeout+0xad/0xb0
Dec 11 00:23:18 foko kernel:  [<c034ee87>] raw_sendmsg+0x397/0x580
Dec 11 00:23:18 foko kernel:  [<c0331550>] ip_generic_getfrag+0x0/0xc0
Dec 11 00:23:18 foko kernel:  [<c0318380>] wait_for_packet+0xb0/0x110
Dec 11 00:23:18 foko kernel:  [<c0119400>] autoremove_wake_function+0x0/0x50
Dec 11 00:23:18 foko kernel:  [<c0119400>] autoremove_wake_function+0x0/0x50
Dec 11 00:23:18 foko kernel:  [<c031847b>] skb_recv_datagram+0x9b/0x100
Dec 11 00:23:18 foko kernel:  [<c034f1f7>] raw_recvmsg+0x67/0x170
Dec 11 00:23:18 foko kernel:  [<c0358fa4>] inet_recvmsg+0x54/0x70
Dec 11 00:23:18 foko kernel:  [<c0312a05>] sock_recvmsg+0x95/0xb0
Dec 11 00:23:18 foko kernel:  [<c0168883>] update_atime+0x93/0xe0
Dec 11 00:23:18 foko kernel:  [<c01375fb>] __alloc_pages+0xab/0x350
Dec 11 00:23:18 foko kernel:  [<c03126fa>] sockfd_lookup+0x1a/0x80
Dec 11 00:23:18 foko kernel:  [<c0313eb4>] sys_recvfrom+0x94/0x100
Dec 11 00:23:18 foko kernel:  [<c0115fe0>] do_page_fault+0x360/0x57e
Dec 11 00:23:18 foko kernel:  [<c0314803>] sys_socketcall+0x1d3/0x290
Dec 11 00:23:18 foko kernel:  [<c012358b>] sys_alarm+0x3b/0x50
Dec 11 00:23:18 foko kernel:  [<c010953b>] syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0117cc5 <schedule+585/590>
Trace; c013fb0e <unmap_page_range+4e/80>
Trace; c013fd08 <unmap_vmas+1c8/220>
Trace; c0143a38 <exit_mmap+78/190>
Trace; c01196b6 <mmput+66/c0>
Trace; c011d5f8 <do_exit+118/3d0>
Trace; c0115c80 <do_page_fault+0/57e>
Trace; c0109e01 <die+e1/f0>
Trace; c0115e7c <do_page_fault+1fc/57e>
Trace; c0332a80 <ip_finish_output2+c0/1b0>
Trace; c032537d <nf_hook_slow+ed/140>
Trace; c03329c0 <ip_finish_output2+0/1b0>
Trace; c03305f5 <ip_finish_output+205/210>
Trace; c03329c0 <ip_finish_output2+0/1b0>
Trace; c0115c80 <do_page_fault+0/57e>
Trace; c0109745 <error_code+2d/38>
Trace; c0117839 <schedule+f9/590>
Trace; c03324b0 <ip_push_pending_frames+3a0/400>
Trace; c012371d <schedule_timeout+ad/b0>
Trace; c034ee87 <raw_sendmsg+397/580>
Trace; c0331550 <ip_generic_getfrag+0/c0>
Trace; c0318380 <wait_for_packet+b0/110>
Trace; c0119400 <autoremove_wake_function+0/50>
Trace; c0119400 <autoremove_wake_function+0/50>
Trace; c031847b <skb_recv_datagram+9b/100>
Trace; c034f1f7 <raw_recvmsg+67/170>
Trace; c0358fa4 <inet_recvmsg+54/70>
Trace; c0312a05 <sock_recvmsg+95/b0>
Trace; c0168883 <update_atime+93/e0>
Trace; c01375fb <__alloc_pages+ab/350>
Trace; c03126fa <sockfd_lookup+1a/80>
Trace; c0313eb4 <sys_recvfrom+94/100>
Trace; c0115fe0 <do_page_fault+360/57e>
Trace; c0314803 <sys_socketcall+1d3/290>
Trace; c012358b <sys_alarm+3b/50>
Trace; c010953b <syscall_call+7/b>


2 warnings and 1 error issued.  Results may not be reliable.



$ cat /proc/version 
Linux version 2.6.0-test11 (joostje@foko) (gcc version 3.3.2 (Debian)) #2 Wed Dec 3 23:12:38 CET 2003


$ lspci 
00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.4 Class 0080: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 6a)


$ cat /proc/mdstat 
Personalities : [raid1] 
md0 : active raid1 hdc5[1] hdb5[0]
      16865728 blocks [2/2] [UU]

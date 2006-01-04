Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWADM0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWADM0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 07:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWADM0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 07:26:21 -0500
Received: from customers.imt.ru ([212.16.0.33]:25888 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id S1030216AbWADM0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 07:26:21 -0500
Date: Wed, 4 Jan 2006 15:27:07 +0300
From: Crazy AMD K7 <100megabit@mail.ru>
X-Mailer: The Bat! (v1.46d)
Reply-To: Crazy AMD K7 <100megabit@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <5719304258.20060104152707@mail.ru>
To: sct@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Oops with Process kjournald
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen and all others.
I am using RedHat Linux 7.3 (kernel 2.4.32) on pentium machine.
Yesterday I have installed a Promise sataII150tx2plus (20575 chipset)
card and a new 250Gb HDD.
Everything is ok, but this night I have got an oops in
/var/log/messages the ksymoops report on it follows.
Approximately the Oops happened when a big file was copied on the
server via samba. The filesystem is ext3. Is any ideas why did this
happened?
(P.S. I have Penium-MMX CPU and the kernel was compiled for
Pentium-Classic, thats why you may see some other not related messages
I think.)
How to reproduce the Ooops I do not know.

ksymoops 2.4.4 on i586 2.4.32.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -o /lib/modules/2.4.32/ (default)
     -m /boot/System.map-2.4.32 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan  3 23:28:44 SERVER kernel: Intel Pentium with F0 0F bug - workaround enabled.
Jan  3 23:28:50 SERVER kernel: 8139too Fast Ethernet driver 0.9.26
Jan  4 00:21:03 SERVER kernel: Intel Pentium with F0 0F bug - workaround enabled.
Jan  4 00:21:07 SERVER kernel: 8139too Fast Ethernet driver 0.9.26
Jan  4 06:24:55 SERVER kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000019
Jan  4 06:24:55 SERVER kernel: c0162847
Jan  4 06:24:55 SERVER kernel: *pde = 00000000
Jan  4 06:24:55 SERVER kernel: Oops: 0000
Jan  4 06:24:55 SERVER kernel: CPU:    0
Jan  4 06:24:55 SERVER kernel: EIP:    0010:[<c0162847>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  4 06:24:55 SERVER kernel: EFLAGS: 00010206
Jan  4 06:24:55 SERVER kernel: eax: c3a9feb0   ebx: 00000001   ecx: c11db620   edx: 00000036
Jan  4 06:24:55 SERVER kernel: esi: c0930cd8   edi: 00000000   ebp: c0930250   esp: c3a9fe44
Jan  4 06:24:55 SERVER kernel: ds: 0018   es: 0018   ss: 0018
Jan  4 06:24:55 SERVER kernel: Process kjournald (pid: 126, stackpage=c3a9f000)
Jan  4 06:24:55 SERVER kernel: Stack: 00000000 00000000 00000000 00000036 c11db620 c26e9d00 00000e97 00000000
Jan  4 06:24:55 SERVER kernel:        c11f9374 c11f9374 00000202 c01d0728 00000202 00000000 c11f9374 00000001
Jan  4 06:24:55 SERVER kernel:        c11ccc00 c01d099c c11f9374 00000000 c11f9374 00000246 c11ccc00 00000001
Jan  4 06:24:55 SERVER kernel: Call Trace:    [<c01d0728>] [<c01d099c>] [<c0165996>] [<c0165800>] [<c0105576>]
Jan  4 06:24:55 SERVER kernel:   [<c0165820>]
Jan  4 06:24:55 SERVER kernel: Code: 8b 43 18 a9 04 00 00 00 75 41 83 e0 02 74 1a ff 43 10 8b 54

>>EIP; c0162847 <journal_commit_transaction+327/12cc>   <=====
Trace; c01d0728 <scsi_queue_next_request+38/f0>
Trace; c01d099c <__scsi_end_request+1bc/1d0>
Trace; c0165996 <kjournald+176/2d0>
Trace; c0165800 <commit_timeout+0/10>
Trace; c0105576 <arch_kernel_thread+26/30>
Trace; c0165820 <kjournald+0/2d0>
Code;  c0162847 <journal_commit_transaction+327/12cc>
00000000 <_EIP>:
Code;  c0162847 <journal_commit_transaction+327/12cc>   <=====
   0:   8b 43 18                  mov    0x18(%ebx),%eax   <=====
Code;  c016284a <journal_commit_transaction+32a/12cc>
   3:   a9 04 00 00 00            test   $0x4,%eax
Code;  c016284f <journal_commit_transaction+32f/12cc>
   8:   75 41                     jne    4b <_EIP+0x4b> c0162892 <journal_commit_transaction+372/12cc>
Code;  c0162851 <journal_commit_transaction+331/12cc>
   a:   83 e0 02                  and    $0x2,%eax
Code;  c0162854 <journal_commit_transaction+334/12cc>
   d:   74 1a                     je     29 <_EIP+0x29> c0162870 <journal_commit_transaction+350/12cc>
Code;  c0162856 <journal_commit_transaction+336/12cc>
   f:   ff 43 10                  incl   0x10(%ebx)
Code;  c0162859 <journal_commit_transaction+339/12cc>
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx

Jan  4 06:33:07 SERVER kernel: Intel Pentium with F0 0F bug - workaround enabled.
Jan  4 06:33:13 SERVER kernel: 8139too Fast Ethernet driver 0.9.26

1 warning issued.  Results may not be reliable.



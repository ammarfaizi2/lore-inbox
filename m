Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSKOR4Q>; Fri, 15 Nov 2002 12:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbSKOR4Q>; Fri, 15 Nov 2002 12:56:16 -0500
Received: from dhcp80ff2399.dynamic.uiowa.edu ([128.255.35.153]:15744 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S266761AbSKOR4M>;
	Fri, 15 Nov 2002 12:56:12 -0500
Date: Fri, 15 Nov 2002 12:03:08 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 - oopsen on reboot
Message-ID: <20021115180304.GE2828@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  Last bug for now, I promise.  I just compiled 2.5.47 last night,
  and these were the bugs that reared their ugly heads.  :)
Sorry for this long post, but it's as complete as I think you can stand.
  (all oopses are reported that I got, and they arrived in sequence):

On rebooting my laptop, I get the following errors:
Nov 14 23:40:45 paulus unloading Kernel Card Services
Nov 14 23:42:59 paulus Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:42:59 paulus printing eip:
Nov 14 23:42:59 paulus c01edc78
Nov 14 23:42:59 paulus *pde = 09df5067
Nov 14 23:42:59 paulus *pte = 00000000
Nov 14 23:42:59 paulus Oops: 0000
Nov 14 23:42:59 paulus crc32 apm rtc  
Nov 14 23:42:59 paulus CPU:    0
Nov 14 23:42:59 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:42:59 paulus EFLAGS: 00010282
Nov 14 23:42:59 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:42:59 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:42:59 paulus esi: ffffffff   edi: c6979e60   ebp: c9f46954   esp: c38cdf30
Nov 14 23:42:59 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:42:59 paulus Process lspci (pid: 2252, threadinfo=c38cc000 task=c676c6e0)
Nov 14 23:42:59 paulus Stack: c6979e60 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:42:59 paulus c6979e60 c9f46800 00000000 00000000 c4001d20 c4001d40 c6979e78 00000000 
Nov 14 23:42:59 paulus 00000003 00000000 00000002 00000000 c013d771 c4001d20 40126000 00000400 
Nov 14 23:42:59 paulus Call Trace:
Nov 14 23:42:59 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:42:59 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:42:59 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:42:59 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:42:59 paulus 
Nov 14 23:42:59 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:43:08 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:43:08 paulus printing eip:
Nov 14 23:43:08 paulus c01edc78
Nov 14 23:43:08 paulus *pde = 09df5067
Nov 14 23:43:08 paulus *pte = 00000000
Nov 14 23:43:08 paulus Oops: 0000
Nov 14 23:43:08 paulus crc32 apm rtc  
Nov 14 23:43:08 paulus CPU:    0
Nov 14 23:43:08 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:43:08 paulus EFLAGS: 00010282
Nov 14 23:43:08 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:43:08 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:43:08 paulus esi: ffffffff   edi: c6979d60   ebp: c9f46954   esp: c36a9f30
Nov 14 23:43:08 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:43:08 paulus Process lspci (pid: 2406, threadinfo=c36a8000 task=c5d08d20)
Nov 14 23:43:08 paulus Stack: c6979d60 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:43:08 paulus c6979d60 c9f46800 00000000 00000000 c5b8c6c0 c5b8c6e0 c6979d78 00000000 
Nov 14 23:43:08 paulus 00000003 00000000 00000002 00000000 c013d771 c5b8c6c0 40126000 00000400 
Nov 14 23:43:08 paulus Call Trace:
Nov 14 23:43:08 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:43:08 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:43:08 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:43:08 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:43:08 paulus 
Nov 14 23:43:08 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:43:53 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:43:53 paulus printing eip:
Nov 14 23:43:53 paulus c01edc78
Nov 14 23:43:53 paulus *pde = 09df5067
Nov 14 23:43:53 paulus *pte = 00000000
Nov 14 23:43:53 paulus Oops: 0000
Nov 14 23:43:53 paulus crc32 apm rtc  
Nov 14 23:43:53 paulus CPU:    0
Nov 14 23:43:53 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:43:53 paulus EFLAGS: 00010282
Nov 14 23:43:53 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:43:53 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:43:53 paulus esi: ffffffff   edi: c6979de0   ebp: c9f46954   esp: c35cbf30
Nov 14 23:43:53 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:43:53 paulus Process lspci (pid: 3146, threadinfo=c35ca000 task=c4008d40)
Nov 14 23:43:53 paulus Stack: c6979de0 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:43:53 paulus c6979de0 c9f46800 00000000 00000000 c3a45f40 c3a45f60 c6979df8 00000000 
Nov 14 23:43:53 paulus 00000003 00000000 00000002 00000000 c013d771 c3a45f40 40126000 00000400 
Nov 14 23:43:53 paulus Call Trace:
Nov 14 23:43:53 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:43:53 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:43:53 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:43:53 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:43:53 paulus 
Nov 14 23:43:53 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:44:00 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:44:00 paulus printing eip:
Nov 14 23:44:00 paulus c01edc78
Nov 14 23:44:00 paulus *pde = 09df5067
Nov 14 23:44:00 paulus *pte = 00000000
Nov 14 23:44:00 paulus Oops: 0000
Nov 14 23:44:00 paulus crc32 apm rtc  
Nov 14 23:44:00 paulus CPU:    0
Nov 14 23:44:00 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:44:00 paulus EFLAGS: 00010282
Nov 14 23:44:00 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:44:00 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:44:00 paulus esi: ffffffff   edi: c6979f20   ebp: c9f46954   esp: c363ff30
Nov 14 23:44:00 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:44:00 paulus Process lspci (pid: 3180, threadinfo=c363e000 task=c5d08700)
Nov 14 23:44:00 paulus Stack: c6979f20 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:44:00 paulus c6979f20 c9f46800 00000000 00000000 c5ce0e40 c5ce0e60 c6979f38 00000000 
Nov 14 23:44:00 paulus 00000003 00000000 00000002 00000000 c013d771 c5ce0e40 40126000 00000400 
Nov 14 23:44:00 paulus Call Trace:
Nov 14 23:44:00 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:44:00 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:44:00 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:44:00 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:44:00 paulus 
Nov 14 23:44:00 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:44:04 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:44:04 paulus printing eip:
Nov 14 23:44:04 paulus c01edc78
Nov 14 23:44:04 paulus *pde = 09df5067
Nov 14 23:44:04 paulus *pte = 00000000
Nov 14 23:44:04 paulus Oops: 0000
Nov 14 23:44:04 paulus crc32 apm rtc  
Nov 14 23:44:04 paulus CPU:    0
Nov 14 23:44:04 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:44:04 paulus EFLAGS: 00010282
Nov 14 23:44:04 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:44:04 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:44:04 paulus esi: ffffffff   edi: c6979da0   ebp: c9f46954   esp: c32d3f30
Nov 14 23:44:04 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:44:04 paulus Process lspci (pid: 3198, threadinfo=c32d2000 task=c4074120)
Nov 14 23:44:04 paulus Stack: c6979da0 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:44:04 paulus c6979da0 c9f46800 00000000 00000000 c5bfb3a0 c5bfb3c0 c6979db8 00000000 
Nov 14 23:44:04 paulus 00000003 00000000 00000002 00000000 c013d771 c5bfb3a0 40126000 00000400 
Nov 14 23:44:04 paulus Call Trace:
Nov 14 23:44:04 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:44:04 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:44:04 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:44:04 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:44:04 paulus 
Nov 14 23:44:04 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:46:58 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:46:58 paulus printing eip:
Nov 14 23:46:58 paulus c01edc78
Nov 14 23:46:58 paulus *pde = 09df5067
Nov 14 23:46:58 paulus *pte = 00000000
Nov 14 23:46:58 paulus Oops: 0000
Nov 14 23:46:58 paulus crc32 apm rtc  
Nov 14 23:46:58 paulus CPU:    0
Nov 14 23:46:58 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:46:58 paulus EFLAGS: 00010282
Nov 14 23:46:58 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:46:58 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:46:58 paulus esi: ffffffff   edi: c6979520   ebp: c9f46954   esp: c271ff30
Nov 14 23:46:58 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:46:58 paulus Process lspci (pid: 4067, threadinfo=c271e000 task=c4074740)
Nov 14 23:46:58 paulus Stack: c6979520 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:46:58 paulus c6979520 c9f46800 00000000 00000000 c4904620 c4904640 c6979538 00000000 
Nov 14 23:46:58 paulus 00000003 00000000 00000002 00000000 c013d771 c4904620 40126000 00000400 
Nov 14 23:46:58 paulus Call Trace:
Nov 14 23:46:58 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:46:58 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:46:58 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:46:58 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:46:58 paulus 
Nov 14 23:46:58 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:47:01 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:47:01 paulus printing eip:
Nov 14 23:47:01 paulus c01edc78
Nov 14 23:47:01 paulus *pde = 09df5067
Nov 14 23:47:01 paulus *pte = 00000000
Nov 14 23:47:01 paulus Oops: 0000
Nov 14 23:47:01 paulus crc32 apm rtc  
Nov 14 23:47:01 paulus CPU:    0
Nov 14 23:47:01 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:47:01 paulus EFLAGS: 00010282
Nov 14 23:47:01 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:47:01 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:47:01 paulus esi: ffffffff   edi: c69794e0   ebp: c9f46954   esp: c2caff30
Nov 14 23:47:01 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:47:01 paulus Process cat (pid: 4076, threadinfo=c2cae000 task=c4074740)
Nov 14 23:47:01 paulus Stack: c69794e0 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:47:01 paulus c69794e0 c9f46800 00000000 00000000 c5b8c140 c5b8c160 c69794f8 00000000 
Nov 14 23:47:01 paulus 00000003 00000000 00000002 00000000 c013d771 c5b8c140 0804cf80 00000400 
Nov 14 23:47:01 paulus Call Trace:
Nov 14 23:47:01 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:47:01 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:47:01 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:47:01 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:47:01 paulus 
Nov 14 23:47:01 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:47:05 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:47:05 paulus printing eip:
Nov 14 23:47:05 paulus c01edc78
Nov 14 23:47:05 paulus *pde = 09df5067
Nov 14 23:47:05 paulus *pte = 00000000
Nov 14 23:47:05 paulus Oops: 0000
Nov 14 23:47:05 paulus crc32 apm rtc  
Nov 14 23:47:05 paulus CPU:    0
Nov 14 23:47:05 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:47:05 paulus EFLAGS: 00010282
Nov 14 23:47:05 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:47:05 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:47:05 paulus esi: ffffffff   edi: c69794a0   ebp: c9f46954   esp: c2c8bf30
Nov 14 23:47:05 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:47:05 paulus Process less (pid: 4093, threadinfo=c2c8a000 task=c4074740)
Nov 14 23:47:05 paulus Stack: c69794a0 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:47:05 paulus c69794a0 c9f46800 00000000 00000000 c4001920 c4001940 c69794b8 00000000 
Nov 14 23:47:05 paulus 00000003 00000000 00000002 00000000 c013d771 c4001920 08063a7c 00002000 
Nov 14 23:47:05 paulus Call Trace:
Nov 14 23:47:05 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:47:05 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:47:05 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:47:05 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:47:05 paulus 
Nov 14 23:47:05 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:47:15 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:47:15 paulus printing eip:
Nov 14 23:47:15 paulus c01edc78
Nov 14 23:47:15 paulus *pde = 09df5067
Nov 14 23:47:15 paulus *pte = 00000000
Nov 14 23:47:15 paulus Oops: 0000
Nov 14 23:47:15 paulus crc32 apm rtc  
Nov 14 23:47:15 paulus CPU:    0
Nov 14 23:47:15 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:47:15 paulus EFLAGS: 00010282
Nov 14 23:47:15 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:47:15 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:47:15 paulus esi: ffffffff   edi: c6979460   ebp: c9f46954   esp: c2e9df30
Nov 14 23:47:15 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:47:15 paulus Process cat (pid: 4143, threadinfo=c2e9c000 task=c4009360)
Nov 14 23:47:15 paulus Stack: c6979460 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:47:15 paulus c6979460 c9f46800 00000000 00000000 c5f2d960 c5f2d980 c6979478 00000000 
Nov 14 23:47:15 paulus 00000003 00000000 00000002 00000000 c013d771 c5f2d960 0804cf80 00000400 
Nov 14 23:47:15 paulus Call Trace:
Nov 14 23:47:15 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:47:15 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:47:15 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:47:15 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:47:15 paulus 
Nov 14 23:47:15 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:47:47 paulus <1>Unable to handle kernel paging request at virtual address ca8865e8
Nov 14 23:47:47 paulus printing eip:
Nov 14 23:47:47 paulus c01edc78
Nov 14 23:47:47 paulus *pde = 09df5067
Nov 14 23:47:47 paulus *pte = 00000000
Nov 14 23:47:47 paulus Oops: 0000
Nov 14 23:47:47 paulus crc32 apm rtc  
Nov 14 23:47:47 paulus CPU:    0
Nov 14 23:47:47 paulus EIP:    0060:[<c01edc78>]    Not tainted
Nov 14 23:47:47 paulus EFLAGS: 00010282
Nov 14 23:47:47 paulus EIP is at show_device+0xe0/0x10c
Nov 14 23:47:47 paulus eax: ca8865e0   ebx: 000000c4   ecx: fffffffe   edx: 000001b2
Nov 14 23:47:47 paulus esi: ffffffff   edi: c6979120   ebp: c9f46954   esp: c2983f30
Nov 14 23:47:47 paulus ds: 0068   es: 0068   ss: 0068
Nov 14 23:47:47 paulus Process lspci (pid: 4257, threadinfo=c2982000 task=c4075380)
Nov 14 23:47:47 paulus Stack: c6979120 00000000 c9f46800 00000125 c9f4695c c9f46958 ca8865e0 c01558ba 
Nov 14 23:47:47 paulus c6979120 c9f46800 00000000 00000000 c5ce0240 c5ce0260 c6979138 00000000 
Nov 14 23:47:47 paulus 00000003 00000000 00000002 00000000 c013d771 c5ce0240 40126000 00000400 
Nov 14 23:47:47 paulus Call Trace:
Nov 14 23:47:47 paulus [<c01558ba>] seq_read+0x186/0x28c
Nov 14 23:47:47 paulus [<c013d771>] vfs_read+0xc1/0x158
Nov 14 23:47:47 paulus [<c013da40>] sys_read+0x28/0x3c
Nov 14 23:47:47 paulus [<c0108907>] syscall_call+0x7/0xb
Nov 14 23:47:47 paulus 
Nov 14 23:47:47 paulus Code: ff 70 08 68 94 41 2f c0 57 e8 a6 80 f6 ff 83 c4 0c 8b 57 0c 
Nov 14 23:58:36 paulus init: Switching to runlevel: 6

It then prompted for root password or ^D for normal startup.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"[The question of] copy protection has long been answered, and it's only
  a matter of months until more or less all CDs will be published with
  copy protection."  --"Ihr EMI Team" 
    http://www.theregister.co.uk/content/54/27960.html

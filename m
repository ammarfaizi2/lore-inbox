Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRDFFl1>; Fri, 6 Apr 2001 01:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRDFFlR>; Fri, 6 Apr 2001 01:41:17 -0400
Received: from mail.tor.primus.ca ([216.254.136.21]:28769 "EHLO
	mail1.tor.primus.ca") by vger.kernel.org with ESMTP
	id <S131275AbRDFFlA>; Fri, 6 Apr 2001 01:41:00 -0400
Date: Fri, 6 Apr 2001 01:40:29 -0400
From: Patrick McLean <chutzpah@linuxfreak.com>
To: linux-kernel@vger.kernel.org
Subject: lockup/crash in 2.4.3 (kernel BUG at exit.c:458!)
Message-ID: <20010406014029.A2635@chutz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I installed 2.4.3, my system would seemingly randomly hadn, about once a 
day. It hung at least 3 times, but it looks like theres only entries in my 
syslog for 2 of those times, my system is an AMD Thununderbird 1Ghz, 256MB RAM,
VIA KX133A chipset (Abit KT7A), if there's any other info you need let me know,
and please CC me any responses, I'm not subscribed to the list.

I'm not exactly up on kernel internals, and I can't really provide any info about
what could have caused it.

Here's what showed up in my syslog:

Apr  1 08:05:00 chutz kernel: Unable to handle kernel paging request at virtual address 00001030
Apr  1 08:05:00 chutz kernel:  printing eip:
Apr  1 08:05:00 chutz kernel: c01343a6
Apr  1 08:05:00 chutz kernel: *pde = 00000000
Apr  1 08:05:00 chutz kernel: Oops: 0002
Apr  1 08:05:00 chutz kernel: CPU:    0
Apr  1 08:05:00 chutz kernel: EIP:    0010:[try_to_free_buffers+150/816]
Apr  1 08:05:00 chutz kernel: EFLAGS: 00210206
Apr  1 08:05:00 chutz kernel: eax: 00001000   ebx: c9fb19c0   ecx: 00000000   edx: cfd5d740
Apr  1 08:05:00 chutz kernel: esi: c9fb19c0   edi: c9fb19c0   ebp: 00000000   esp: c1479f54
Apr  1 08:05:00 chutz kernel: ds: 0018   es: 0018   ss: 0018
Apr  1 08:05:00 chutz kernel: Process bdflush (pid: 5, stackpage=c1479000)
Apr  1 08:05:00 chutz kernel: Stack: 00000000 00000003 c1479f88 ceff87c0 00000008 00000000 00000001 00200213
Apr  1 08:05:00 chutz kernel:        00000001 000001de c012ad43 00000000 c1073490 00000000 00000007 c0129e27
Apr  1 08:05:00 chutz kernel:        c1073490 00000000 00000000 00000004 00000000 00000001 00002f99 00000000
Apr  1 08:05:00 chutz kernel: Call Trace: [free_shortage+35/208] [page_launder+871/2208] [bdflush+140/288] [init+0/384] [init+0/384] [kernel_thread+38/48] [bdflush+0/288]
Apr  1 08:05:00 chutz kernel:
Apr  1 08:05:00 chutz kernel: Code: 89 50 30 8b 53 30 8b 03 89 02 c7 43 30 00 00 00 00 8b 53 24
Apr  1 08:05:00 chutz kernel: kernel BUG at exit.c:458!
Apr  1 08:05:00 chutz kernel: invalid operand: 0000
Apr  1 08:05:00 chutz kernel: CPU:    0
Apr  1 08:05:00 chutz kernel: EIP:    0010:[do_exit+512/528]
Apr  1 08:05:00 chutz kernel: EFLAGS: 00010282
Apr  1 08:05:00 chutz kernel: eax: 0000001a   ebx: 00000000   ecx: 00000001   edx: c0256308
Apr  1 08:05:00 chutz kernel: esi: c1478000   edi: 0000000b   ebp: c0218880   esp: c1479e40
Apr  1 08:05:00 chutz kernel: ds: 0018   es: 0018   ss: 0018
Apr  1 08:05:00 chutz kernel: Process bdflush (pid: 5, stackpage=c1479000)
Apr  1 08:05:00 chutz kernel: Stack: c0219c05 c0219c9c 000001ca c0218880 c01077a9 c02145e1 c021472d 00000000
Apr  1 08:05:00 chutz kernel:        00000002 00001030 c0110858 0000000b c1479f20 00000002 00000000 c1478000
Apr  1 08:05:00 chutz kernel:        c1478000 c147200c 00000047 00030001 c02cb620 c1473000 00000001 c02cb7b4
Apr  1 08:05:00 chutz kernel: Call Trace: [die+57/80] [do_page_fault+824/1056] [__make_request+311/1680] [__make_request+616/1680] [__make_request+640/1680] [ide_do_request+675/752] [do_page_fault+0/1056]
Apr  1 08:05:00 chutz kernel:        [error_code+52/60] [try_to_free_buffers+150/816] [free_shortage+35/208] [page_launder+871/2208] [bdflush+140/288] [init+0/384] [init+0/384] [kernel_thread+38/48]
Apr  1 08:05:00 chutz kernel:        [bdflush+0/288]
Apr  1 08:05:00 chutz kernel:
Apr  1 08:05:00 chutz kernel: Code: 0f 0b 83 c4 0c e9 57 fe ff ff 8d b6 00 00 00 00 55 57 56 53
Apr  1 08:05:00 chutz kernel: kernel BUG at exit.c:458!
Apr  1 08:05:00 chutz kernel: invalid operand: 0000
Apr  1 08:05:00 chutz kernel: CPU:    0
Apr  1 08:05:00 chutz kernel: EIP:    0010:[do_exit+512/528]
Apr  1 08:05:00 chutz kernel: EFLAGS: 00013282
Apr  1 08:05:00 chutz kernel: eax: 0000001a   ebx: 00000000   ecx: 00000001   edx: c0256308
Apr  1 08:05:00 chutz kernel: esi: c1478000   edi: 0000000b   ebp: c0218880   esp: c1479d18
Apr  1 08:05:00 chutz kernel: ds: 0018   es: 0018   ss: 0018
Apr  1 08:05:00 chutz kernel: Process bdflush (pid: 5, stackpage=c1479000)
Apr  1 08:05:00 chutz kernel: Stack: c0219c05 c0219c9c 000001ca c1479e0c 00000000 c0107ab0 c0218880 c1479e0c
Apr  1 08:05:00 chutz kernel:        00000000 c0107ab0 c0107b62 0000000b c024ab80 30000000 00000000 c1479d64
Apr  1 08:05:00 chutz kernel:        00000000 c1479d6c 00000000 c1479d74 ffffffff c024ab80 20000000 00343538
Apr  1 08:05:00 chutz kernel: Call Trace: [do_invalid_op+0/192] [do_invalid_op+0/192] [do_invalid_op+178/192] [do_exit+512/528] [do_notify_parent+197/224] [vsprintf+908/960] [error_code+52/60]
Apr  1 08:05:00 chutz kernel:        [do_exit+512/528] [die+57/80] [do_page_fault+824/1056] [__make_request+311/1680] [__make_request+616/1680] [__make_request+640/1680] [ide_do_request+675/752] [do_page_fault+0/1056]
Apr  1 08:05:00 chutz kernel:        [error_code+52/60] [try_to_free_buffers+150/816] [free_shortage+35/208] [page_launder+871/2208] [bdflush+140/288] [init+0/384] [init+0/384] [kernel_thread+38/48]
Apr  1 08:05:00 chutz kernel:        [bdflush+0/288]
Apr  1 08:05:00 chutz kernel:
Apr  1 08:05:00 chutz kernel: Code: 0f 0b 83 c4 0c e9 57 fe ff ff 8d b6 00 00 00 00 55 57 56 53
Apr  1 08:05:00 chutz kernel: kernel BUG at exit.c:458!
Apr  1 08:05:00 chutz kernel: invalid operand: 0000
Apr  1 08:05:00 chutz kernel: CPU:    0
Apr  1 08:05:00 chutz kernel: EIP:    0010:[do_exit+512/528]
Apr  1 08:05:00 chutz kernel: EFLAGS: 00210282
Apr  1 08:05:00 chutz kernel: eax: 0000001a   ebx: 00000000   ecx: 00000001   edx: c0256308
Apr  1 08:05:00 chutz kernel: esi: c1478000   edi: 0000000b   ebp: c0218880   esp: c1479bf0
Apr  1 08:05:00 chutz kernel: ds: 0018   es: 0018   ss: 0018
Apr  1 08:05:00 chutz kernel: Process bdflush (pid: 5, stackpage=c1479000)
Apr  1 08:05:00 chutz kernel: Stack: c0219c05 c0219c9c 000001ca c0218880 00000001 00000018 00000018 c1479ce4
Apr  1 08:05:00 chutz kernel:        00000000 c0107ab0 c0107b62 0000000b 30000000 34376530 63303133 c024ab80
Apr  1 08:05:00 chutz kernel:        30000000 00000000 00000000 c1479c4c ffffffff c024ab80 20000000 00343538
Apr  1 08:05:00 chutz kernel: Call Trace: [do_invalid_op+0/192] [do_invalid_op+178/192] [do_exit+512/528] [do_notify_parent+197/224] [vsprintf+908/960] [error_code+52/60] [do_exit+512/528]
Apr  1 08:05:00 chutz kernel:        [do_invalid_op+0/192] [do_invalid_op+0/192] [do_invalid_op+178/192] [do_exit+512/528] [do_notify_parent+197/224] [vsprintf+908/960] [error_code+52/60] [do_exit+512/528]
Apr  1 08:05:00 chutz kernel:        [die+57/80] [do_page_fault+824/1056] [__make_request+311/1680] [__make_request+616/1680] [__make_request+640/1680] [ide_do_request+675/752] [do_page_fault+0/1056] [error_code+52/60]
Apr  1 08:05:00 chutz kernel:        [try_to_free_buffers+150/816] [free_shortage+35/208] [page_launder+871/2208] [bdflush+140/288]
[init+0/384] [init+0/384] [kernel_thread+38/48] [bdflush+0/288]
Apr  1 08:05:00 chutz kernel:
Apr  1 08:05:00 chutz kernel: Code: 0f 0b 83 c4 0c e9 57 fe ff ff 8d b6 00 00 00 00 55 57 56 53
Apr  1 08:05:00 chutz kernel: kernel BUG at exit.c:458!
Apr  1 08:05:00 chutz kernel: invalid operand: 0000
Apr  1 08:05:00 chutz kernel: CPU:    0
Apr  1 08:05:00 chutz kernel: EIP:    0010:[do_exit+512/528]
Apr  1 08:05:00 chutz kernel: EFLAGS: 00210286
Apr  1 08:05:00 chutz kernel: eax: 0000001a   ebx: 00000000   ecx: fffffffd   edx: cf547f5c
Apr  1 19:46:00 chutz syslogd 1.3-3: restart.

*snip*

Apr  4 17:07:02 chutz kernel: Unable to handle kernel paging request at virtual address f000e83c
Apr  4 17:07:02 chutz kernel:  printing eip:
Apr  4 17:07:02 chutz kernel: c0134538
Apr  4 17:07:02 chutz kernel: *pde = 00000000
Apr  4 17:07:02 chutz kernel: Oops: 0000
Apr  4 17:07:02 chutz kernel: CPU:    0
Apr  4 17:07:02 chutz kernel: EIP:    0010:[try_to_free_buffers+552/816]
Apr  4 17:07:02 chutz kernel: EFLAGS: 00010202
Apr  4 17:07:02 chutz kernel: eax: f000e814   ebx: 00000001   ecx: 00000001   edx: f000e814
Apr  4 17:07:02 chutz kernel: esi: f000e814   edi: c19f50c0   ebp: 00000001   esp: c147df04
Apr  4 17:07:02 chutz kernel: ds: 0018   es: 0018   ss: 0018
Apr  4 16:10:16 chutz syslogd 1.3-3: restart.



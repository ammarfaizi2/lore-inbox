Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUIOMQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUIOMQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUIOMQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:16:50 -0400
Received: from gandalf.ios.edu.pl ([193.0.91.125]:24492 "EHLO
	gandalf.ios.edu.pl") by vger.kernel.org with ESMTP id S265161AbUIOMQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:16:46 -0400
Message-ID: <414834AA.70602@ios.edu.pl>
Date: Wed, 15 Sep 2004 14:25:14 +0200
From: =?ISO-8859-2?Q?Marcin_Ro=BFek?= <marcin.rozek@ios.edu.pl>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-From: marcin.rozek@ios.edu.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here's what i can see in syslog (Mandrake 10 Official with kernel 2.4.27 and 
grsecurity patch)

kernel: kernel BUG at page_alloc.c:144!
kernel: invalid operand: 0000
kernel: CPU:    1
kernel: EIP:    0010:[__free_pages_ok+82/784]    Not tainted
kernel: EIP:    0010:[<c01d4a62>]    Not tainted
kernel: EFLAGS: 00010286
kernel: eax: 00000000   ebx: c13ae7e8   ecx: c13ae7e8   edx: 00000000
kernel: esi: 00000008   edi: 00000000   ebp: c01037c0   esp: c2fdfe3c
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process smbd (pid: 30808, stackpage=c2fdf000)
kernel: Stack: c01d48ff 00000000 00141000 c1149a9c c1149a9c c01d5ad8 c01037c0 
00141100
kernel:        dfe8dbf0 00000002 00000008 00141000 de305160 c01c6ff0 00141100 
c2fdfe7c
kernel:        00001411 00000000 00141000 dd9490c0 c01c715f 00141000 86838614 
26838614
kernel: Call Trace:    [rw_swap_page+63/96] [read_swap_cache_async+104/199] 
[swapin_readahead+48/112] [do_swap_page+303/368] [handle_mm_fault+385/608]
kernel: Call Trace:    [<c01d48ff>] [<c01d5ad8>] [<c01c6ff0>] [<c01c715f>] 
[<c01c76a1>]
kernel:   [do_page_fault+1264/1856] [generic_file_write+276/352] 
[ext3_file_write+57/192] [sys_write+279/368] [do_page_fault+0/1856] 
[error_code+52/64]
kernel:   [<c01b0d90>] [<c01ce6c4>] [<c020d659>] [<c01dd027>] [<c01b08a0>] 
[<c01a2304>]
kernel:
kernel: Code: 0f 0b 90 00 28 76 3b c0 8b 35 90 14 16 c0 89 d8 29 f0 c1 f8



kernel: kernel BUG at page_alloc.c:144!
kernel: invalid operand: 0000
kernel: CPU:    1
kernel: EIP:    0010:[__free_pages_ok+82/784]    Not tainted
kernel: EIP:    0010:[<c01d4a62>]    Not tainted
kernel: EFLAGS: 00010286
kernel: eax: 00000000   ebx: c13ae7e8   ecx: c01039d8   edx: c0103820
kernel: esi: c13ae7e8   edi: 00000000   ebp: c01037c0   esp: c1591f08
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process kswapd (pid: 5, stackpage=c1591000)
kernel: Stack: 00000001 00000286 00000003 c8f9ae40 c8f9ae40 c8f9ae40 c13ae7e8 
c01e1eeb
kernel:        c8f9ae40 00000000 c13ae7e8 c01038fc 00004a6a c01d4074 c13ae7e8 
000001d0
kernel:        00000c80 000001d0 00000020 00000020 000001d0 c01038fc c01038fc 
c01d42ea
kernel: Call Trace:    [try_to_free_buffers+235/368] [shrink_cache+884/1072] 
[shrink_caches+74/96] [try_to_free_pages_zone+88/256] [schedule+738/1344]
kernel: Call Trace:    [<c01e1eeb>] [<c01d4074>] [<c01d42ea>] [<c01d4358>] 
[<c01b2052>]
kernel:   [kswapd_balance_pgdat+86/176] [kswapd_balance+40/64] [kswapd+152/185] 
[arch_kernel_thread+46/64] [kswapd+0/185]
kernel:   [<c01d4516>] [<c01d4598>] [<c01d46d8>] [<c01a068e>] [<c01d4640>]
kernel:
kernel: Code: 0f 0b 90 00 28 76 3b c0 8b 35 90 14 16 c0 89 d8 29 f0 c1 f8

Output from scripts/ver_linux
Linux blabla 2.4.27-grsec3 #1 SMP pon wrz 13 17:57:49 CEST 2004 i686 unknown 
unknown GNU/Linux
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.34
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.1.2
Modules Loaded

I can't reproduce this. It just 'happens'.

Regards,
Marcin

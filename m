Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbSKLVlk>; Tue, 12 Nov 2002 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbSKLVlk>; Tue, 12 Nov 2002 16:41:40 -0500
Received: from mail.hometree.net ([212.34.181.120]:55007 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S266967AbSKLVla>; Tue, 12 Nov 2002 16:41:30 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: [2.4] Oops in ext3 / Network
Date: Tue, 12 Nov 2002 21:48:18 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aqrsv2$net$1@forge.intermeta.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1037137698 19014 212.34.181.4 (12 Nov 2002 21:48:18 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 12 Nov 2002 21:48:18 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While copying largeish amounts of data over SMB.  Almost stock RedHat
7.3, Kernel 2.4.18-17.7.x

% cat /proc/cpuinfo  
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 199.425
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
bogomips        : 395.94

% cat  /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  195579904 186048512  9531392        0 20099072 108785664
Swap: 542826496        0 542826496

% /sbin/lspci -vvt
-[00]-+-00.0  Intel Corp. 440FX - 82441FX PMC [Natoma]
      +-07.0  Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II]
      +-07.1  Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
      +-0c.0  3Com Corporation 3c900 Combo [Boomerang]
      \-0e.0  ATI Technologies Inc 215CT [Mach64 CT]

Filesystems mounted as ext3 in ordered data mode, busily running SMB
to a Windows 2000 workstation. Some more stuff running in the
background (httpd, NFS, named, ntpd, LDAP server).

Nov 12 02:01:19 amy kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000681
Nov 12 02:01:19 amy kernel:  printing eip:
Nov 12 02:01:19 amy kernel: c01cd6b6
Nov 12 02:01:19 amy kernel: *pde = 00000000
Nov 12 02:01:19 amy kernel: Oops: 0002
Nov 12 02:01:19 amy kernel: autofs nfsd lockd sunrpc 3c59x ext3 jbd  
Nov 12 02:01:19 amy kernel: CPU:    0
Nov 12 02:01:19 amy kernel: EIP:    0010:[<c01cd6b6>]    Not tainted
Nov 12 02:01:19 amy kernel: EFLAGS: 00010206
Nov 12 02:01:19 amy kernel: 
Nov 12 02:01:19 amy kernel: EIP is at alloc_skb [kernel] 0x126 (2.4.18-17.7.x)
Nov 12 02:01:19 amy kernel: eax: 00000681   ebx: c6c6dd40   ecx: 000006bc   edx: 00000680
Nov 12 02:01:19 amy kernel: esi: 000001f0   edi: 0000056f   ebp: c39796b8   esp: c2437e40
Nov 12 02:01:19 amy kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 02:01:19 amy kernel: Process gzip (pid: 20872, stackpage=c2437000)
Nov 12 02:01:19 amy kernel: Stack: cbe841c0 00000000 c01eaaf8 00000680 000001f0 c01fa7bd c3979580 c1763640 
Nov 12 02:01:19 amy kernel:        00002000 0000cb52 00000002 00000000 c2437e98 c91f1110 080936d7 00001d89 
Nov 12 02:01:19 amy kernel:        00002277 0000056f 00000000 00000000 c2437f50 00000001 00000000 7fffffff 
Nov 12 02:01:20 amy kernel: Call Trace: [<c01eaaf8>] tcp_sendmsg [kernel] 0x218 (0xc2437e48))
Nov 12 02:01:20 amy kernel: [<c01fa7bd>] tcp_v4_rcv [kernel] 0x36d (0xc2437e54))
Nov 12 02:01:20 amy kernel: [<c01e3552>] ip_local_deliver [kernel] 0xf2 (0xc2437ea8))
Nov 12 02:01:20 amy kernel: [<c0205365>] inet_sendmsg [kernel] 0x35 (0xc2437ed0))
Nov 12 02:01:20 amy kernel: [<c01ca5cc>] sock_sendmsg [kernel] 0x6c (0xc2437ee4))
Nov 12 02:01:20 amy kernel: [<c01ca7e7>] sock_write [kernel] 0xa7 (0xc2437f38))
Nov 12 02:01:20 amy kernel: [<c0139a66>] sys_write [kernel] 0x96 (0xc2437f7c))
Nov 12 02:01:20 amy kernel: [<c0115855>] schedule [kernel] 0x215 (0xc2437f98))
Nov 12 02:01:20 amy kernel: [<c0108943>] system_call [kernel] 0x33 (0xc2437fc0))
Nov 12 02:01:20 amy kernel: 
Nov 12 02:01:20 amy kernel: 
Nov 12 02:01:20 amy kernel: Code: c7 00 01 00 00 00 8b 83 88 00 00 00 c7 40 04 00 00 00 00 8b 
Nov 12 02:01:20 amy kernel:  <1>Unable to handle kernel paging request at virtual address da8ae818
Nov 12 02:01:20 amy kernel:  printing eip:
Nov 12 02:01:20 amy kernel: c012f4a1
Nov 12 02:01:20 amy kernel: *pde = 00000000
Nov 12 02:01:20 amy kernel: Oops: 0000
Nov 12 02:01:20 amy kernel: autofs nfsd lockd sunrpc 3c59x ext3 jbd  
Nov 12 02:01:20 amy kernel: CPU:    0
Nov 12 02:01:20 amy kernel: EIP:    0010:[<c012f4a1>]    Not tainted
Nov 12 02:01:20 amy kernel: EFLAGS: 00010002
Nov 12 02:01:20 amy kernel: 
Nov 12 02:01:21 amy kernel: EIP is at kmalloc [kernel] 0xa1 (2.4.18-17.7.x)
Nov 12 02:01:21 amy kernel: eax: c54efb38   ebx: c18255e0   ecx: c54efb20   edx: 00000800
Nov 12 02:01:21 amy kernel: esi: c54efb38   edi: 00000246   ebp: 00000001   esp: c138fe14
Nov 12 02:01:21 amy kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 02:01:21 amy kernel: Process sendbackup (pid: 20870, stackpage=c138f000)
Nov 12 02:01:21 amy kernel: Stack: c2861cd0 00000000 00000000 c1367980 cacd2280 000001f0 ffffffe0 c3979bb8 
Nov 12 02:01:21 amy kernel:        c01cd66c 000006bc 000001f0 c3979ae8 c138ff50 c01eaaf8 00000680 000001f0 
Nov 12 02:01:21 amy kernel:        c4521040 c1367980 c10c2510 cc81fe54 c1367980 cc81fe65 caaf3500 c4521040 
Nov 12 02:01:21 amy kernel: Call Trace: [<c01cd66c>] alloc_skb [kernel] 0xdc (0xc138fe34))
Nov 12 02:01:21 amy kernel: [<c01eaaf8>] tcp_sendmsg [kernel] 0x218 (0xc138fe48))
Nov 12 02:01:21 amy kernel: [<cc81fe54>] ext3_mark_iloc_dirty [ext3] 0x24 (0xc138fe60))
Nov 12 02:01:21 amy kernel: [<cc81fe65>] ext3_mark_iloc_dirty [ext3] 0x35 (0xc138fe68))
Nov 12 02:01:21 amy kernel: [<cc80e631>] journal_stop_Rad82b28a [jbd] 0x1b1 (0xc138fe98))
Nov 12 02:01:21 amy kernel: [<c0126d54>] do_wp_page [kernel] 0x54 (0xc138fea4))
Nov 12 02:01:21 amy kernel: [<c0205365>] inet_sendmsg [kernel] 0x35 (0xc138fed0))
Nov 12 02:01:21 amy kernel: [<c01ca5cc>] sock_sendmsg [kernel] 0x6c (0xc138fee4))
Nov 12 02:01:21 amy kernel: [<c01ca7e7>] sock_write [kernel] 0xa7 (0xc138ff38))
Nov 12 02:01:21 amy kernel: [<c0139a66>] sys_write [kernel] 0x96 (0xc138ff7c))
Nov 12 02:01:21 amy kernel: [<c011bc3b>] sys_gettimeofday [kernel] 0x1b (0xc138ffa0))
Nov 12 02:01:21 amy kernel: [<c0108943>] system_call [kernel] 0x33 (0xc138ffc0))
Nov 12 02:01:21 amy kernel: 
Nov 12 02:01:21 amy kernel: 
Nov 12 02:01:21 amy kernel: Code: 8b 44 81 18 0f af f2 89 41 14 01 ee 40 75 16 8b 41 04 8b 11 
Nov 12 02:01:22 amy kernel:  <1>Unable to handle kernel paging request at virtual address da8ae818
Nov 12 02:01:22 amy kernel:  printing eip:
Nov 12 02:01:22 amy kernel: c012f4a1
Nov 12 02:01:22 amy kernel: *pde = 00000000
Nov 12 02:01:22 amy kernel: Oops: 0000
Nov 12 02:01:22 amy kernel: autofs nfsd lockd sunrpc 3c59x ext3 jbd  
Nov 12 02:01:22 amy kernel: CPU:    0
Nov 12 02:01:22 amy kernel: EIP:    0010:[<c012f4a1>]    Not tainted
Nov 12 02:01:22 amy kernel: EFLAGS: 00010006
Nov 12 02:01:22 amy kernel: 
Nov 12 02:01:22 amy kernel: EIP is at kmalloc [kernel] 0xa1 (2.4.18-17.7.x)
Nov 12 02:01:22 amy kernel: eax: c54efb38   ebx: c18255e0   ecx: c54efb20   edx: 00000800
Nov 12 02:01:22 amy kernel: esi: c54efb38   edi: 00000246   ebp: 00000001   esp: c9e79e14
Nov 12 02:01:22 amy kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 02:01:22 amy kernel: Process sed (pid: 20877, stackpage=c9e79000)
Nov 12 02:01:22 amy kernel: Stack: c6dd5c60 c63441b8 c63441b8 c01f4abb c6dd5bc0 000001f0 ffffffe0 c63441b8 
Nov 12 02:01:22 amy kernel:        c01cd66c 000006bc 000001f0 c63440e8 c9e79f50 c01eaaf8 00000680 000001f0 
Nov 12 02:01:22 amy kernel:        c017305c c9e79e6c c9e79e6c 00000000 c011f9a6 00000001 c011fb37 00000001 
Nov 12 02:01:22 amy kernel: Call Trace: [<c01f4abb>] tcp_push_one [kernel] 0x7b (0xc9e79e20))
Nov 12 02:01:22 amy kernel: [<c01cd66c>] alloc_skb [kernel] 0xdc (0xc9e79e34))
Nov 12 02:01:22 amy kernel: [<c01eaaf8>] tcp_sendmsg [kernel] 0x218 (0xc9e79e48))
Nov 12 02:01:22 amy kernel: [<c017305c>] batch_entropy_process [kernel] 0xac (0xc9e79e54))
Nov 12 02:01:22 amy kernel: [<c011f9a6>] update_wall_time [kernel] 0x16 (0xc9e79e64))
Nov 12 02:01:22 amy kernel: [<c011fb37>] timer_bh [kernel] 0x27 (0xc9e79e6c))
Nov 12 02:01:22 amy kernel: [<c011c5db>] bh_action [kernel] 0x1b (0xc9e79e94))
Nov 12 02:01:23 amy kernel: [<c011c4e4>] tasklet_hi_action [kernel] 0x44 (0xc9e79e98))
Nov 12 02:01:23 amy kernel: [<c011c30b>] do_softirq [kernel] 0x4b (0xc9e79eac))
Nov 12 02:01:23 amy kernel: [<c0205365>] inet_sendmsg [kernel] 0x35 (0xc9e79ed0))
Nov 12 02:01:23 amy kernel: [<c01ca5cc>] sock_sendmsg [kernel] 0x6c (0xc9e79ee4))
Nov 12 02:01:23 amy kernel: [<c0115855>] schedule [kernel] 0x215 (0xc9e79f00))
Nov 12 02:01:23 amy kernel: [<c01ca7e7>] sock_write [kernel] 0xa7 (0xc9e79f38))
Nov 12 02:01:23 amy kernel: [<c0139a66>] sys_write [kernel] 0x96 (0xc9e79f7c))
Nov 12 02:01:23 amy kernel: [<c0108943>] system_call [kernel] 0x33 (0xc9e79fc0))
Nov 12 02:01:23 amy kernel: 
Nov 12 02:01:23 amy kernel: 
Nov 12 02:01:23 amy kernel: Code: 8b 44 81 18 0f af f2 89 41 14 01 ee 40 75 16 8b 41 04 8b 11 

After this the box paniced; this is a headless server without
serial console, so I saw Caps Lock and Num Lock blink and that was
it. Reset button time.

	Regards
		Henning



-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

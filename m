Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318006AbSGWJgw>; Tue, 23 Jul 2002 05:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSGWJgw>; Tue, 23 Jul 2002 05:36:52 -0400
Received: from stargate.vo.lu ([212.24.194.17]:26920 "EHLO stargate.vo.lu")
	by vger.kernel.org with ESMTP id <S318006AbSGWJgp>;
	Tue, 23 Jul 2002 05:36:45 -0400
Subject: PROBLEM : kernel BUG at page_alloc.c:131
From: Manuel FLURY <manuel.flury@amslux.lu>
Reply-To: manuel.flury@free.fr
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5-1mdk 
Date: 23 Jul 2002 11:39:48 +0200
Message-Id: <1027417193.18693.40.camel@manu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I hope that those infos will be usefull.

The problem is that I have a PC 500 MHz with 256Mbytes of memory,
it's a web server (apache + zope + apache modules) and a firewall (it
protects itself from the outside)

Apparently there is something wrong in the ipt_multiport module or
elsewhere (sorry, more infos below).


Regards

Manuel Flury
manuel.flury@free.fr
 
-----------------------------------------------------------------------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux www 2.4.18-3 #1 Thu Apr 18 07:37:53 EDT 2002 i686 unknown
 
Gnu C                  gcc (GCC) 3.1 Copyright (C) 2002 Free Software
Foundation, Inc. This is free software; see the source for copying
conditions. There is NO warranty; not even for MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      4.0.0
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         ipt_multiport ipt_LOG ipt_state iptable_filter
ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack autofs
eepro100 usb-uhci usbcore ext3 jbd aic7xxx sd_mod scsi_mod
-----------------------------------------------------------------------

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 501.145
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips	: 999.42
-----------------------------------------------------------------------
ipt_multiport           1632   5 (autoclean)
ipt_LOG                 4736   3 (autoclean)
ipt_state               1536 127 (autoclean)
iptable_filter          2752   1 (autoclean)
ip_nat_ftp              4320   0 (unused)
iptable_nat            21012   1 [ip_nat_ftp]
ip_tables              13984   7 [ipt_multiport ipt_LOG ipt_state
iptable_filter iptable_nat]
ip_conntrack_ftp        5056   0 (unused)
ip_conntrack           21164   3 [ipt_state ip_nat_ftp iptable_nat
ip_conntrack_ftp]
autofs                 12164   0 (autoclean) (unused)
eepro100               20336   1
usb-uhci               24484   0 (unused)
usbcore                73152   1 [usb-uhci]
ext3                   67136  10
jbd                    49400  10 [ext3]
aic7xxx               124768  12
sd_mod                 12864  24
scsi_mod              108576   2 [aic7xxx sd_mod]
-----------------------------------------------------------------------
Jul 23 07:01:56 www kernel: Unable to handle kernel paging request at
virtual address 00001004
Jul 23 07:01:56 www kernel:  printing eip:
Jul 23 07:01:56 www kernel: c0136660
Jul 23 07:01:56 www kernel: *pde = 00000000
Jul 23 07:01:56 www kernel: Oops: 0000
Jul 23 07:01:56 www kernel: ipt_multiport ipt_REJECT ipt_LOG ipt_state
iptable_filter ip_nat_ftp iptable_n
Jul 23 07:01:56 www kernel: CPU:    0
Jul 23 07:01:56 www kernel: EIP:    0010:[<c0136660>]    Not tainted
Jul 23 07:01:56 www kernel: EFLAGS: 00010206
Jul 23 07:01:56 www kernel:
Jul 23 07:01:56 www kernel: EIP is at page_referenced [kernel] 0x30
(2.4.18-3)
Jul 23 07:01:56 www kernel: eax: 00000001   ebx: 00000005   ecx:
00001000   edx: 00000000
Jul 23 07:01:56 www kernel: esi: 00000000   edi: c02c473c   ebp:
00000053   esp: c13bffa0
Jul 23 07:01:56 www kernel: ds: 0018   es: 0018   ss: 0018
Jul 23 07:01:56 www kernel: Process kswapd (pid: 5, stackpage=c13bf000)
Jul 23 07:01:56 www kernel: Stack: c126f538 c126f554 c0130737 fffff19f
c13be000 c02c4764 0000004e 000000f9
Jul 23 07:01:56 www kernel:        0000011b c02c473c 000000f9 00000000
c0131090 c02c473c 00000006 00000000
Jul 23 07:01:56 www kernel:        00010f00 c1389fb8 c0105000 0008e000
c0107136 00000000 c0130e10 c02dbfdc
Jul 23 07:01:56 www kernel: Call Trace: [<c0130737>]
refill_inactive_zone [kernel] 0x217
Jul 23 07:01:56 www kernel: [<c0131090>] kswapd [kernel] 0x280
Jul 23 07:01:56 www kernel: [<c0105000>] stext [kernel] 0x0
Jul 23 07:01:56 www kernel: [<c0107136>] kernel_thread [kernel] 0x26
Jul 23 07:01:56 www kernel: [<c0130e10>] kswapd [kernel] 0x0
Jul 23 07:01:56 www kernel:
Jul 23 07:01:56 www kernel:
Jul 23 07:01:56 www kernel: Code: 8b 41 04 0f b3 18 19 d2 8b 09 85 d2 8d
46 01 0f 45 f0 85 c9
Jul 23 07:01:57 www kernel:  ------------[ cut here ]------------
Jul 23 07:01:57 www kernel: kernel BUG at page_alloc.c:131!
Jul 23 07:01:57 www kernel: invalid operand: 0000
Jul 23 07:01:57 www kernel: ipt_multiport ipt_REJECT ipt_LOG ipt_state
iptable_filter ip_nat_ftp iptable_n
Jul 23 07:01:57 www kernel: CPU:    0
Jul 23 07:01:57 www kernel: EIP:    0010:[<c01317aa>]    Not tainted
Jul 23 07:01:57 www kernel: EFLAGS: 00010286
Jul 23 07:01:57 www kernel:
Jul 23 07:01:57 www kernel: EIP is at __free_pages_ok [kernel] 0x11a
(2.4.18-3)
Jul 23 07:01:57 www kernel: eax: 00000020   ebx: c11005f8   ecx:
00000001   edx: 002d4637
Jul 23 07:01:57 www kernel: esi: 00000000   edi: c1000030   ebp:
00000000   esp: ce289e84
Jul 23 07:01:57 www kernel: ds: 0018   es: 0018   ss: 0018
Jul 23 07:01:57 www kernel: Process analog (pid: 5400,
stackpage=ce289000)
Jul 23 07:01:57 www kernel: Stack: c02250b5 00000083 c114c948 c114c910
c1038030 c02c477c c11005f8 c013671d
Jul 23 07:01:57 www kernel:        cbc74218 00100000 cdcaca80 00004000
0493f067 c01253af c11005f8 00000005
Jul 23 07:01:57 www kernel:        00000000 0839c000 cd02d080 0829c000
00000000 0839c000 cd02d080 c01253af
Jul 23 07:01:57 www kernel: Call Trace: [<c013671d>] page_remove_rmap
[kernel] 0x5d
Jul 23 07:01:57 www kernel: [<c01253af>] do_zap_page_range [kernel]
0x18f
Jul 23 07:01:57 www kernel: [<c01253af>] do_zap_page_range [kernel]
0x18f
Jul 23 07:01:57 www kernel: [<c0125900>] zap_page_range [kernel] 0x50
Jul 23 07:01:57 www kernel: [<c01280da>] exit_mmap [kernel] 0xca
Jul 23 07:01:57 www kernel: [<c0116776>] mmput [kernel] 0x26
Jul 23 07:01:57 www kernel: [<c011aaa3>] do_exit [kernel] 0xb3
Jul 23 07:01:57 www kernel: [<c0127d34>] sys_munmap [kernel] 0x34
Jul 23 07:01:57 www kernel: [<c0108923>] system_call [kernel] 0x33
Jul 23 07:01:57 www kernel:
Jul 23 07:01:57 www kernel:
Jul 23 07:01:57 www kernel: Code: 0f 0b 5f 5d c6 43 24 05 8b 43 18 89 f1
89 dd 83 e0 eb 89 43
Jul 23 08:37:07 www syslogd 1.4.1: restart.
Jul 23 08:37:07 www syslog: syslogd startup succeeded



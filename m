Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSG1IWo>; Sun, 28 Jul 2002 04:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSG1IWo>; Sun, 28 Jul 2002 04:22:44 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:62350 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S315445AbSG1IWl>; Sun, 28 Jul 2002 04:22:41 -0400
Date: Sun, 28 Jul 2002 16:25:42 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel BUG at page_alloc.c:91 (2.4.19-rc2-xfs)
Message-ID: <20020728082542.GC1265@leathercollection.ph>
Mail-Followup-To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I apologize for sending this to both the Linux kernel mailing list as
well as the Linux-XFS mailing list. I am sending this to the lkml
because it's a kernel bug report. I'm sending this to the Linux-XFS
mailing list because I do not know if "try_to_free_buffers+130/240" in
the Call Trace has anything to do with changes that the XFS team has
done on the Linux kernel.

I got kernel BUG reports in my system logs[1] and dmesg[2] four times
today.  The first time it happened with process kswapd, the second with
process httpd (of Apache), the third and fourth with ssh which I was
firing up through wterm.  They happened all within a fairly short period
of time: the first at 16:02:05, the second at the same time, the third
at 16:03:51 and the fourth at 16:03:53.

I am running Linux kernel 2.4.19-rc2-xfs (CVS snapshot 20020718),
compiled using the current gcc-3.1 Debian packages from Sid (gcc version
3.1.1 20020703 (Debian prerelease) according to `gcc-3.1 -v`), on an AMD
Duron/850MHz. This system has been running continuously using this
kernel for 7 days 22:13, according to uptime. I didn't do anything
special this afternoon when all four kernel BUG incidences occured.

Would any of the kernel or XFS developers want me to do anything to
perhaps help debug this situation? I intend to move this system up to
2.4.19-rc3-xfs (CVS snapshot as of today), otherwise.

Thanks a lot in advance.

 --> Jijo

[1] Kernel BUG reports from syslog (with timestamps and slightly
    different call trace information):

Jul 28 16:02:05 lawin kernel: kernel BUG at page_alloc.c:91!
Jul 28 16:02:05 lawin kernel: invalid operand: 0000
Jul 28 16:02:05 lawin kernel: CPU:    0
Jul 28 16:02:05 lawin kernel: EIP:    0010:[__free_pages_ok+45/608]    Tainted: P 
Jul 28 16:02:05 lawin kernel: EFLAGS: 00210282
Jul 28 16:02:05 lawin kernel: eax: c11c90fc   ebx: c11c73d4   ecx: 00000000   edx: c0333f40
Jul 28 16:02:05 lawin kernel: esi: 00000000   edi: 000011b9   ebp: c0334050   esp: c12f3f08
Jul 28 16:02:05 lawin kernel: ds: 0018   es: 0018   ss: 0018
Jul 28 16:02:05 lawin kernel: Process kswapd (pid: 5, stackpage=c12f3000)
Jul 28 16:02:05 lawin kernel: Stack: 00000001 00200282 00000003 cf0dc8c0 cf0dc8c0 cf0dc8c0 c11c73d4 c013f0e2 
Jul 28 16:02:05 lawin kernel:        cf0dc8c0 c0333f40 c11c73d4 000011b9 c0334050 c0134852 c11c73d4 000001d0 
Jul 28 16:02:05 lawin kernel:        c12f2000 000001c7 000001d0 00000002 0000001f 000001d0 00000020 00000006 
Jul 28 16:02:05 lawin kernel: Call Trace: [try_to_free_buffers+130/240] [shrink_cache+642/784] [shrink_caches+97/160] [try_to_free_pages+54/96
] [kswapd_balance_pgdat+86/160] 
Jul 28 16:02:05 lawin kernel:    [kswapd_balance+24/48] [kswapd+157/192] [rest_init+0/64] [kernel_thread+46/64] [kswapd+0/192] 
Jul 28 16:02:05 lawin kernel: 
Jul 28 16:02:05 lawin kernel: Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 
Jul 28 16:02:05 lawin kernel:  kernel BUG at page_alloc.c:91!
Jul 28 16:02:05 lawin kernel: invalid operand: 0000
Jul 28 16:02:05 lawin kernel: CPU:    0
Jul 28 16:02:05 lawin kernel: EIP:    0010:[__free_pages_ok+45/608]    Tainted: P 
Jul 28 16:02:05 lawin kernel: EFLAGS: 00210282
Jul 28 16:02:05 lawin kernel: eax: c11ee984   ebx: c1261cc4   ecx: 00000000   edx: c0333f40
Jul 28 16:02:05 lawin kernel: esi: 00000000   edi: 00001232   ebp: c0334050   esp: c72bddc0
Jul 28 16:02:05 lawin kernel: ds: 0018   es: 0018   ss: 0018
Jul 28 16:02:05 lawin kernel: Process http (pid: 14620, stackpage=c72bd000)
Jul 28 16:02:05 lawin kernel: Stack: 00000001 00200282 00000003 cf0dc3c0 cf0dc3c0 cf0dc3c0 c1261cc4 c013f0e2 
Jul 28 16:02:05 lawin kernel:        cf0dc3c0 c0333f40 c1261cc4 00001232 c0334050 c0134852 c1261cc4 000001d2 
Jul 28 16:02:05 lawin kernel:        c72bc000 000001d1 000001d2 00000020 0000001e 000001d2 00000020 00000006 
Jul 28 16:02:05 lawin kernel: Call Trace: [try_to_free_buffers+130/240] [shrink_cache+642/784] [shrink_caches+97/160] [try_to_free_pages+54/96
] [balance_classzone+87/448] 
Jul 28 16:02:06 lawin kernel:    [__alloc_pages+237/400] [do_generic_file_write+818/1760] [ip_local_deliver+77/112] [xfs_write+591/2144] [ip_r
cv_finish+0/544] [linvfs_write+228/288] 
Jul 28 16:02:06 lawin kernel:    [sys_write+163/304] [system_call+51/56] 
Jul 28 16:02:06 lawin kernel: 
Jul 28 16:02:06 lawin kernel: Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 
Jul 28 16:03:51 lawin kernel:  kernel BUG at page_alloc.c:91!
Jul 28 16:03:51 lawin kernel: invalid operand: 0000
Jul 28 16:03:51 lawin kernel: CPU:    0
Jul 28 16:03:51 lawin kernel: EIP:    0010:[__free_pages_ok+45/608]    Tainted: P 
Jul 28 16:03:51 lawin kernel: EFLAGS: 00210282
Jul 28 16:03:51 lawin kernel: eax: c128cef4   ebx: c1209ea8   ecx: 00000000   edx: c0333f40
Jul 28 16:03:51 lawin kernel: esi: 00000000   edi: 00001234   ebp: c0334050   esp: cd2ffdec
Jul 28 16:03:51 lawin kernel: ds: 0018   es: 0018   ss: 0018
Jul 28 16:03:51 lawin kernel: Process ssh (pid: 14631, stackpage=cd2ff000)
Jul 28 16:03:51 lawin kernel: Stack: 00000001 00200282 00000003 cf0dc340 cf0dc340 cf0dc340 c1209ea8 c013f0e2 
Jul 28 16:03:51 lawin kernel:        cf0dc340 c0333f40 c1209ea8 00001234 c0334050 c0134852 c1209ea8 000001d2 
Jul 28 16:03:51 lawin kernel:        cd2fe000 000001d2 000001d2 00000020 0000001f 000001d2 00000020 00000006 
Jul 28 16:03:51 lawin kernel: Call Trace: [try_to_free_buffers+130/240] [shrink_cache+642/784] [shrink_caches+97/160] [try_to_free_pages+54/96
] [balance_classzone+87/448] 
Jul 28 16:03:51 lawin kernel:    [__alloc_pages+237/400] [do_anonymous_page+104/240] [handle_mm_fault+119/272] [do_page_fault+350/1257] [via68
6a:__insmod_via686a_O/lib/modules/2.4.19-rc2-xfs/misc/via686a.+-156672/96] [via686a:__insmod_via686a_O/lib/modules/2.4.19-rc2-xfs/misc/via686a
.+-156672/96] 
Jul 28 16:03:51 lawin kernel:    [via686a:__insmod_via686a_O/lib/modules/2.4.19-rc2-xfs/misc/via686a.+-965242/96] [do_brk+280/528] [sys_brk+26
4/320] [do_page_fault+0/1257] [error_code+52/60] 
Jul 28 16:03:51 lawin kernel: 
Jul 28 16:03:51 lawin kernel: Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 
Jul 28 16:03:53 lawin kernel:  kernel BUG at page_alloc.c:91!
Jul 28 16:03:53 lawin kernel: invalid operand: 0000
Jul 28 16:03:53 lawin kernel: CPU:    0
Jul 28 16:03:53 lawin kernel: EIP:    0010:[__free_pages_ok+45/608]    Tainted: P 
Jul 28 16:03:53 lawin kernel: EFLAGS: 00210282
Jul 28 16:03:53 lawin kernel: eax: c12987b8   ebx: c10b9ba8   ecx: 00000000   edx: c0333f40
Jul 28 16:03:53 lawin kernel: esi: 00000000   edi: 00001235   ebp: c0334050   esp: cd2ffdd0
Jul 28 16:03:53 lawin kernel: ds: 0018   es: 0018   ss: 0018
Jul 28 16:03:53 lawin kernel: Process ssh (pid: 14633, stackpage=cd2ff000)
Jul 28 16:03:53 lawin kernel: Stack: 00000001 00200282 00000003 cf0dc1c0 cf0dc1c0 cf0dc1c0 c10b9ba8 c013f0e2 
Jul 28 16:03:53 lawin kernel:        cf0dc1c0 c0333f40 c10b9ba8 00001235 c0334050 c0134852 c10b9ba8 000001d2 
Jul 28 16:03:53 lawin kernel:        cd2fe000 000001d2 000001d2 0000001f 00000020 000001d2 00000020 00000006 
Jul 28 16:03:53 lawin kernel: Call Trace: [try_to_free_buffers+130/240] [shrink_cache+642/784] [shrink_caches+97/160] [try_to_free_pages+54/96
] [balance_classzone+87/448] 
Jul 28 16:03:53 lawin kernel:    [__alloc_pages+237/400] [do_no_page+257/432] [handle_mm_fault+119/272] [do_page_fault+350/1257] [old_mmap+257
/288] [filp_close+77/128] 
Jul 28 16:03:53 lawin kernel:    [do_page_fault+0/1257] [error_code+52/60] 
Jul 28 16:03:53 lawin kernel: 
Jul 28 16:03:53 lawin kernel: Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 


[2] Kernel BUG reports from dmesg (no timestamps):

kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013536d>]    Tainted: P 
EFLAGS: 00210282
eax: c11c90fc   ebx: c11c73d4   ecx: 00000000   edx: c0333f40
esi: 00000000   edi: 000011b9   ebp: c0334050   esp: c12f3f08
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c12f3000)
Stack: 00000001 00200282 00000003 cf0dc8c0 cf0dc8c0 cf0dc8c0 c11c73d4 c013f0e2 
       cf0dc8c0 c0333f40 c11c73d4 000011b9 c0334050 c0134852 c11c73d4 000001d0 
       c12f2000 000001c7 000001d0 00000002 0000001f 000001d0 00000020 00000006 
Call Trace: [<c013f0e2>] [<c0134852>] [<c0134a11>] [<c0134a86>] [<c0134b36>]
   [<c0134b98>] [<c0134ccd>] [<c0105000>] [<c01071fe>] [<c0134c30>]

Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 
 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013536d>]    Tainted: P 
EFLAGS: 00210282
eax: c11ee984   ebx: c1261cc4   ecx: 00000000   edx: c0333f40
esi: 00000000   edi: 00001232   ebp: c0334050   esp: c72bddc0
ds: 0018   es: 0018   ss: 0018
Process http (pid: 14620, stackpage=c72bd000)
Stack: 00000001 00200282 00000003 cf0dc3c0 cf0dc3c0 cf0dc3c0 c1261cc4 c013f0e2 
       cf0dc3c0 c0333f40 c1261cc4 00001232 c0334050 c0134852 c1261cc4 000001d2
       c72bc000 000001d1 000001d2 00000020 0000001e 000001d2 00000020 00000006
Call Trace: [<c013f0e2>] [<c0134852>] [<c0134a11>] [<c0134a86>] [<c0135827>] 
   [<c0135a7d>] [<c01306b2>] [<c029e04d>] [<c01fd88f>] [<c029e420>] [<c01f90c4>] 
   [<c013ae93>] [<c0108db7>] 

Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 
 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013536d>]    Tainted: P 
EFLAGS: 00210282
eax: c128cef4   ebx: c1209ea8   ecx: 00000000   edx: c0333f40
esi: 00000000   edi: 00001234   ebp: c0334050   esp: cd2ffdec
ds: 0018   es: 0018   ss: 0018
Process ssh (pid: 14631, stackpage=cd2ff000)
Stack: 00000001 00200282 00000003 cf0dc340 cf0dc340 cf0dc340 c1209ea8 c013f0e2 
       cf0dc340 c0333f40 c1209ea8 00001234 c0334050 c0134852 c1209ea8 000001d2 
       cd2fe000 000001d2 000001d2 00000020 0000001f 000001d2 00000020 00000006 
Call Trace: [<c013f0e2>] [<c0134852>] [<c0134a11>] [<c0134a86>] [<c0135827>] 
   [<c0135a7d>] [<c012b638>] [<c012b8e7>] [<c011897e>] [<d0966c00>] [<d0966c00>] 
   [<d08a1586>] [<c012cfc8>] [<c012be88>] [<c0118820>] [<c0108ea8>] 

Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 
 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013536d>]    Tainted: P 
EFLAGS: 00210282
eax: c12987b8   ebx: c10b9ba8   ecx: 00000000   edx: c0333f40
esi: 00000000   edi: 00001235   ebp: c0334050   esp: cd2ffdd0
ds: 0018   es: 0018   ss: 0018
Process ssh (pid: 14633, stackpage=cd2ff000)
Stack: 00000001 00200282 00000003 cf0dc1c0 cf0dc1c0 cf0dc1c0 c10b9ba8 c013f0e2 
       cf0dc1c0 c0333f40 c10b9ba8 00001235 c0334050 c0134852 c10b9ba8 000001d2 
       cd2fe000 000001d2 000001d2 0000001f 00000020 000001d2 00000020 00000006 
Call Trace: [<c013f0e2>] [<c0134852>] [<c0134a11>] [<c0134a86>] [<c0135827>] 
   [<c0135a7d>] [<c012b7c1>] [<c012b8e7>] [<c011897e>] [<c010e601>] [<c013a3cd>] 
   [<c0118820>] [<c0108ea8>] 

Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 


-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTBONY3>; Sat, 15 Feb 2003 08:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTBONY3>; Sat, 15 Feb 2003 08:24:29 -0500
Received: from employees.nextframe.net ([213.160.234.200]:32765 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S261963AbTBONY1>; Sat, 15 Feb 2003 08:24:27 -0500
Date: Sat, 15 Feb 2003 14:35:48 +0100
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.20 Oops]
Message-ID: <20030215143548.A11310@sexything>
Reply-To: morten.helgesen@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys, 

keep getting this on an sql-server running 2.4.20. It happens during 
backup of mysql databases. Easily reproducible. After the oops, processes
trying to access /backup end up in 'D' state. Btw, filesystem
is reiserfs. Anyone got a clue ?

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
printing eip:
 c01322a0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[try_to_free_buffers+20/228]    Not tainted
EFLAGS: 00010207
eax: 00000000   ebx: c10ee294   ecx: 000001d2   edx: 00000000
esi: 00000000   edi: d3bd8e00   ebp: c10ee294   esp: ce061e24
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 23696, stackpage=ce061000)
Stack:		c10ee294 000001d2 00000017 00000200 c013087c d3bd8e00 
		c10ee294 c01286d2 c10ee294 000001d2 00000020 000001d2 
		00000020 00000006 00000006 ce060000 00003e19 000001d2 
		c0295c74 c0128930 00000006 00000004 00000006 00000020
Call Trace:	[try_to_release_page+68/72] [shrink_cache+490/764] 
		[shrink_caches+88/128] [try_to_free_pages_zone+58/92] 
		[balance_classzone+80/456] [__alloc_pages+274/352] 
		[reiserfs_get_block+0/3648] [_alloc_pages+22/24] 
		[page_cache_read+110/188] [generic_file_readahead+261/316]
		[do_generic_file_read+422/1028] [generic_file_read+124/272] 
		[file_read_actor+0/140] [sys_read+150/240] [system_call+51/56]

Code: 8b 56 18 8b 46 10 83 e2 06 09 d0 75 76 8b 76 28 39 fe 75 ec


[14:31][admin@sql:~]$ uname -a
Linux sql 2.4.20 #2 Thu Jan 23 00:43:06 CET 2003 i686 unknown

[14:31][admin@sql:~]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 601.374
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1199.30

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net

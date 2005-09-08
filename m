Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVIHDyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVIHDyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 23:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVIHDyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 23:54:41 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:24042 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751060AbVIHDyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 23:54:41 -0400
Message-ID: <431FB5FF.1030700@comcast.net>
Date: Wed, 07 Sep 2005 23:54:39 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
Subject: 2.6.13-mm1 X86_64: All 32bit programs segfault
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am clueless as to what's going on but just raising a flag in case it 
is a not yet known problem.
Thunderbird, 32bit Sun Java and Opera are the ones I tried. They all 
work fine with the Fedora 2.6.12-x kernel but
consistently seg fault with 2.6.13-mm1.

Parag
--------
Sample stack trace for java -
gdb ./java
GNU gdb Red Hat Linux (6.3.0.0-1.21rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu"...Using host 
libthread_db l ibrary "/lib64/libthread_db.so.1".

(gdb) b main
Breakpoint 1 at 0x80492d3: file ../../../../src/share/bin/java.c, line 163.
(gdb) r
Starting program: /home/paragw/jdk1.6/jdk1.6.0/fastdebug/bin/java
Reading symbols from shared object read from target memory...done.
Loaded system supplied DSO at 0xffffe000
[Thread debugging using libthread_db enabled]
[New Thread 1431820864 (LWP 6077)]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1431820864 (LWP 6077)]
0x00c40471 in __pthread_initialize_minimal_internal ()
   from /lib/libpthread.so.0
(gdb) bt
#0  0x00c40471 in __pthread_initialize_minimal_internal ()
   from /lib/libpthread.so.0
#1  0x00c40298 in call_initialize_minimal () from /lib/libpthread.so.0
#2  0x00c3fe80 in _init () from /lib/libpthread.so.0
#3  0x00b00dcb in call_init () from /lib/ld-linux.so.2
#4  0x00b00eed in _dl_init_internal () from /lib/ld-linux.so.2
#5  0x00af37cf in _dl_start_user () from /lib/ld-linux.so.2
(gdb) info registers
eax            0x0      0
ecx            0x5557da88       1431820936
edx            0x1      1
ebx            0xffffd198       -11880
esp            0xffffced4       0xffffced4
ebp            0xffffd198       0xffffd198
esi            0x5557da40       1431820864
edi            0x0      0
eip            0xc40471 0xc40471
eflags         0x10202  66050
cs             0x23     35
ss             0x2b     43
ds             0x2b     43
es             0x2b     43
fs             0x0      0
gs             0x63     99
(gdb)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTDVXNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTDVXNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 19:13:16 -0400
Received: from taka.swcp.com ([198.59.115.12]:1284 "EHLO taka.swcp.com")
	by vger.kernel.org with ESMTP id S263426AbTDVXNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 19:13:15 -0400
Date: Tue, 22 Apr 2003 17:23:16 -0600
From: Trammell Hudson <hudson@osresearch.net>
To: linux-kernel@vger.kernel.org
Subject: gettimeofday running backwards on 2.4.20
Message-ID: <20030422232316.GF20108@osbox.osresearch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please cc hudson@osresearch.net on any replies.  Thank you! ]

A few months ago I noticed gettimeofday running backwards on
dual Pentium II and dual Pentium Pro systems with 2.4.18.  Based
on postings made to linux-kernel in June of 2002, I upgraded 
to 2.4.20 and the problem seemed to go away:

  http://groups.google.com/groups?threadm=3D16DE83.3060409@tiscalinet.it

Just recently my NAS benchmarks and MPI latency tests showed bizarre
results, so I pulled out my test program and am seeing the same
problems again.  It seems that roughly 50 in 1 million calls go
backwards, even with 2.4.20.

Occasionally it is 4295 seconds (very consistently that value),
but most of them are just a few microseconds backwards.  No error
code is returned from the system call either.  No NTP or rdate type
services are running.

My test program can be seen here:

	http://www.swcp.com/~hudson/gettimeofday.c

Interestingly, it only happens on the compute nodes with NFS root.
The service node has booted from a local SCSI disk and is serving roughly
140 compute nodes without any timing bugs.

service:~/tflop-linux: ssh node-181 uname -a \; cat /proc/cpuinfo      
Linux node-181 2.4.20 #73 SMP Mon Apr 21 14:06:49 MDT 2003 i686 unknown
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 2
cpu MHz         : 333.356
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 665.19

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 2
cpu MHz         : 333.356
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 665.19

Trammell
-- 
  -----|----- hudson@osresearch.net                   W 240-283-1700
*>=====[]L\   hudson@rotomotion.com                   M 505-463-1896
'     -'-`-   http://www.swcp.com/~hudson/                    KC5RNF


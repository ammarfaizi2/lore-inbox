Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbQL2OkC>; Fri, 29 Dec 2000 09:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130255AbQL2Ojx>; Fri, 29 Dec 2000 09:39:53 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:50448 "EHLO
	netmax.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S129797AbQL2Oji>; Fri, 29 Dec 2000 09:39:38 -0500
Message-Id: <4.3.2.7.2.20001229090753.00bc69a0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 29 Dec 2000 09:09:01 -0500
To: "Giacomo A. Catenazzi" <cate@student.ethz.ch>
From: David Relson <relson@osagesoftware.com>
Subject: Re: [PATCH] Processor autodetection (when configuring kernel)
Cc: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
In-Reply-To: <3A4C941E.EA824F87@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo,

I don't think cpu_info.sh is quite right.  It identified my 500 Mhz Pentium 
III as CONFIG_M386.  I think CONFIG_M686 is closer, but as I don't know the 
significance of all the flags (MMX, TSC, etc), I'm not certain.  Since the 
flags do include fxsr, the correct answer may be CONFIG_M686FXSR.

Anyhow, here are my results:

[relson@osage relson]$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz	: 501.147
cache size	: 512 KB
fdiv_bug	: no
hlt_bug	: no
sep_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
mmx fxsr xmm
bogomips	: 999.42

[relson@osage relson]$ ARCH=i386 ; . cpu_detect.sh
GenuineIntel:6:7
CONFIG_M386

Also, here's a patch to make the script echo CONFIG_M686:

diff -urN cpu_detect.sh.orig cpu_detect.sh
--- cpu_detect.sh.orig	Fri Dec 29 09:02:27 2000
+++ cpu_detect.sh	Fri Dec 29 09:01:14 2000
@@ -18,7 +18,7 @@
    case $cpu_id in
      GenuineIntel:5:[0123]      )  echo CONFIG_M586TSC   ;;
      GenuineIntel:5:[48]        )  echo CONFIG_M586MMX   ;;
-    GenuineIntel:6:[01356]     )  echo CONFIG_M686      ;;
+    GenuineIntel:6:[013567]    )  echo CONFIG_M686      ;;
      GenuineIntel:6:{8,9,11}    )  echo CONFIG_M686FXSR  ;;
      AuthenticAMD:5:[0123]      )  echo CONFIG_M586      ;;
      AuthenticAMD:5:{8,9,10,11} )  echo CONFIG_MK6       ;;

David

P.S.  I'm running 2.2.18, if it matters.
--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       Ann Arbor, MI 48103
www.osagesoftware.com          tel:  734.821.8800

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLWX6i>; Sat, 23 Dec 2000 18:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129838AbQLWX63>; Sat, 23 Dec 2000 18:58:29 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:9478 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129595AbQLWX6S>; Sat, 23 Dec 2000 18:58:18 -0500
Date: Sun, 24 Dec 2000 00:27:33 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Michael Chen <michaelc@turbolinux.com.cn>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
Message-ID: <20001224002732.O25239@arthur.ubicom.tudelft.nl>
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn> <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Dec 23, 2000 at 09:21:51AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000 at 09:21:51AM -0800, Linus Torvalds wrote:
> A Celeron isn't a PIII, and you shouldn't tell the configure that it is.

Well, some Celerons are. My laptop has a Celeron with a Coppermine
core, so it is PIII based. Here is the output from /proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Celeron (Coppermine)
stepping	: 1
cpu MHz		: 501.140
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 999.42

The laptop runs perfectly well when I select a PIII CPU in the kernel
config. Here is a small patch that fixes the documentation:

Index: Documentation/Configure.help
===================================================================
RCS file: /home/erik/cvsroot/elinux/Documentation/Configure.help,v
retrieving revision 1.1.1.57
diff -u -r1.1.1.57 Configure.help
--- Documentation/Configure.help	2000/12/13 15:10:53	1.1.1.57
+++ Documentation/Configure.help	2000/12/23 22:58:12
@@ -2868,7 +2868,7 @@
    - "Pentium-Classic" for the Intel Pentium.
    - "Pentium-MMX" for the Intel Pentium MMX.
    - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
-   - "Pentium-III" for the Intel Pentium III.
+   - "Pentium-III" for the Intel Pentium III/Celeron Coppermine.
    - "Pentium-4" for the Intel Pentium 4
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
    - "Athlon" for the AMD Athlon (K7).
Index: arch/i386/config.in
===================================================================
RCS file: /home/erik/cvsroot/elinux/arch/i386/config.in,v
retrieving revision 1.1.1.13
diff -u -r1.1.1.13 config.in
--- arch/i386/config.in	2000/12/13 15:09:15	1.1.1.13
+++ arch/i386/config.in	2000/12/23 23:12:55
@@ -33,7 +33,7 @@
 	 Pentium-Classic		CONFIG_M586TSC \
 	 Pentium-MMX			CONFIG_M586MMX \
 	 Pentium-Pro/Celeron/Pentium-II	CONFIG_M686 \
-	 Pentium-III			CONFIG_M686FXSR \
+	 Pentium-III/Celeron Coppermine	CONFIG_M686FXSR \
 	 Pentium-4			CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III		CONFIG_MK6 \
 	 Athlon/K7			CONFIG_MK7 \


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

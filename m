Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315476AbSE2UlC>; Wed, 29 May 2002 16:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSE2UlC>; Wed, 29 May 2002 16:41:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50191 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315476AbSE2UkH>;
	Wed, 29 May 2002 16:40:07 -0400
Message-ID: <3CF53C34.2080300@mandrakesoft.com>
Date: Wed, 29 May 2002 16:38:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, davej@suse.de,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] intel-x86 model config cleanup
In-Reply-To: <20020529143544.GA2224@werewolf.able.es> <3CF53C03.5040301@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------020304010101020201030409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020304010101020201030409
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

>
> This implies separating the concept of a "generic x86 kernel that 
> supports N CPU types" from "kernel supports one CPU type and one 
> only." The i386/config.in is currently a mishmash of both.  Dave Jones 
> did some work along these lines in his "cpuchoice" diff, which I have 
> attached.



....or rather, attached here.


--------------020304010101020201030409
Content-Type: text/plain;
 name="cpu-choice-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu-choice-2.diff"

diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/config.in linux-dj/arch/i386/config.in
--- linux/arch/i386/config.in	Mon Nov 12 19:58:08 2001
+++ linux-dj/arch/i386/config.in	Tue Dec  4 00:40:28 2001
@@ -26,22 +26,75 @@
 
 mainmenu_option next_comment
 comment 'Processor type and features'
-choice 'Processor family' \
+choice 'Processor vendor' \
+	"AMD			CONFIG_VENDOR_AMD \
+	 Cyrix			CONFIG_VENDOR_CYRIX \
+	 Generic		CONFIG_VENDOR_GENERIC \
+	 IDT			CONFIG_VENDOR_IDT \
+	 Intel			CONFIG_VENDOR_INTEL \
+	 NationalSemiconductor	CONFIG_VENDOR_NATSEMI \
+	 RiSE			CONFIG_VENDOR_RISE \
+	 Transmeta		CONFIG_VENDOR_TRANSMETA \
+	 VIA			CONFIG_VENDOR_VIA"	Generic
+
+if [ "$CONFIG_VENDOR_AMD" = "y" ]; then
+	choice 'Processor family' \
+	"386				CONFIG_M386 \
+	 486				CONFIG_M486 \
+	 K5/5x86			CONFIG_M586 \
+	 K6/K6-II/K6-III		CONFIG_MK6 \
+	 Athlon/Duron		CONFIG_MK7" Athlon
+fi
+
+if [ "$CONFIG_VENDOR_CYRIX" = "y" ]; then
+	choice 'Processor family' \
+	"386				CONFIG_M386 \
+	 486				CONFIG_M486 \
+	 586/5x86/6x86/6x86MX		CONFIG_M586" 586
+fi
+
+if [ "$CONFIG_VENDOR_GENERIC" = "y" ]; then
+	choice 'Minimum spec CPU to generate code for' \
+	"386			CONFIG_M386 \
+	 486			CONFIG_M486 \
+	 586			CONFIG_M586 \
+	 686			CONFIG_M686" 386
+fi
+
+if [ "$CONFIG_VENDOR_IDT" = "y" ]; then
+	choice 'Processor family' \
+	"Winchip-C6			CONFIG_MWINCHIPC6 \
+	 Winchip-2			CONFIG_MWINCHIP2 \
+	 Winchip-2A/Winchip-3		CONFIG_MWINCHIP3D" Winchip-C6
+fi
+
+if [ "$CONFIG_VENDOR_INTEL" = "y" ]; then
+	choice 'Processor family' \
 	"386					CONFIG_M386 \
 	 486					CONFIG_M486 \
-	 586/K5/5x86/6x86/6x86MX		CONFIG_M586 \
 	 Pentium-Classic			CONFIG_M586TSC \
 	 Pentium-MMX				CONFIG_M586MMX \
 	 Pentium-Pro/Celeron/Pentium-II		CONFIG_M686 \
 	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
-	 Pentium-4				CONFIG_MPENTIUM4 \
-	 K6/K6-II/K6-III			CONFIG_MK6 \
-	 Athlon/Duron/K7			CONFIG_MK7 \
-	 Crusoe					CONFIG_MCRUSOE \
-	 Winchip-C6				CONFIG_MWINCHIPC6 \
-	 Winchip-2				CONFIG_MWINCHIP2 \
-	 Winchip-2A/Winchip-3			CONFIG_MWINCHIP3D \
-	 CyrixIII/C3				CONFIG_MCYRIXIII" Pentium-Pro
+	 Pentium-4				CONFIG_MPENTIUM4" Pentium-Pro
+fi
+
+if [ "$CONFIG_VENDOR_NATSEMI" = "y" ]; then
+	define_bool CONFIG_M586 y
+fi
+
+if [ "$CONFIG_VENDOR_RISE" = "y" ]; then
+	define_bool CONFIG_M586 y
+fi
+
+if [ "$CONFIG_VENDOR_TRANSMETA" = "y" ]; then
+	define_bool CONFIG_MCRUSOE y
+fi
+
+if [ "$CONFIG_VENDOR_VIA" = "y" ]; then
+	define_bool CONFIG_MCYRIXIII y
+fi
+
 #
 # Define implied options from the CPU selection here
 #

--------------020304010101020201030409--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTLBAPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 19:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTLBAPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 19:15:46 -0500
Received: from p508B764E.dip.t-dialin.net ([80.139.118.78]:18869 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264271AbTLBAPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 19:15:44 -0500
Date: Tue, 2 Dec 2003 01:09:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: drivers/char/rtc.c compile failure in current 2.4 BitKeeper tree:
Message-ID: <20031202000927.GA3109@linux-mips.org>
References: <03Dec1.190119est.6025@ugw.utcc.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03Dec1.190119est.6025@ugw.utcc.utoronto.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 07:01:17PM -0500, Chris Siebenmann wrote:

>  I'm compiling for SMP x86 and getting:
> 	make[3]: Entering directory `/homes/hawkwind/u0/cks/sys/linux-BK/drivers/char'
> 	gcc -D__KERNEL__ -I/homes/hawkwind/u0/cks/sys/linux-BK/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=rtc  -c -o rtc.o rtc.c
> 	rtc.c: In function `rtc_init':
> 	rtc.c:772: `RTC_IOMAPPED' undeclared (first use in this function)
> 	rtc.c:772: (Each undeclared identifier is reported only once
> 	rtc.c:772: for each function it appears in.)
> 	rtc.c:773: `RTC_IO_EXTENT' undeclared (first use in this function)
> 	rtc.c: In function `rtc_exit':
> 	rtc.c:873: `RTC_IOMAPPED' undeclared (first use in this function)
> 	rtc.c:874: `RTC_IO_EXTENT' undeclared (first use in this function)
> 	make[3]: *** [rtc.o] Error 1
> 
> It looks like the MIPS changes require these to be defined in
> include/asm-*/mc146818rtc.h (or included files) for all architectures
> (previously RTC_IO_EXTENT was defined in rtc.c and RTC_IOMAPPED didn't
> exist), but only MIPS has been updated to do this. From looking at the
> diffs to rtc.c, it looks like the correct additions are just:

Seems Marcelo didn't (yet?) merge below patch which I had sent to him
separate from the rtc.c patches ...

  Ralf

>From ralf@linux-mips.org Sat Nov 29 04:46:32 2003
Date: Sat, 29 Nov 2003 04:46:32 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Supply default values to rtc.c
Message-ID: <20031129034632.GK30662@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Status: RO
X-Status: A
Content-Length: 677
Lines: 19

This supplies default values (from PC-ish architectures) to the rtc.c
driver.

diff -urN --exclude=CVS --exclude=.cvsignore linux-2.4.23/include/linux/mc146818rtc.h linux-cvs-2.4.23/include/linux/mc146818rtc.h
--- linux-2.4.23/include/linux/mc146818rtc.h	2001-11-22 20:46:58.000000000 +0100
+++ linux-cvs-2.4.23/include/linux/mc146818rtc.h	2003-11-28 15:09:41.000000000 +0100
@@ -98,4 +98,12 @@
 #define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
 #endif
 
+#ifndef RTC_IO_EXTENT
+#define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/
+#endif
+
+#ifndef RTC_IOMAPPED
+#define RTC_IOMAPPED	1	/* Default to I/O mapping. */
+#endif
+
 #endif /* _MC146818RTC_H */


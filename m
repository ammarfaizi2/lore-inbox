Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbTBUPeA>; Fri, 21 Feb 2003 10:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbTBUPd7>; Fri, 21 Feb 2003 10:33:59 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:10715 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267509AbTBUPdy>; Fri, 21 Feb 2003 10:33:54 -0500
Date: Fri, 21 Feb 2003 16:43:45 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.21-pre4-bk] use correct gcc flags when compiling for Crusoe
Message-ID: <20030221164345.I12004@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes use of 'check_gcc' facility when compiling for
a Crusoe processor in order to choose the correct -falign or -malign
compiler flags.

Marcelo, Alan, please apply.

Thanks.

Stelian.

===== arch/i386/Makefile 1.5 vs edited =====
--- 1.5/arch/i386/Makefile	Sun Feb  2 08:50:07 2003
+++ edited/arch/i386/Makefile	Tue Feb 18 10:03:19 2003
@@ -61,15 +61,16 @@
 endif
 
 ifdef CONFIG_MK6
-CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
+CFLAGS += $(call check_gcc,-march=k6,-march=i586)
 endif
 
 ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+CFLAGS += $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
 endif
 
 ifdef CONFIG_MCRUSOE
-CFLAGS += -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+CFLAGS += -march=i686
+CFLAGS += $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 endif
 
 ifdef CONFIG_MWINCHIPC6
-- 
Stelian Pop <stelian@popies.net>

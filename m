Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbTENSh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTENSh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:37:58 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:25875 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263483AbTENSh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:37:56 -0400
Message-ID: <3EC29191.5030700@yahoo.ca>
Date: Wed, 14 May 2003 14:57:21 -0400
From: Jonathan Bastien-Filiatrault <Intuxicated_kdev@yahoo.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030418
X-Accept-Language: en-ca, fr-ca
MIME-Version: 1.0
To: mec@shout.net
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.69 Change to i386 Makefile to distinguish athlons.
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It should succesfully set -march=athlon-<type> according to uname -p.

--- linux-2.5.69/arch/i386/Makefile.orig    2003-05-14 
13:37:19.000000000 -0400
+++ linux-2.5.69/arch/i386/Makefile    2003-05-14 14:50:03.000000000 -0400
@@ -23,7 +23,7 @@
 CFLAGS += -pipe

 check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > 
/dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
+get_athlon_type = ${shell case `uname -p` in "* 4 *") echo 
"athlon-4";;*XP*) echo "athlon-xp";;*MP*) echo "athlon-mp";;*) echo 
"athlon";;esac}
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)

@@ -39,7 +39,7 @@
 cflags-$(CONFIG_MPENTIUMIII)    += $(call 
check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)    += $(call 
check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)        += $(call check_gcc,-march=k6,-march=i586)
-cflags-$(CONFIG_MK7)        += $(call 
check_gcc,-march=athlon,-march=i686 $(align)-functions=4)
+cflags-$(CONFIG_MK7)        += $(call check_gcc,-march=$(call 
get_athlon_type),-march=i686 $(align)-functions=4)
 cflags-$(CONFIG_MK8)        += $(call check_gcc,-march=k8,$(call 
check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 cflags-$(CONFIG_MCRUSOE)    += -march=i686 $(align)-functions=0 
$(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MWINCHIPC6)    += $(call 
check_gcc,-march=winchip-c6,-march=i586)



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRACHzU>; Wed, 3 Jan 2001 02:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130422AbRACHzK>; Wed, 3 Jan 2001 02:55:10 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:52345 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129562AbRACHy4>; Wed, 3 Jan 2001 02:54:56 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre5 
In-Reply-To: Your message of "Wed, 03 Jan 2001 04:15:16 BST."
             <20010103041516.C1497@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jan 2001 18:24:16 +1100
Message-ID: <11635.978506656@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001 04:15:16 +0100, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>I have seen that the CCFOUND stuff has flown away. I have read it
>breaks somthing, and the CROSS_COMPILE in alphas and m68k.
>Perhaps this way could be better : ??
>..
>include arch/$(ARCH)/Makefile
>
>AS  :=$(AS)
>LD  :=$(LD)
>CC  :=$(CC)
>CPP :=$(CPP)

Agreed.  Alan, please apply.

Index: 19-pre5.1/Makefile
--- 19-pre5.1/Makefile Wed, 03 Jan 2001 17:44:03 +1100 kaos (linux-2.2/G/b/14_Makefile 1.3.2.2.1.1.1.5.1.3.6.1.5.1.1.1.1.16.1.16 644)
+++ 19-pre5.1(w)/Makefile Wed, 03 Jan 2001 18:15:57 +1100 kaos (linux-2.2/G/b/14_Makefile 1.3.2.2.1.1.1.5.1.3.6.1.5.1.1.1.1.16.1.16 644)
@@ -219,6 +219,17 @@ DRIVERS := $(DRIVERS) drivers/telephony/
 endif
 
 include arch/$(ARCH)/Makefile
+# arch/$(ARCH)/Makefile is the last thing that is allowed to change CROSS_COMPILE.
+# Revaluate final values for speed.
+AS	:=$(AS)
+LD	:=$(LD)
+CC	:=$(CC)
+CPP	:=$(CPP)
+AR	:=$(AR)
+NM	:=$(NM)
+STRIP	:=$(STRIP)
+OBJCOPY	:=$(OBJCOPY)
+OBJDUMP	:=$(OBJDUMP)
 
 .S.s:
 	$(CC) -D__ASSEMBLY__ $(AFLAGS) -traditional -E -o $*.s $<

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

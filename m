Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSGGX7U>; Sun, 7 Jul 2002 19:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSGGX7T>; Sun, 7 Jul 2002 19:59:19 -0400
Received: from jalon.able.es ([212.97.163.2]:33245 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316673AbSGGX7T>;
	Sun, 7 Jul 2002 19:59:19 -0400
Date: Mon, 8 Jul 2002 02:01:53 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc1aa1
Message-ID: <20020708000153.GC6080@werewolf.able.es>
References: <20020629023459.GA1531@inspiron.ols.wavesec.org> <20020707234906.GA6080@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020707234906.GA6080@werewolf.able.es>; from jamagallon@able.es on Mon, Jul 08, 2002 at 01:49:06 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.08 J.A. Magallon wrote:
>
>On 2002.06.29 Andrea Arcangeli wrote:
>>Only booted it on the laptop so far.
>>
>>URL:
>>
>>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1.gz
>>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1/
>>
>>Changelog:
>>
>
>I think the build system for e100 is buggy. You end up with 2 copies of e100.o:
>

This seems to do the trick. Is it correct ?

--- linux/drivers/net/Makefile.orig     2002-07-08 01:54:05.000000000 +0200
+++ linux/drivers/net/Makefile  2002-07-08 01:55:33.000000000 +0200
@@ -67,7 +67,9 @@
 obj-$(CONFIG_VORTEX) += 3c59x.o mii.o
 obj-$(CONFIG_NE2K_PCI) += ne2k-pci.o 8390.o
 obj-$(CONFIG_PCNET32) += pcnet32.o mii.o
+ifeq ($(CONFIG_E100),y)
 obj-$(CONFIG_E100) += e100/e100.o
+endif
 obj-$(CONFIG_EEPRO100) += eepro100.o mii.o
 obj-$(CONFIG_TLAN) += tlan.o
 obj-$(CONFIG_EPIC100) += epic100.o mii.o

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)

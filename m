Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVI3PhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVI3PhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbVI3PhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:37:23 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:25522 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030338AbVI3PhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:37:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type;
  b=3KqVoQ/RzCGAjJq0EWtc+RhiHbr/z9bNTkpfbnRIrCQ0iXORLi8CX9UV52o9AbGFN6r/0pg7qiEV3XL3qFQGarsKvxECGe0HsBW4hA/4vixHJUlAbRE0HqsDw0Hk+peYXwXJT834noDisIlCyD+WBEWiekx7eBdvGq0kuSITX0k=  ;
Message-ID: <433D5305.1030209@yahoo.com.au>
Date: Sat, 01 Oct 2005 01:00:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] i386 include linux/irq.h rather than asm/hw_irq.h
Content-Type: multipart/mixed;
 boundary="------------000408060700010409060408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000408060700010409060408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I need the following patch to compile -git8 here, otherwise these
files fail to compile (asm/hw_irq.h needs definitions from
linux/irq.h and that file provides the required include ordering).

-- 
SUSE Labs, Novell Inc.


--------------000408060700010409060408
Content-Type: text/plain;
 name="i386-irq-include.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-irq-include.patch"

Index: linux-2.6/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6/arch/i386/kernel/acpi/boot.c
@@ -29,12 +29,12 @@
 #include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/dmi.h>
+#include <linux/irq.h>
 
 #include <asm/pgtable.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/mpspec.h>
 
 #ifdef	CONFIG_X86_64
Index: linux-2.6/arch/i386/pci/acpi.c
===================================================================
--- linux-2.6.orig/arch/i386/pci/acpi.c
+++ linux-2.6/arch/i386/pci/acpi.c
@@ -1,7 +1,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
-#include <asm/hw_irq.h>
+#include <linux/irq.h>
 #include <asm/numa.h>
 #include "pci.h"
 
Index: linux-2.6/arch/i386/pci/irq.c
===================================================================
--- linux-2.6.orig/arch/i386/pci/irq.c
+++ linux-2.6/arch/i386/pci/irq.c
@@ -15,7 +15,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/io_apic.h>
-#include <asm/hw_irq.h>
+#include <linux/irq.h>
 #include <linux/acpi.h>
 
 #include "pci.h"

--------------000408060700010409060408--
Send instant messages to your online friends http://au.messenger.yahoo.com 

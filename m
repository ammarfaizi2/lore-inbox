Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRHWOgu>; Thu, 23 Aug 2001 10:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267140AbRHWOga>; Thu, 23 Aug 2001 10:36:30 -0400
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:32516 "EHLO mail1.wi.rr.com")
	by vger.kernel.org with ESMTP id <S267043AbRHWOgJ>;
	Thu, 23 Aug 2001 10:36:09 -0400
Message-ID: <3B85161F.7060908@wi.rr.com>
Date: Thu, 23 Aug 2001 09:41:35 -0500
From: Carl <crazy@wi.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2+) Gecko/20010728
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sonypi and byteswapped apm minutes.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Sony Viao SR-33, and the sonypi driver would not work until I 
applied this patch.

--- linux-2.4.9.orig/drivers/char/sonypi.c      Wed Jul  4 16:41:33 2001
+++ linux-2.4.9/drivers/char/sonypi.c   Thu Aug 23 09:17:06 2001
@@ -630,7 +630,7 @@

         sonypi_call1(0x82);
         sonypi_call2(0x81, 0xff);
-       sonypi_call1(0x92);
+       sonypi_call1(0x82);

         printk(KERN_INFO "sonypi: Sony Programmable I/O Controller 
driver v%d.%d
.\n",
                SONYPI_DRIVER_MAJORVERSION,

I don't know if this works for the general case or if this machine is a 
special case.  I hope people with other vaio models will check.

Also this machine suffers from the swap_apm issue, here is a patch.

--- linux-2.4.9.orig/arch/i386/kernel/dmi_scan.c        Mon Aug 13 
18:39:28 2001
+++ linux-2.4.9/arch/i386/kernel/dmi_scan.c     Thu Aug 23 09:03:41 2001
@@ -354,6 +354,11 @@
                         MATCH(DMI_BIOS_VERSION, "R0121Z1"),
                         MATCH(DMI_BIOS_DATE, "05/11/00"), NO_MATCH
                         } },
+       { swab_apm_power_in_minutes, "Sony VAIO", {     /* Handle 
problems with APM on Sony Vaio PCG-SR33 */
+                       MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+                       MATCH(DMI_BIOS_VERSION, "R0211D1"),
+                       MATCH(DMI_BIOS_DATE, "05/30/01"), NO_MATCH
+                       } },
         { NULL, }
  };

Thanks.


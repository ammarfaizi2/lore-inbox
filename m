Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRDWJIO>; Mon, 23 Apr 2001 05:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRDWJIF>; Mon, 23 Apr 2001 05:08:05 -0400
Received: from jalon.able.es ([212.97.163.2]:58572 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131587AbRDWJIA>;
	Mon, 23 Apr 2001 05:08:00 -0400
Date: Mon, 23 Apr 2001 11:07:53 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: disable_ide_dma gcc-3.0 warn
Message-ID: <20010423110753.A25081@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.

One other gcc-3.0 warning (apart from the classic multiline strings)
I do not know if it can be important.

gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac12/include -Wall -Wstrict-prototypes -
O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-march=i686    -c -o dmi_scan.o dmi_scan.c
dmi_scan.c:158: warning: `disable_ide_dma' defined but not used

In dmi_scan.c there is the func:
static __init int disable_ide_dma(struct dmi_blacklist *d)

But now it is unused (intentionally ?):

static __initdata struct dmi_blacklist dmi_blacklist[]={
#if 0    <==================
    { disable_ide_dma, "KT7", { /* Overbroad right now - kill DMA on problem KT7
boards */
            MATCH(DMI_PRODUCT_NAME, "KT7-RAID"),
            NO_MATCH, NO_MATCH, NO_MATCH
            } },
#endif  
    { broken_apm_power, "Dell Inspiron 5000e", {    /* Handle problems with APM
on Inspiron 5000e */
            MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
            MATCH(DMI_BIOS_VERSION, "A04"),
            MATCH(DMI_BIOS_DATE, "08/24/2000"), NO_MATCH
            } },
    { NULL, }
};

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac12 #1 SMP Sun Apr 22 10:27:22 CEST 2001 i686


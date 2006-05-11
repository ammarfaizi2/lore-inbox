Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWEKPSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWEKPSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWEKPSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:18:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:3822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030258AbWEKPSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:18:20 -0400
X-Authenticated: #31060655
Message-ID: <4463556C.3040107@gmx.net>
Date: Thu, 11 May 2006 17:17:00 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de
Subject: Re: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
References: <446139FF.205@gmx.net> <20060510093942.GA12259@elf.ucw.cz> <4461C0CA.8080803@gmx.net> <20060510205600.GB23446@suse.de> <44625CE9.2060204@gmx.net> <20060511023109.GB11693@redhat.com> <4462B737.80108@gmx.net>
In-Reply-To: <4462B737.80108@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suggestion for a minimal fix for -stable:

Do not enable the SMBus device on Asus boards if software suspend
is used. We do not reenable the device on resume, leading to all sorts
of undesirable effects, the worst being a total fan failure after
resume on my Samsung P35 laptop.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

--- linux-2.6.16.14/drivers/pci/quirks.c.vanilla	2006-05-05 02:03:45.000000000 +0200
+++ linux-2.6.16.14/drivers/pci/quirks.c	2006-05-11 17:09:15.000000000 +0200
@@ -861,6 +861,8 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge );

+#ifndef CONFIG_SOFTWARE_SUSPEND
+
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the
@@ -1008,6 +1010,8 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );

+#endif
+
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */


-- 
http://www.hailfinger.org/

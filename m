Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753838AbWKHB6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbWKHB6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 20:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbWKHB6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 20:58:50 -0500
Received: from mga05.intel.com ([192.55.52.89]:6013 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1753838AbWKHB6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 20:58:49 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,398,1157353200"; 
   d="scan'208"; a="12985464:sNHT53922141"
Date: Tue, 7 Nov 2006 17:36:24 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: ak@suse.de, akpm@osdl.org
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com, suresh.b.siddha@intel.com
Subject: [patch 1/4] add write_pci_config_byte() to direct PCI access routines
Message-ID: <20061107173624.A5401@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061107173306.C3262@unix-os.sc.intel.com>; from suresh.b.siddha@intel.com on Tue, Nov 07, 2006 at 05:33:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add write_pci_config_byte() to direct PCI access  routines

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/arch/i386/pci/early.c b/arch/i386/pci/early.c
index 713d6c8..42df4b6 100644
--- a/arch/i386/pci/early.c
+++ b/arch/i386/pci/early.c
@@ -45,6 +45,13 @@ void write_pci_config(u8 bus, u8 slot, u
 	outl(val, 0xcfc);
 }
 
+void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val)
+{
+	PDprintk("%x writing to %x: %x\n", slot, offset, val);
+	outl(0x80000000 | (bus<<16) | (slot<<11) | (func<<8) | offset, 0xcf8);
+	outb(val, 0xcfc);
+}
+
 int early_pci_allowed(void)
 {
 	return (pci_probe & (PCI_PROBE_CONF1|PCI_PROBE_NOEARLY)) ==
diff --git a/include/asm-x86_64/pci-direct.h b/include/asm-x86_64/pci-direct.h
index eba9cb4..6823fa4 100644
--- a/include/asm-x86_64/pci-direct.h
+++ b/include/asm-x86_64/pci-direct.h
@@ -10,6 +10,7 @@ extern u32 read_pci_config(u8 bus, u8 sl
 extern u8 read_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset);
 extern u16 read_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset);
 extern void write_pci_config(u8 bus, u8 slot, u8 func, u8 offset, u32 val);
+extern void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val);
 
 extern int early_pci_allowed(void);
 

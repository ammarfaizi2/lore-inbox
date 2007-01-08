Return-Path: <linux-kernel-owner+w=401wt.eu-S932451AbXAHILF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbXAHILF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbXAHILF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:11:05 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35971 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbXAHILE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:11:04 -0500
Date: Mon, 8 Jan 2007 13:40:55 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <gregkh@suse.de>
Subject: [PATCH 1/4] pci quirks MODPOST warning fix
Message-ID: <20070108081055.GC7889@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o MODPOST generates warnings for i386 if kernel is compiled with
  CONFIG_RELOCATABLE=y

WARNING: vmlinux - Section mismatch: reference to .init.data: from .text between 'asus_hides_smbus_lpc_ich6' (at offset 0xc0217d58) and 'quirk_cardbus_legacy'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text between 'asus_hides_smbus_lpc' (at offset 0xc0217fd9) and 'pci_match_id'

o Two quirk functions which are non __init, are accessing data which is
  of type __init.


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/pci/quirks.c~pci-quirks-modpost-warning-fix drivers/pci/quirks.c
--- linux-2.6.20-rc2-mm1-reloc/drivers/pci/quirks.c~pci-quirks-modpost-warning-fix	2007-01-04 16:23:36.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/drivers/pci/quirks.c	2007-01-04 16:24:33.000000000 +0530
@@ -956,7 +956,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_V
  * becomes necessary to do this tweak in two steps -- I've chosen the Host
  * bridge as trigger.
  */
-static int __initdata asus_hides_smbus;
+static int asus_hides_smbus;
 
 static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
 {
_

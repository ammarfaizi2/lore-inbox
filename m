Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269755AbUICTrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269755AbUICTrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269764AbUICTpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:45:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24492 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269779AbUICTd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:33:59 -0400
Date: Fri, 3 Sep 2004 20:33:54 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] acpiphp misc fixes [5/5]
Message-ID: <20040903193354.GT642@parcelfarce.linux.theplanet.co.uk>
References: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two minor fixes:

 - Correct the docbook (parameter renamed to value)
 - If a resource is 64-bit, the debug code was previously truncating its value.

diff -urpNX build-tools/dontdiff linux-2.6/drivers/pci/hotplug/acpiphp_core.c hotplug-2.6/drivers/pci/hotplug/acpiphp_core.c
--- linux-2.6/drivers/pci/hotplug/acpiphp_core.c	2004-05-23 17:52:23.000000000 -0600
+++ hotplug-2.6/drivers/pci/hotplug/acpiphp_core.c	2004-09-03 08:09:15.181670908 -0600
@@ -210,8 +212,7 @@ static int get_adapter_status(struct hot
 /**
  * get_address - get pci address of a slot
  * @hotplug_slot: slot to get status
- * @busdev: pointer to struct pci_busdev (seg, bus, dev)
- *
+ * @value: pointer to struct pci_busdev (seg, bus, dev)
  */
 static int get_address(struct hotplug_slot *hotplug_slot, u32 *value)
 {
diff -urpNX build-tools/dontdiff linux-2.6/drivers/pci/hotplug/acpiphp_res.c hotplug-2.6/drivers/pci/hotplug/acpiphp_res.c
--- linux-2.6/drivers/pci/hotplug/acpiphp_res.c	2004-05-23 17:52:23.000000000 -0600
+++ hotplug-2.6/drivers/pci/hotplug/acpiphp_res.c	2004-09-02 10:51:54.000000000 -0600
@@ -669,8 +669,8 @@ static void dump_resource(struct pci_res
 	cnt = 0;
 
 	while (p) {
-		dbg("[%02d] %08x - %08x\n",
-		    cnt++, (u32)p->base, (u32)p->base + p->length - 1);
+		dbg("[%02d] 0x%llx - 0x%llx\n", cnt++, (long long)p->base,
+				(long long)(p->base + p->length - 1));
 		p = p->next;
 	}
 }

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

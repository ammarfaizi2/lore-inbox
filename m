Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269553AbUJSXW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269553AbUJSXW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270167AbUJSXWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:22:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:19338 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270164AbUJSWql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:41 -0400
X-Fake: the user-agent is fake
Subject: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <20041019223752.GA9763@kroah.com>
Date: Tue, 19 Oct 2004 15:42:11 -0700
Message-Id: <1098225731207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.2.120, 2004/10/06 17:20:23-07:00, akpm@osdl.org

[PATCH] PCI: CONFIG_PCI=n build fix

With CONFIG_PCI=n:

arch/i386/kernel/cpu/cyrix.c: In function `init_cyrix':
arch/i386/kernel/cpu/cyrix.c:285: `cyrix_55x0' undeclared (first use in this function)
arch/i386/kernel/cpu/cyrix.c:285: (Each undeclared identifier is reported only once
arch/i386/kernel/cpu/cyrix.c:285: for each function it appears in.)

Make pci_dev_present() a macro.  It doesn't make sense to require that
pci_device_id's be in scope when CONFIG_PCI=n

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:21:25 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:21:25 -07:00
@@ -894,8 +894,8 @@
 
 static inline struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from)
 { return NULL; }
-static inline int pci_dev_present(const struct pci_device_id *ids)
-{ return 0; }
+
+#define pci_dev_present(ids)	(0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }


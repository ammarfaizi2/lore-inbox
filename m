Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWCAATu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWCAATu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWCAATu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:19:50 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:2554 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932131AbWCAATu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:19:50 -0500
Date: Tue, 28 Feb 2006 16:19:09 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: paulus@samba.org, johnrose@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: restore eeh_add_device_late() prototype
Message-ID: <20060301001909.GU20175@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A search on the linux-kernel, linuxppc-dev mailing lists and the git tree at
 git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc didn't show
this issue fixed or reported. If I missed something please ignore :)

I get a compile failure trying to build a powerpc kernel:

arch/powerpc/platforms/pseries/eeh.c: In function `eeh_add_device_tree_late':
arch/powerpc/platforms/pseries/eeh.c:901: warning: implicit declaration of function `eeh_add_device_late'
arch/powerpc/platforms/pseries/eeh.c: At top level:
arch/powerpc/platforms/pseries/eeh.c:918: error: conflicting types for 'eeh_add_device_late'
arch/powerpc/platforms/pseries/eeh.c:901: error: previous implicit declaration of 'eeh_add_device_late' was here
make[2]: *** [arch/powerpc/platforms/pseries/eeh.o] Error 1

It seems commit 827c1a6c1a5dcb2902fecfb648f9af6a532934eb removed this
prototype from eeh.h. The following patch restores it.
	--Mark

diff --git a/include/asm-powerpc/eeh.h b/include/asm-powerpc/eeh.h
index 7dfb408..4250fa1 100644
--- a/include/asm-powerpc/eeh.h
+++ b/include/asm-powerpc/eeh.h
@@ -62,6 +62,7 @@ void __init pci_addr_cache_build(void);
  */
 void eeh_add_device_early(struct device_node *);
 void eeh_add_device_tree_early(struct device_node *);
+void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 
 /**
@@ -117,6 +118,8 @@ static inline void pci_addr_cache_build(
 
 static inline void eeh_add_device_early(struct device_node *dn) { }
 
+static inline void eeh_add_device_late(struct pci_dev *dev) { }
+
 static inline void eeh_remove_device(struct pci_dev *dev) { }
 
 static inline void eeh_add_device_tree_early(struct device_node *dn) { }

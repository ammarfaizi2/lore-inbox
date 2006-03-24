Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWCXSqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWCXSqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWCXSqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:46:38 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50887 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932581AbWCXSqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:46:37 -0500
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix spider-pic affinity setting
Date: Fri, 24 Mar 2006 19:46:29 +0100
User-Agent: KMail/1.9.1
Cc: Milton Miller <miltonm@bga.com>, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Arnd Bergmann <abergman@de.ibm.com>,
       cbe-oss-dev@ozlabs.org
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <32140afe2349e8f1726d188eb85c780c@bga.com> <200603241905.04356.arnd.bergmann@de.ibm.com>
In-Reply-To: <200603241905.04356.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241946.30419.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As noticed by Milton Miller, setting the initial affinity in
spider-pic can go wrong if the target node field was not orinally
empty.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

--- linus-2.6.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linus-2.6/arch/powerpc/platforms/cell/spider-pic.c
@@ -88,7 +88,7 @@ static void spider_enable_irq(unsigned i
 	void __iomem *cfg = spider_get_irq_config(irq);
 	irq = spider_get_nr(irq);
 
-	out_be32(cfg, in_be32(cfg) | 0x3107000eu | nodeid);
+	out_be32(cfg, (in_be32(cfg) & ~0xf0)| 0x3107000eu | nodeid);
 	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
 }
 

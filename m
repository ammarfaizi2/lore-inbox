Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWHKWCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWHKWCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWHKWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:02:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:55476 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932428AbWHKWCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:02:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=tIie6F1adNIPZ2vi6xLp4gq0qiw9aBRO4+Xpw6pC8czIW9tBe5WZbR2PCTB8J92BDXK1RBUjekIrmXbp9l/djhrF68pXEsnYrae482q9GtQMrb0LinsgUtrOxePYeb2GB+7oG6Nq9KI6vl8MHaKrapwZN7YnfYeBEkuF276auqA=
Date: Sat, 12 Aug 2006 02:02:02 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_PM=n slim: drivers/char/agp/intel-agp.c
Message-ID: <20060811220202.GB6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/agp/intel-agp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -1766,6 +1766,7 @@ static void __devexit agp_intel_remove(s
 	agp_put_bridge(bridge);
 }
 
+#ifdef CONFIG_PM
 static int agp_intel_resume(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
@@ -1789,6 +1790,7 @@ static int agp_intel_resume(struct pci_d
 
 	return 0;
 }
+#endif
 
 static struct pci_device_id agp_intel_pci_table[] = {
 #define ID(x)						\
@@ -1835,7 +1837,9 @@ static struct pci_driver agp_intel_pci_d
 	.id_table	= agp_intel_pci_table,
 	.probe		= agp_intel_probe,
 	.remove		= __devexit_p(agp_intel_remove),
+#ifdef CONFIG_PM
 	.resume		= agp_intel_resume,
+#endif
 };
 
 static int __init agp_intel_init(void)


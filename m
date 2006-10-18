Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWJRE2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWJRE2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWJRE2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:28:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932070AbWJRE2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:28:20 -0400
Date: Wed, 18 Oct 2006 00:28:17 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: minyard@acm.org
Subject: [IPMI] Fix return codes in failure case.
Message-ID: <20061018042817.GA7475@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These returns should be negative, like the others in this function.

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 24825bd..e5cfb1f 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1789,7 +1789,7 @@ static int __devinit ipmi_pci_probe(stru
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
-		return ENOMEM;
+		return -ENOMEM;
 
 	info->addr_source = "PCI";
 
@@ -1810,7 +1810,7 @@ static int __devinit ipmi_pci_probe(stru
 		kfree(info);
 		printk(KERN_INFO "ipmi_si: %s: Unknown IPMI type: %d\n",
 		       pci_name(pdev), class_type);
-		return ENOMEM;
+		return -ENOMEM;
 	}
 
 	rv = pci_enable_device(pdev);

-- 
http://www.codemonkey.org.uk

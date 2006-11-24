Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934363AbWKXMBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934363AbWKXMBN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 07:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934378AbWKXMBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 07:01:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:46095 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S934363AbWKXMBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 07:01:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=g4Zx/QsQn7CDiadute+zP24jGYkTs/fNsWIfJA3zMerDSRnz68kf9aiPcjybl8XXzChyV6u7YuiGQcsXrBvD6vxjrAnzKDVFD5DTkD4bB3JOZIFE9Q03DO6ffYrHRJS26qDAhkaDOuoPPaczJ32NjUMb7pTy76XH4iHblZdheV8=
Message-ID: <4566DE24.5070108@gmail.com>
Date: Fri, 24 Nov 2006 13:57:24 +0200
From: Yan Burman <burman.yan@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jdike@karaya.com, trivial@kernel.org
Subject: [PATCH 2.6.19-rc6] um: replace kmalloc+memset with kzalloc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc 

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/arch/um/drivers/net_kern.c linux-2.6.19-rc5_kzalloc/arch/um/drivers/net_kern.c
--- linux-2.6.19-rc5_orig/arch/um/drivers/net_kern.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/um/drivers/net_kern.c	2006-11-11 22:44:04.000000000 +0200
@@ -333,13 +333,12 @@ static int eth_configure(int n, void *in
 	size = transport->private_size + sizeof(struct uml_net_private) + 
 		sizeof(((struct uml_net_private *) 0)->user);
 
-	device = kmalloc(sizeof(*device), GFP_KERNEL);
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL) {
 		printk(KERN_ERR "eth_configure failed to allocate uml_net\n");
 		return(1);
 	}
 
-	memset(device, 0, sizeof(*device));
 	INIT_LIST_HEAD(&device->list);
 	device->index = n;
 


Regards
Yan Burman

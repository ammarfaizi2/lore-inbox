Return-Path: <linux-kernel-owner+w=401wt.eu-S932231AbWLLQ7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWLLQ7R (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWLLQ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:59:16 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:20463 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbWLLQ7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:59:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=dLk6BrYW4+hKitcGbqd3ewX5pTO6aHtF5Cvms9su9h+Mh0uHmi0tGSNuuvh4dgItktRrCpFO5eksOG3YhNazsVeBihssbV9cjwgde+URs8pIqdORBE/j0kBFnFzgEzMzGGBFXvyyJ/4jzq8NVLjm9CFx3OqtQkL/wD+1hzaWkZQ=
Subject: [PATCH 2.6.19] e100: replace kmalloc with kcalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, john.ronciak@intel.com
Content-Type: text/plain
Date: Tue, 12 Dec 2006 18:55:31 +0200
Message-Id: <1165942531.5611.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kcalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/drivers/net/e100.c linux-2.6.19-rc5_kzalloc/drivers/net/e100.c
--- linux-2.6.19-rc5_orig/drivers/net/e100.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/drivers/net/e100.c	2006-11-11 22:44:04.000000000 +0200
@@ -1930,9 +1930,8 @@ static int e100_rx_alloc_list(struct nic
 	nic->rx_to_use = nic->rx_to_clean = NULL;
 	nic->ru_running = RU_UNINITIALIZED;
 
-	if(!(nic->rxs = kmalloc(sizeof(struct rx) * count, GFP_ATOMIC)))
+	if(!(nic->rxs = kcalloc(count, sizeof(struct rx), GFP_ATOMIC)))
 		return -ENOMEM;
-	memset(nic->rxs, 0, sizeof(struct rx) * count);
 
 	for(rx = nic->rxs, i = 0; i < count; rx++, i++) {
 		rx->next = (i + 1 < count) ? rx + 1 : nic->rxs;





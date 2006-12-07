Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031757AbWLGHFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031757AbWLGHFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 02:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031759AbWLGHFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 02:05:05 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:38775 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031757AbWLGHFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 02:05:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ES1WyGp8YYT1tk6S/Yx0nZcRCQj+E9RNijGeW59RPmSiXYv7jGJWCH5VZ8RYovN3veuJ48Ek1QxQROk8Zqp+Bk7wmSGhljt0gXhaKoE+eZXa8te/IB8syl9k9RMq1NS6a70SO14V1zImJHG/fT0wtUn4oc1RPxqT9d3RCMH6cxQ=
Date: Wed, 6 Dec 2006 23:04:58 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19] net/wanrouter/wanmain.c: check kmalloc() return
 value.
Message-Id: <20061206230458.d11b2bb0.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function dbg_kmalloc(), in file net/wanrouter/wanmain.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/net/wanrouter/wanmain.c b/net/wanrouter/wanmain.c
index 316211d..263450c 100644
--- a/net/wanrouter/wanmain.c
+++ b/net/wanrouter/wanmain.c
@@ -67,6 +67,8 @@ static void * dbg_kmalloc(unsigned int s
 	int i = 0;
 	void * v = kmalloc(size+sizeof(unsigned int)+2*KMEM_SAFETYZONE*8,prio);
 	char * c1 = v;
+	if (!v)
+		return NULL;
 	c1 += sizeof(unsigned int);
 	*((unsigned int *)v) = size;
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161504AbWJaA4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161504AbWJaA4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161506AbWJaA4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:56:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:29400 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161504AbWJaA4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:56:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=pA2+5KWQ22LzbkO4LInFjQZFr0KsqULNqU/GvaZZ6mWhs/4GWSIGvZTbyhs0N9Nr5b50RXODh69W5bAyYQM/i920RRfvo2cbF0NSo+Bmd3CslQm28ShojOcnJtKBc/lM5BZjHU+GAE7Uamk4SQ2guSncFx/REoDYCmMBS4err80=
Message-ID: <45469F2D.9030602@gmail.com>
Date: Mon, 30 Oct 2006 16:56:13 -0800
From: nkalmala <nkalmala@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.13) Gecko/20060414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trivial@kernel.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, nkalmala <nkalmala@gmail.com>
Subject: [patch]trivial: un-needed add-store operation wastes a few bytes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Un-needed add-store operation wastes a few bytes.
8 bytes wasted with -O2, on a ppc.

Signed-off-by: nkalmala <nkalmala@gmail.com>
---

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b55bb35..bf2f6cf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -853,7 +853,7 @@ again:
 		pcp = &zone_pcp(zone, cpu)->pcp[cold];
 		local_irq_save(flags);
 		if (!pcp->count) {
-			pcp->count += rmqueue_bulk(zone, 0,
+			pcp->count = rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
 			if (unlikely(!pcp->count))
 				goto failed;



Return-Path: <linux-kernel-owner+w=401wt.eu-S1750844AbWLVQgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWLVQgL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 11:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWLVQgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 11:36:11 -0500
Received: from hsrmx1.hsr.ch ([152.96.36.50]:52824 "EHLO hsrmx1.hsr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbWLVQgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 11:36:10 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 11:36:10 EST
Subject: [PATCH 2.6.20-rc1] xfrm: Algorithm lookup using .compat name
From: Martin Willi <martin@strongswan.org>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 22 Dec 2006 17:26:43 +0100
Message-Id: <1166804803.21634.40.camel@martin>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Dec 2006 16:26:44.0887 (UTC) FILETIME=[F86B5270:01C725E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Installing an IPsec SA using old algorithm names (.compat) does not work
if the algorithm is not already loaded. When not using the PF_KEY
interface, algorithms are not preloaded in xfrm_probe_algs() and
installing a IPsec SA fails.

Signed-off-by: Martin Willi <martin@strongswan.org>

--- a/net/xfrm/xfrm_algo.c      2006-12-22 16:43:31.000000000 +0100
+++ b/net/xfrm/xfrm_algo.c      2006-12-22 16:58:19.000000000 +0100
@@ -399,7 +399,8 @@ static struct xfrm_algo_desc *xfrm_get_b
                if (!probe)
                    break;
 
-               status = crypto_has_alg(name, type, mask |
CRYPTO_ALG_ASYNC);
+               status = crypto_has_alg(list[i].name, type,
+                               mask | CRYPTO_ALG_ASYNC);
                if (!status)
                    break;

 




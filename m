Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbTHVNnr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbTHVNnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 09:43:47 -0400
Received: from [213.187.195.158] ([213.187.195.158]:24815 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP id S263156AbTHVNnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 09:43:46 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Gabor Z. Papp" <gzp@papp.hu>, mostrows@speakeasy.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Re: PPPoE Oops with 2.4.22-rc
References: <5ff3.3f388c4b.4453f@gzp1.gzp.hu>
	<Pine.LNX.4.44.0308121415540.10199-100000@logos.cnet>
	<39a.3f392c6f.86e8b@gzp1.gzp.hu>
From: Marcus Sundberg <marcus@ingate.com>
Date: 22 Aug 2003 15:43:01 +0200
In-Reply-To: <39a.3f392c6f.86e8b@gzp1.gzp.hu>
Message-ID: <vezni16c62.fsf_-_@inigo.ingate.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes one crash in pppoe_connect():

--- linux-2.4.21-rc2/drivers/net/pppoe.c~	Wed May 14 00:08:52 2003
+++ linux-2.4.21-rc2/drivers/net/pppoe.c	Wed May 14 00:18:47 2003
@@ -606,7 +606,8 @@
 		/* Delete the old binding */
 		delete_item(po->pppoe_pa.sid,po->pppoe_pa.remote);
 
-		dev_put(po->pppoe_dev);
+		if (po->pppoe_dev)
+			dev_put(po->pppoe_dev);
 
 		memset(po, 0, sizeof(struct pppox_opt));
 		po->sk = sk;

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/

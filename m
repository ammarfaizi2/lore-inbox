Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbVKBJLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbVKBJLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbVKBJLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:11:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57099 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932687AbVKBJLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:11:14 -0500
Date: Wed, 2 Nov 2005 10:11:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [2.6 patch] pktgen: remove useless assignment
Message-ID: <20051102091108.GG8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On main codepath pkt_dev is immediately rewritten. On error codepath it isn't
used.

Noticed by Coverity checker.

From: Alexey Dobriyan <adobriyan@gmail.com>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-vanilla/net/core/pktgen.c
+++ linux-coverity-1762/net/core/pktgen.c
@@ -2882,7 +2882,7 @@ static int pktgen_add_device(struct pktg
 	
 	/* We don't allow a device to be on several threads */
 
-	if( (pkt_dev = __pktgen_NN_threads(ifname, FIND)) == NULL) {
+	if(__pktgen_NN_threads(ifname, FIND) == NULL) {
 						   
 		pkt_dev = kmalloc(sizeof(struct pktgen_dev), GFP_KERNEL);
                 if (!pkt_dev) 



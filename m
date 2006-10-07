Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWJGSAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWJGSAT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWJGSAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:00:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:36020 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932509AbWJGSAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:00:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=EHdVgW+hMwenw/gbxzN9jcm7LiFsE/p+xMPtqPfKZBMrDsbjiAcPL4wJZh1vXPbr2YQ3aVC6g0xZFsoC+xowvnrmmp+Ywy3f0wwVnPOaAmF2zxTAmGGnkj+4UZRmfPjx/6n+UTEt+b5rwpp/yr93UyurJt8mBRInPglyd9WLZKU=
Date: Sat, 7 Oct 2006 11:00:08 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound/isa/opti9xx/opti92x-ad1848.c: check kmalloc() return
 value.
Message-Id: <20061007110008.17823deb.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function snd_card_opti9xx_pnp(), in file sound/isa/opti9xx/opti92x-ad1848.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 9d528ae..81b1d58 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -1683,6 +1683,8 @@ static int __init snd_card_opti9xx_pnp(s
 	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
 
+	if (!cfg)
+		return -ENOMEM;
 	chip->dev = pnp_request_card_device(card, pid->devs[0].id, NULL);
 	if (chip->dev == NULL) {
 		kfree(cfg);


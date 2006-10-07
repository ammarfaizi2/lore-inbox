Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWJGHbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWJGHbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 03:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWJGHbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 03:31:17 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:45286 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932762AbWJGHbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 03:31:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=DFItU8XvKS2S1iJqv0phwCRDVYBtrkF67ffQjVb9kHbFc01zp43O9irx/WqURcuEt7fXSRvNxUpoRNTqbqBcq5s/2rQmJeaDiWW7krt3ueihccK8xhS9WhZgtKtLthU8G3MdSNf4/7dk+se83aY3+wuzY5wH2j+GJSDRRrFhte0=
Date: Sat, 7 Oct 2006 00:31:10 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [KJ] [PATCH 1/1] sound/isa/ad1816a/ad1816a.c: check kmalloc()
 return value.
Message-Id: <20061007003110.7598ced9.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function snd_card_ad1816a_pnp(), in file sound/isa/ad1816a/ad1816a.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index b33a5fb..5903450 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -120,6 +120,8 @@ static int __devinit snd_card_ad1816a_pn
 	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
 
+	if (!cfg)
+		return -ENOMEM;
 	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
 	if (acard->dev == NULL) {
 		kfree(cfg);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbWJGHch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWJGHch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 03:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWJGHch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 03:32:37 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:14057 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932763AbWJGHcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 03:32:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=uXE7T+a7hngnQ+fXEjDuH1yneFcSwnXQ0p/a2/CAJ94bb6JQJfvQjnlXFCI5L43Od4DdA3RyqGkibWfPqjITxth6XacsaON4wJ5Eo2KsIRqag+VkO85hDgK5hkTxm+acgivIiuKRaR5cCmCwUFHibBzqq4SPk+kOTJVLYqrWv/Y=
Date: Sat, 7 Oct 2006 00:32:29 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [KJ] [PATCH] sound/isa/cmi8330.c: check kmalloc() return value.
Message-Id: <20061007003229.5ed37de4.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function snd_cmi8330_pnp(), in file sound/isa/cmi8330.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index 3c1e9fd..d1f6dfc 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -289,6 +289,8 @@ static int __devinit snd_cmi8330_pnp(int
 	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
 	int err;
 
+	if (!cfg)
+		return -ENOMEM;
 	acard->cap = pnp_request_card_device(card, id->devs[0].id, NULL);
 	if (acard->cap == NULL) {
 		kfree(cfg);

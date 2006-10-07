Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932764AbWJGHcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbWJGHcD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 03:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWJGHcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 03:32:02 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:3303 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932765AbWJGHcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 03:32:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=H3wQ0OEH1eLEbhTTg6FniFPbrSEntD8uv+SynIex/ZDmOLGFlNfLNiGOx8W3Iyw8ZRDYsxRfrmo8QLP0Q7pK1cMGUQSq1x1UxDp8AdWwJKQOJJNYWh/0BN8yGijqMQQmDTggKwChBFA2kN0U1rIwRJa4RAv0d4XacGGKgi1SRiQ=
Date: Sat, 7 Oct 2006 00:31:55 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [KJ] [PATCH] sound/isa/gus/interwave.c: check kmalloc() return
 value.
Message-Id: <20061007003155.1374ed08.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function snd_interwave_pnp(), in file sound/isa/gus/interwave.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index ea69f25..5282fbb 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -564,6 +564,8 @@ static int __devinit snd_interwave_pnp(i
 	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
 	int err;
 
+	if (!cfg)
+		return -ENOMEM;
 	iwcard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
 	if (iwcard->dev == NULL) {
 		kfree(cfg);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVKUWKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVKUWKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVKUWKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:10:15 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50908 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751097AbVKUWKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:10:13 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-Id: <200511212209.jALM9TpR032499@einhorn.in-berlin.de>
Date: Mon, 21 Nov 2005 23:09:02 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer
 dereference
To: scjody@steamballoon.com
cc: bcollins@debian.org, bunk@stusta.de, davej@redhat.com, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       stable@kernel.org
In-Reply-To: <20051121215226.GN20781@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
X-Spam-Score: (-0.477) AWL,BAYES_00,MSGID_FROM_MTA_ID
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.15-rc2] raw1394: fix memory deallocation in modify_config_rom

raw1394: use correct deallocation macro for CSR cache
 
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

--- linux-2.6.15-rc2/drivers/ieee1394/raw1394.c.orig	2005-11-21 22:17:13.000000000 +0100
+++ linux-2.6.15-rc2/drivers/ieee1394/raw1394.c	2005-11-21 22:29:19.000000000 +0100
@@ -2172,7 +2171,7 @@ static int modify_config_rom(struct file
 		}
 	}
 	kfree(cache->filled_head);
-	kfree(cache);
+	CSR1212_FREE(cache);
 
 	if (ret >= 0) {
 		/* we have to free the request, because we queue no response,



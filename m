Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVJSBiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVJSBiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVJSBhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:37:18 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:32531 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932436AbVJSBdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:09 -0400
Date: Tue, 18 Oct 2005 21:31:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [patch 2.6.14-rc3] 8139too: fix resume for Realtek 8100B/8139D
Message-ID: <10182005213100.12557@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add "HasHltClk" flag for RTL-8100B/8139D hardware in order to fix
problems resuming from suspend-to-RAM.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/8139too.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -552,7 +552,8 @@ const static struct {
 
 	{ "RTL-8100B/8139D",
 	  HW_REVID(1, 1, 1, 0, 1, 0, 1),
-	  HasLWake,
+	  HasHltClk /* XXX undocumented? */
+	| HasLWake,
 	},
 
 	{ "RTL-8101",

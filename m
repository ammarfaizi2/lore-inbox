Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWIWAUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWIWAUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWIWAUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:20:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3763 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964967AbWIWAUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:20:31 -0400
Date: Sat, 23 Sep 2006 01:20:31 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] memcpy_fromio() missing in istallion
Message-ID: <20060923002031.GW29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

memcpy() from iomem is a bad thing...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/istallion.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 84dfc42..8c09997 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -3488,7 +3488,7 @@ static int stli_initecp(stlibrd_t *brdp)
  */
 	EBRDENABLE(brdp);
 	sigsp = (cdkecpsig_t __iomem *) EBRDGETMEMPTR(brdp, CDK_SIGADDR);
-	memcpy(&sig, sigsp, sizeof(cdkecpsig_t));
+	memcpy_fromio(&sig, sigsp, sizeof(cdkecpsig_t));
 	EBRDDISABLE(brdp);
 
 	if (sig.magic != cpu_to_le32(ECP_MAGIC))
-- 
1.4.2.GIT

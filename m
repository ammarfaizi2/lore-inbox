Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWIRTEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWIRTEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWIRTEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:04:09 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6860 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932273AbWIRTEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:04:07 -0400
Subject: Re: [PATCH] slim: secfs inode->i_private build fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>
In-Reply-To: <1158605338.16727.48.camel@localhost.localdomain>
References: <1158605338.16727.48.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 12:03:59 -0700
Message-Id: <1158606239.16727.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Included the wrong patch the first time.  Here is the correct patch.

Due to the change from inode->u.generic_ip to inode->i_private in the mm
tree.  The slim securityfs file had a compilation error.  This minor
patch fixes this issue.

Signed-off-by: Mimi Zohar<zohar@us.ibm.com>
Signed-off-by: Kylene Hall<kjhall@us.ibm.com>
---
security/slim/slm_secfs.c |    4 ++--
1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc6-mm2/security/slim/slm_secfs.c	2006-09-15 11:14:07.000000000 -0500
+++ linux-2.6.18-rc6-mm2-slim/security/slim/slm_secfs.c	2006-09-18 11:42:23.000000000 -0500
@@ -45,8 +45,8 @@ static ssize_t slm_read_level(struct fil
 
 static int slm_open_debug(struct inode *inode, struct file *file)
 {
-	if (inode->u.generic_ip)
-		file->private_data = inode->u.generic_ip;
+	if (inode->i_private)
+		file->private_data = inode->i_private;
 	return 0;
 }
 



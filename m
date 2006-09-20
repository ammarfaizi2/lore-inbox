Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWITQuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWITQuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWITQtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:49:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41914 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751917AbWITQtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:49:05 -0400
Subject: [PATCH] slim: correct use of snprintf
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       sds@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:48:54 -0700
Message-Id: <1158770934.16727.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Stephen Smalley for pointing our incorrect usage of snprintf.
This patch fixes things by using the correct function, scnprintf,
instead.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
security/slim/slm_secfs.c |    8 ++++----
1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc6-orig/security/slim/slm_secfs.c	2006-09-18 16:41:48.000000000 -0500
+++ linux-2.6.18-rc6/security/slim/slm_secfs.c	2006-09-19 13:07:05.000000000 -0500
@@ -28,16 +28,16 @@ static ssize_t slm_read_level(struct fil
 	ssize_t len;
 	char data[28];
 	if (is_kernel_thread(current))
-		len = snprintf(data, sizeof(data), "KERNEL\n");
+		len = scnprintf(data, sizeof(data), "KERNEL\n");
 	else if (!cur_tsec)
-		len = snprintf(data, sizeof(data), "UNKNOWN\n");
+		len = scnprintf(data, sizeof(data), "UNKNOWN\n");
 	else {
 		if (cur_tsec->iac_wx != cur_tsec->iac_r)
-			len = snprintf(data, sizeof(data), "GUARD wx:%s r:%s\n",
+			len = scnprintf(data, sizeof(data), "GUARD wx:%s r:%s\n",
 				      slm_iac_str[cur_tsec->iac_wx],
 				      slm_iac_str[cur_tsec->iac_r]);
 		else
-			len = snprintf(data, sizeof(data), "%s\n",
+			len = scnprintf(data, sizeof(data), "%s\n",
 				      slm_iac_str[cur_tsec->iac_wx]);
 	}
 	return simple_read_from_buffer(buf, buflen, ppos, data, len);



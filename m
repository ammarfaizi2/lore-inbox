Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965342AbWJ2TWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965342AbWJ2TWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWJ2TUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:51 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:54428 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965335AbWJ2TUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=dIJmO2sClfbf+d0PyuDNwqJK48a6mOWzena3PSWyhM69yNfJtIZPy+BILU8MRzLtqdrRMahIX3w189cWgW5ndlvZED9byQZoIzYaaXaFvjuOtB1fI2HLXV/W2b4SoRB/yBJ47tBKHYIXMfVqscVGKsBrI5PVnyMezNrfZjOyE4g=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 07/11] uml ubd driver: reformat ubd_config
Date: Sun, 29 Oct 2006 20:20:41 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192041.12292.95078.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Pure whitespace and style fixes split out from subsequent patch. Some changes
(err -> ret) don't make sense now, only later, but I split them out anyway since
they cluttered the patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 1202592..48b2a4f 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -709,27 +709,36 @@ out:
 
 static int ubd_config(char *str)
 {
-	int n, err;
+	int n, ret;
 
 	str = kstrdup(str, GFP_KERNEL);
-	if(str == NULL){
+	if (str == NULL) {
 		printk(KERN_ERR "ubd_config failed to strdup string\n");
-		return(1);
+		ret = 1;
+		goto out;
 	}
-	err = ubd_setup_common(str, &n);
-	if(err){
-		kfree(str);
-		return(-1);
+	ret = ubd_setup_common(str, &n);
+	if (ret) {
+		ret = -1;
+		goto err_free;
+	}
+	if (n == -1) {
+		ret = 0;
+		goto out;
 	}
-	if(n == -1) return(0);
 
  	mutex_lock(&ubd_lock);
-	err = ubd_add(n);
-	if(err)
+	ret = ubd_add(n);
+	if (ret)
 		ubd_devs[n].file = NULL;
  	mutex_unlock(&ubd_lock);
 
-	return(err);
+out:
+ 	return ret;
+
+err_free:
+	kfree(str);
+	goto out;
 }
 
 static int ubd_get_config(char *name, char *str, int size, char **error_out)
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965337AbWJ2TUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965337AbWJ2TUk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbWJ2TUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:22 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:2239 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932432AbWJ2TUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=bVtcBkOK+kyS1JirQ1+7WhbdZCu2ekxu4CUOXJjKE8Vs5Pf/nA7mLyLDzz90aKF4DUPpvUzmV0wAGMe/JetneSFUmSDMazlTBAH5D2BpWfM4N/xnCSxJFv2DhB/rHVWH0/1gVtMOIF3CWS/bKU+vDs4KWfURcpetimtEo0pXgbg=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 01/11] uml ubd driver: allow using up to 16 UBD devices
Date: Sun, 29 Oct 2006 20:20:23 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192023.12292.32443.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

With 256 minors and 16 minors used per each UBD device, we can allow the use of
up to 16 UBD devices per UML.
Also chnage parse_unit and leave to the caller (which already do it) the check
for excess numbers, since this is just supposed to do raw parsing.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 784c74c..984b5da 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -117,7 +117,7 @@ static int ubd_ioctl(struct inode * inod
 		     unsigned int cmd, unsigned long arg);
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
-#define MAX_DEV (8)
+#define MAX_DEV (16)
 
 static struct block_device_operations ubd_blops = {
         .owner		= THIS_MODULE,
@@ -277,7 +277,7 @@ static int parse_unit(char **ptr)
 			return(-1);
 		*ptr = end;
 	}
-	else if (('a' <= *str) && (*str <= 'h')) {
+	else if (('a' <= *str) && (*str <= 'z')) {
 		n = *str - 'a';
 		str++;
 		*ptr = str;
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWBUWOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWBUWOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWBUWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:14:04 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:56382 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932485AbWBUWOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:14:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c/yMqwOlFWI2MtHxTFUxfxX+DRrwQnsQrL91FnLTu6Eu0dYbW2r+UYJQtkw/Mu6cHhURoXfYiytvOR+5ZH/wLGlzoZBbGIela3cZRF6CRoKdquaOTS4lmCpQEALm4jUY0HzjkoYNiaB5rrL+xSTa5gzxevQwwhjJ5/na4jOOLi4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ISDN: fix copy_to_user() unused result warning in isdn_ppp
Date: Tue, 21 Feb 2006 23:14:15 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212314.15362.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>


Fix compile warning about copy_to_user() unused result in isdn_ppp.c
   drivers/isdn/i4l/isdn_ppp.c:785: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

---

 drivers/isdn/i4l/isdn_ppp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc4-mm1-orig/drivers/isdn/i4l/isdn_ppp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc4-mm1/drivers/isdn/i4l/isdn_ppp.c	2006-02-21 23:07:57.000000000 +0100
@@ -782,7 +782,10 @@ isdn_ppp_read(int min, struct file *file
 	is->first = b;
 
 	spin_unlock_irqrestore(&is->buflock, flags);
-	copy_to_user(buf, save_buf, count);
+	if (copy_to_user(buf, save_buf, count)) {
+		kfree(save_buf);
+		return -EFAULT;
+	}
 	kfree(save_buf);
 
 	return count;



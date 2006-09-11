Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWIKPPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWIKPPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWIKPPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:15:34 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:860 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964849AbWIKPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:15:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dOThHgngam2VcRrnifJ+jnnmsyv1Cp5EXUkNvf7GcOdkhh5jAdEzMRZQL38dBARQjiyf7Vxs2F9G1Hqn0q7IwF0wXnccY1be2a4K/V6WsOwHHhC+COAZ0BF4OmO+CA7oTdaICHSLYNvyK+K90d2q+JD+O59Rfd78xTg2/T7rGCA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix warning: no return statement in function returning non-void in kernel/audit.c
Date: Mon, 11 Sep 2006 17:15:16 +0200
User-Agent: KMail/1.9.4
Cc: jesper.juhl@gmail.com, Rickard Faith <faith@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111715.17080.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kauditd_thread() is being used in a call to kthread_run(). kthread_run() expects
a function returning 'int' which is also how kauditd_thread() is declared. Unfortunately
kauditd_thread() neglects to return a value which results in this complaint from gcc :

  kernel/audit.c:372: warning: no return statement in function returning non-void

Easily fixed by just adding a 'return 0;' to kauditd_thread().


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 kernel/audit.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18-rc6-git3-orig/kernel/audit.c	2006-09-11 10:46:11.092786000 +0200
+++ linux-2.6.18-rc6-git3/kernel/audit.c	2006-09-11 17:08:00.888216381 +0200
@@ -369,6 +369,7 @@ static int kauditd_thread(void *dummy)
 			remove_wait_queue(&kauditd_wait, &wait);
 		}
 	}
+	return 0;
 }
 
 int audit_send_list(void *_dest)




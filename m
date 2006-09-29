Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWI2QXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWI2QXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWI2QXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:23:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:47419 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932324AbWI2QXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:23:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:mime-version:resent-cc:content-type:resent-date:message-id:content-transfer-encoding:resent-to:subject:resent-from:resent-message-id:date:x-mailer:from;
        b=r/cvMu48qXcOHwlaVXM7LsJZ19sDhhtYrhc+KkNrB84yVhLMOFmpL48GjstQcVPkz8bsSLQhW0pQeO9e9a6jSgf6La3eGx2xgDEgkvvdYYBn4aHVhAvQuWWG9d9FEGVDQ9s88DqMMDL3qh+T37kDlfjRqw9eS8dxYFUsoPDsl3M=
To: girishvg@gmail.com
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0635847A-C149-412C-92B1-A974230381F8@dts.local>
Content-Transfer-Encoding: 7bit
Subject: [PATCH] include children count, in Threads: field present in /proc/<pid>/status (take-1)
Date: Sat, 30 Sep 2006 00:18:17 +0900 (JST)
X-Mailer: Apple Mail (2.749)
From: girish <girishvg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

Could somebody please check if this is acceptable.

Thanks.

Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>


--- linux-vanilla/fs/proc/array.c	2006-09-20 12:42:06.000000000 +0900
+++ linux/fs/proc/array.c	2006-09-30 00:16:59.000000000 +0900
@@ -248,6 +248,8 @@ static inline char * task_sig(struct tas
  	int num_threads = 0;
  	unsigned long qsize = 0;
  	unsigned long qlim = 0;
+	int num_children = 0;
+	struct list_head *_p;

  	sigemptyset(&pending);
  	sigemptyset(&shpending);
@@ -268,9 +270,11 @@ static inline char * task_sig(struct tas
  		qlim = p->signal->rlim[RLIMIT_SIGPENDING].rlim_cur;
  		spin_unlock_irq(&p->sighand->siglock);
  	}
+	list_for_each(_p, &p->children)
+		++num_children;
  	read_unlock(&tasklist_lock);

-	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
+	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads +  
num_children);
  	buffer += sprintf(buffer, "SigQ:\t%lu/%lu\n", qsize, qlim);

  	/* render them all */

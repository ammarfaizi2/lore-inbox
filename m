Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVKLSio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVKLSio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVKLSio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:38:44 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:7691 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932451AbVKLSin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:38:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=SPyTr8i8M02v7WcCaWqD0ja6VHQiXHxw+RRRoZrceaFb5bsiZZyKrpZqESTyypRTYLcV6DldOB4iyjUn6De7C+jRmBsSPSXjRdWRSRLfnzb1HE9lix2dwIMzt/EFUnBWFwF3DqT5WozX5hOFyBufXvfErmGodfxXrCSKa9CXNRI=
Date: Sat, 12 Nov 2005 21:52:20 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>
Subject: [PATCH] block/elevator.c: forget about strncpy()
Message-ID: <20051112185220.GA19840@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 block/elevator.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/block/elevator.c
+++ b/block/elevator.c
@@ -163,7 +163,7 @@ static void elevator_setup_default(void)
 
 static int __init elevator_setup(char *str)
 {
-	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
+	strlcpy(chosen_elevator, str, sizeof(chosen_elevator));
 	return 0;
 }
 
@@ -751,8 +751,7 @@ ssize_t elv_iosched_store(request_queue_
 	size_t len;
 	struct elevator_type *e;
 
-	elevator_name[sizeof(elevator_name) - 1] = '\0';
-	strncpy(elevator_name, name, sizeof(elevator_name) - 1);
+	strlcpy(elevator_name, name, sizeof(elevator_name));
 	len = strlen(elevator_name);
 
 	if (len && elevator_name[len - 1] == '\n')


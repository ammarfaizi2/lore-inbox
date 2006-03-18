Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWCRWIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWCRWIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWCRWID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 17:08:03 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:40915 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751077AbWCRWIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 17:08:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ngXKUKCoFetHOZbu7iioUoarF/4eFtRoCd5BT++tYBbMIP6g1WysNEfbq/NWpzzv97dAVHKENsBCz47/Jb714jooVjP3DuObA6tdnvSxcm1BZ3dlinES9o48tmJehkDW1N2UlqppK+WeYD9d2DL2a8bgA9u2mJtDfd4ExDb2OSA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix potential null pointer deref in quota
Date: Sat, 18 Mar 2006 23:08:04 +0100
User-Agent: KMail/1.9.1
Cc: Jan Kara <jack@suse.cz>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182308.05050.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The coverity checker noticed that we may pass a NULL super_block to
do_quotactl() that dereferences it.
Dereferencing NULL pointers is bad medicine, better check and fail 
gracefully.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/quota.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.16-rc6-orig/fs/quota.c	2006-03-12 14:19:02.000000000 +0100
+++ linux-2.6.16-rc6/fs/quota.c	2006-03-18 23:03:32.000000000 +0100
@@ -231,6 +231,9 @@ static int do_quotactl(struct super_bloc
 {
 	int ret;
 
+	if (!sb)
+		return -ENODEV;
+
 	switch (cmd) {
 		case Q_QUOTAON: {
 			char *pathname;



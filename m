Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWHWIba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWHWIba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWHWIb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:31:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:50185 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964776AbWHWIb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:31:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z9MBQ3f9Cr4VljCY4NsDBPeDVwbas/KYEi6Oa6CFlCj++l5HNjENmGvjyW2gBKFtOicok/yZfQgItyaTZv5GQZqkHue5Gfpl1IYVIC5T79As0r8XhQOK5uTZmcKa1ljkYHP7tYmrrK85SBCV0BOsyc+X+4GWd3sazp+g6LJ5WLc=
Message-ID: <67029b170608230131i1b4d8ec1o5659e80e7a58bd78@mail.gmail.com>
Date: Wed, 23 Aug 2006 16:31:27 +0800
From: "Zhou Yingchao" <yingchao.zhou@gmail.com>
To: torvalds@osdl.org
Subject: [PATCH] Remove redundant up() in stop_machine(2.6.18-rc4)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    An up() is called in kernel/stop_machine.c on failure, and also in
the caller unconditionally. I have reported, but now it is still
there.

--- kernel/stop_machine.c.orig	2006-08-23 14:53:36.000000000 +0800
+++ kernel/stop_machine.c	2006-08-23 14:53:55.000000000 +0800
@@ -111,7 +111,6 @@ static int stop_machine(void)
 	/* If some failed, kill them all. */
 	if (ret < 0) {
 		stopmachine_set_state(STOPMACHINE_EXIT);
-		up(&stopmachine_mutex);
 		return ret;
 	}

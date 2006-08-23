Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWHWK1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWHWK1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWHWK1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:27:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:50347 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964817AbWHWK13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:27:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I8kqpboiy07DiDmiXAbFVIWUczabr0sJYRb1wN942C69jXiwcJWcdjj3Jl0BsMcklc3OvWLmWr3AnErycsBCqTzJGvbcm24hWfPDaYLsDz18JRKLlcsELk8vZdTcXu14MmS+XmJFCaW+9/WBojdLoKE7CC+mWqbIxaGwQTdEy54=
Message-ID: <67029b170608230327n580f8469m37a9dce00f73ea2f@mail.gmail.com>
Date: Wed, 23 Aug 2006 18:27:27 +0800
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
the caller unconditionally. I have reported, but now it is still here.

Signed-off-by: Zhou Yingchao <yingchao.zhou@gmail.com>
___
--- kernel/stop_machine.c.orig	2006-08-23 14:53:36.000000000 +0800
+++ kernel/stop_machine.c	2006-08-23 14:53:55.000000000 +0800
@@ -111,7 +111,6 @@ static int stop_machine(void)
 	/* If some failed, kill them all. */
 	if (ret < 0) {
 		stopmachine_set_state(STOPMACHINE_EXIT);
-		up(&stopmachine_mutex);
 		return ret;
 	}

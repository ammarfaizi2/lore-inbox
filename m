Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWHWKpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWHWKpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWHWKpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:45:22 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:6576 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S964833AbWHWKpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:45:22 -0400
Subject: [PATCH] Remove redundant up() in stop_machine(2.6.18-rc4)
From: Zhou Yingchao <yc_zhou@ncic.ac.cn>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 23 Aug 2006 18:45:43 +0800
Message-Id: <1156329943.2485.6.camel@zyc>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 An up() is called in kernel/stop_machine.c on failure, and also in
the caller unconditionally. I have reported, but now it is still here.

Signed-off-by: Zhou Yingchao <yingchao.zhou@gmail.com>
___
--- kernel/stop_machine.c.orig  2006-08-23 14:53:36.000000000 +0800
+++ kernel/stop_machine.c       2006-08-23 14:53:55.000000000 +0800
@@ -111,7 +111,6 @@ static int stop_machine(void)
       /* If some failed, kill them all. */
       if (ret < 0) {
               stopmachine_set_state(STOPMACHINE_EXIT);
-              up(&stopmachine_mutex);
               return ret;
       }


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWAZDtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWAZDtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAZDto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:44 -0500
Received: from [202.53.187.9] ([202.53.187.9]:17899 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932234AbWAZDtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:18 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 06/23] [Suspend2] Disable usermode helper invocations when the freezer is on.
Date: Thu, 26 Jan 2006 13:45:40 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034539.3178.56611.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Disable usermode helper invocations when the freezer is on. This avoids
deadlocks due to hotplug events occuring while processes are frozen.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/kmod.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/kmod.c b/kernel/kmod.c
index 51a8920..12afa2c 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/freezer.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
@@ -249,6 +250,9 @@ int call_usermodehelper_keys(char *path,
 	if (!khelper_wq)
 		return -EBUSY;
 
+	if (freezer_is_on())
+		return 0;
+
 	if (path[0] == '\0')
 		return 0;
 

--
Nigel Cunningham		nigel at suspend2 dot net

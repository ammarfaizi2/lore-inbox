Return-Path: <linux-kernel-owner+w=401wt.eu-S1754560AbWLRUk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbWLRUk4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbWLRUk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:40:56 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:37558 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbWLRUkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:40:55 -0500
Date: Mon, 18 Dec 2006 12:41:59 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Greg KH <greg@kroah.com>, akpm <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kay.sievers@vrfy.org
Subject: [PATCH] kobject.h with HOTPLUG=n
Message-Id: <20061218124159.63db048a.randy.dunlap@oracle.com>
In-Reply-To: <20061218195115.GA11312@kroah.com>
References: <4586D4A4.5060309@oracle.com>
	<20061218195115.GA11312@kroah.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix inline kobject functions to return 0 when CONFIG_HOTPLUG=n.

include/linux/kobject.h: In function 'kobject_uevent':
include/linux/kobject.h:277: warning: no return statement in function returning non-void
include/linux/kobject.h: In function 'kobject_uevent_env':
include/linux/kobject.h:281: warning: no return statement in function returning non-void
Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/linux/kobject.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.20-rc1-mm1.orig/include/linux/kobject.h
+++ linux-2.6.20-rc1-mm1/include/linux/kobject.h
@@ -274,11 +274,12 @@ int add_uevent_var(char **envp, int num_
 			const char *format, ...)
 	__attribute__((format (printf, 7, 8)));
 #else
-static inline int kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
+static inline int kobject_uevent(struct kobject *kobj, enum kobject_action action)
+{ return 0; }
 static inline int kobject_uevent_env(struct kobject *kobj,
 				      enum kobject_action action,
 				      char *envp[])
-{ }
+{ return 0; }
 
 static inline int add_uevent_var(char **envp, int num_envp, int *cur_index,
 				      char *buffer, int buffer_size, int *cur_len, 


---

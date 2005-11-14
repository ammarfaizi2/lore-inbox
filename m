Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVKNTij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVKNTij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVKNTie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:38:34 -0500
Received: from 81-178-76-253.dsl.pipex.com ([81.178.76.253]:64675 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751260AbVKNTiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:38:17 -0500
Date: Mon, 14 Nov 2005 19:37:38 +0000
To: akpm@osdl.org
Cc: apw@shadowen.org, kravetz@us.ibm.com, haveblue@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] register_ and unregister_memory_notifier should be global
Message-ID: <20051114193738.GA15494@shadowen.org>
References: <exportbomb.1131997056@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1131997056@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both register_memory_notifer and unregister_memory_notifier are global
and declared so in linux.h.  Update the HOTPLUG specific definitions
to match.  This fixes a compile warning when HOTPLUG is enabled.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 memory.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
diff -upN reference/drivers/base/memory.c current/drivers/base/memory.c
--- reference/drivers/base/memory.c
+++ current/drivers/base/memory.c
@@ -50,12 +50,12 @@ static struct kset_hotplug_ops memory_ho
 
 static struct notifier_block *memory_chain;
 
-static int register_memory_notifier(struct notifier_block *nb)
+int register_memory_notifier(struct notifier_block *nb)
 {
         return notifier_chain_register(&memory_chain, nb);
 }
 
-static void unregister_memory_notifier(struct notifier_block *nb)
+void unregister_memory_notifier(struct notifier_block *nb)
 {
         notifier_chain_unregister(&memory_chain, nb);
 }

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbTDEW6Z (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTDEW6Z (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:58:25 -0500
Received: from jalon.able.es ([212.97.163.2]:61664 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id S262713AbTDEW6T (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:58:19 -0500
Date: Sun, 6 Apr 2003 01:09:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] detached cloning
Message-ID: <20030405230944.GG12864@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405224233.GA12746@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030405224233.GA12746@werewolf.able.es>; from jamagallon@able.es on Sun, Apr 06, 2003 at 00:42:33 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.06, J.A. Magallon wrote:
> 
> On 04.04, Marcelo Tosatti wrote:
> > 
> > So here goes -pre7. Hopefully the last -pre.
> > 
> 

Fix a crash that can be caused by a CLONE_DETACHED thread.
Author: Ingo Molnar <mingo@elte.hu>

Does this still apply, Ingo ?

--- linux/kernel/exit.c.orig	Mon Sep  9 14:06:05 2002
+++ linux/kernel/exit.c	Mon Sep  9 14:06:25 2002
@@ -369,7 +369,7 @@
 	 *	
 	 */
 	
-	if(current->exit_signal != SIGCHLD &&
+	if(current->exit_signal != SIGCHLD && current->exit_signal != -1 &&
 	    ( current->parent_exec_id != t->self_exec_id  ||
 	      current->self_exec_id != current->parent_exec_id) 
 	    && !capable(CAP_KILL))

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Bamboo) for i586
Linux 2.4.21-pre7-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))

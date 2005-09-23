Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVIWInm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVIWInm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVIWInm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:43:42 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:4559 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1750811AbVIWInm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:43:42 -0400
Date: Fri, 23 Sep 2005 10:43:38 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.6.14-rc2-git2 fails compile -- fs/proc/base.c
Message-ID: <20050923084338.GA28198@fiberbit.xs4all.nl>
References: <200509230022.j8N0MPG4013164@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200509230022.j8N0MPG4013164@clem.clem-digital.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc 2.95.x compilation for fs/proc/base.c

Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>

---
 base.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

3fd07d3bf0077dcc0f5a33d2eb1938ea050da8da
diff --git a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -356,8 +356,9 @@ static int proc_task_root_link(struct in
 		task_unlock(leader);
 	} else {
 		/* Try to get fs from other threads */
+		struct task_struct *task;
 		task_unlock(leader);
-		struct task_struct *task = leader;
+		task = leader;
 		read_lock(&tasklist_lock);
 		if (pid_alive(task)) {
 			while ((task = next_thread(task)) != leader) {

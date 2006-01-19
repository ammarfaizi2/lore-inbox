Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWASBUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWASBUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWASBUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:20:54 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:63242 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1030493AbWASBUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:20:53 -0500
Date: Thu, 19 Jan 2006 09:19:40 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: Re: [PATCH 10/13] updated for rc1-mm1: autofs4 - white space cleanup
 for waitq.c
In-Reply-To: <200601180724.k0I7O9Go006193@eagle.themaw.net>
Message-ID: <Pine.LNX.4.64.0601190918420.3261@eagle.themaw.net>
References: <200601180724.k0I7O9Go006193@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Ian Kent wrote:

> Whitespace and formating changes to waitq code.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> 

--- linux-2.6.16-rc1-mm1/fs/autofs4/waitq.c.waitq-cleanup	2006-01-18 22:15:23.000000000 +0800
+++ linux-2.6.16-rc1-mm1/fs/autofs4/waitq.c	2006-01-18 22:16:04.000000000 +0800
@@ -33,7 +33,7 @@ void autofs4_catatonic_mode(struct autof
 	sbi->catatonic = 1;
 	wq = sbi->queues;
 	sbi->queues = NULL;	/* Erase all wait queues */
-	while ( wq ) {
+	while (wq) {
 		nwq = wq->next;
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name);
@@ -45,7 +45,6 @@ void autofs4_catatonic_mode(struct autof
 		fput(sbi->pipe);	/* Close the pipe */
 		sbi->pipe = NULL;
 	}
-
 	shrink_dcache_sb(sbi->sb);
 }
 
@@ -165,7 +164,7 @@ int autofs4_wait(struct autofs_sb_info *
 	int len, status;
 
 	/* In catatonic mode, we don't wait for nobody */
-	if ( sbi->catatonic )
+	if (sbi->catatonic)
 		return -ENOENT;
 	
 	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
@@ -190,7 +189,7 @@ int autofs4_wait(struct autofs_sb_info *
 			break;
 	}
 
-	if ( !wq ) {
+	if (!wq) {
 		/* Can't wait for an expire if there's no mount */
 		if (notify == NFY_NONE && !d_mountpoint(dentry)) {
 			kfree(name);
@@ -200,7 +199,7 @@ int autofs4_wait(struct autofs_sb_info *
 
 		/* Create a new wait queue */
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
-		if ( !wq ) {
+		if (!wq) {
 			kfree(name);
 			mutex_unlock(&sbi->wq_mutex);
 			return -ENOMEM;
@@ -240,14 +239,14 @@ int autofs4_wait(struct autofs_sb_info *
 
 	/* wq->name is NULL if and only if the lock is already released */
 
-	if ( sbi->catatonic ) {
+	if (sbi->catatonic) {
 		/* We might have slept, so check again for catatonic mode */
 		wq->status = -ENOENT;
 		kfree(wq->name);
 		wq->name = NULL;
 	}
 
-	if ( wq->name ) {
+	if (wq->name) {
 		/* Block all but "shutdown" signals while waiting */
 		sigset_t oldset;
 		unsigned long irqflags;
@@ -283,12 +282,12 @@ int autofs4_wait_release(struct autofs_s
 	struct autofs_wait_queue *wq, **wql;
 
 	mutex_lock(&sbi->wq_mutex);
-	for ( wql = &sbi->queues ; (wq = *wql) != 0 ; wql = &wq->next ) {
-		if ( wq->wait_queue_token == wait_queue_token )
+	for (wql = &sbi->queues ; (wq = *wql) != 0 ; wql = &wq->next) {
+		if (wq->wait_queue_token == wait_queue_token)
 			break;
 	}
 
-	if ( !wq ) {
+	if (!wq) {
 		mutex_unlock(&sbi->wq_mutex);
 		return -EINVAL;
 	}

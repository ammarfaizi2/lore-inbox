Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbUKDCC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUKDCC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUKDCCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:02:17 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:916 "EHLO
	zion.localdomain") by vger.kernel.org with ESMTP id S262053AbUKDBzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:44 -0500
Subject: [patch 09/20] uml: use SIG_IGN for empty sighandler
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:35 +0100
Message-Id: <20041103231735.8C1E955C79@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid creating a dummy no-op procedure instead of using SIG_IGN.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/drivers/chan_user.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -puN arch/um/drivers/chan_user.c~uml-use-SIG_IGN-for-empty-handling arch/um/drivers/chan_user.c
--- vanilla-linux-2.6.9/arch/um/drivers/chan_user.c~uml-use-SIG_IGN-for-empty-handling	2004-11-03 23:44:59.439523936 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/chan_user.c	2004-11-03 23:44:59.442523480 +0100
@@ -37,10 +37,6 @@ int generic_console_write(int fd, const 
 	return(err);
 }
 
-static void winch_handler(int sig)
-{
-}
-
 struct winch_data {
 	int pty_fd;
 	int pipe_fd;
@@ -63,7 +59,7 @@ static int winch_thread(void *arg)
 		printk("winch_thread : failed to write synchronization "
 		       "byte, err = %d\n", -count);
 
-	signal(SIGWINCH, winch_handler);
+	signal(SIGWINCH, SIG_IGN);
 	sigfillset(&sigs);
 	sigdelset(&sigs, SIGWINCH);
 	if(sigprocmask(SIG_SETMASK, &sigs, NULL) < 0){
_

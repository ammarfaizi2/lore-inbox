Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWJQV1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWJQV1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWJQV1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:27:39 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:36440 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750725AbWJQV1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=WqoatGwo3FKU6CmnGAZqbC2n7QIEiBwVXXY0uyFYc6hlBfmRK8hBUcW6BLGBBM6X/lqzgiAQ5jzVSmw/PxVGSAWl/1byKRJjKCyFFMDTvV8vfuQtNtxdN9qbHWKD87KsjWCGUHq9pZp1OSd13EbzL3RgR3hTHQ2RZ1zsHi9RY28=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 05/10] uml: code convention cleanup of a file
Date: Tue, 17 Oct 2006 23:27:13 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212713.26445.72572.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix coding conventions violations is arch/um/os-Linux/helper.c.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/helper.c |   53 ++++++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index f72c512..e887179 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -38,17 +38,17 @@ static int helper_child(void *arg)
 	char **argv = data->argv;
 	int errval;
 
-	if(helper_pause){
+	if (helper_pause) {
 		signal(SIGHUP, helper_hup);
 		pause();
 	}
-	if(data->pre_exec != NULL)
+	if (data->pre_exec != NULL)
 		(*data->pre_exec)(data->pre_data);
 	errval = execvp_noalloc(data->buf, argv[0], argv);
 	printk("helper_child - execvp of '%s' failed - errno = %d\n", argv[0], -errval);
 	os_write_file(data->fd, &errval, sizeof(errval));
 	kill(os_getpid(), SIGKILL);
-	return(0);
+	return 0;
 }
 
 /* Returns either the pid of the child process we run or -E* on failure.
@@ -60,20 +60,21 @@ int run_helper(void (*pre_exec)(void *),
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	if((stack_out != NULL) && (*stack_out != 0))
+	if ((stack_out != NULL) && (*stack_out != 0))
 		stack = *stack_out;
-	else stack = alloc_stack(0, __cant_sleep());
-	if(stack == 0)
+	else
+		stack = alloc_stack(0, __cant_sleep());
+	if (stack == 0)
 		return -ENOMEM;
 
 	ret = os_pipe(fds, 1, 0);
-	if(ret < 0){
+	if (ret < 0) {
 		printk("run_helper : pipe failed, ret = %d\n", -ret);
 		goto out_free;
 	}
 
 	ret = os_set_exec_close(fds[1], 1);
-	if(ret < 0){
+	if (ret < 0) {
 		printk("run_helper : setting FD_CLOEXEC failed, ret = %d\n",
 		       -ret);
 		goto out_close;
@@ -86,7 +87,7 @@ int run_helper(void (*pre_exec)(void *),
 	data.fd = fds[1];
 	data.buf = __cant_sleep() ? um_kmalloc_atomic(PATH_MAX) : um_kmalloc(PATH_MAX);
 	pid = clone(helper_child, (void *) sp, CLONE_VM | SIGCHLD, &data);
-	if(pid < 0){
+	if (pid < 0) {
 		ret = -errno;
 		printk("run_helper : clone failed, errno = %d\n", errno);
 		goto out_free2;
@@ -98,10 +99,10 @@ int run_helper(void (*pre_exec)(void *),
 	/* Read the errno value from the child, if the exec failed, or get 0 if
 	 * the exec succeeded because the pipe fd was set as close-on-exec. */
 	n = os_read_file(fds[0], &ret, sizeof(ret));
-	if(n == 0)
+	if (n == 0) {
 		ret = pid;
-	else {
-		if(n < 0){
+	} else {
+		if (n < 0) {
 			printk("run_helper : read on pipe failed, ret = %d\n",
 			       -n);
 			ret = n;
@@ -117,10 +118,11 @@ out_close:
 		close(fds[1]);
 	close(fds[0]);
 out_free:
-	if(stack_out == NULL)
+	if (stack_out == NULL)
 		free_stack(stack, 0);
-	else *stack_out = stack;
-	return(ret);
+	else
+		*stack_out = stack;
+	return ret;
 }
 
 int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
@@ -130,31 +132,32 @@ int run_helper_thread(int (*proc)(void *
 	int pid, status, err;
 
 	stack = alloc_stack(stack_order, __cant_sleep());
-	if(stack == 0) return(-ENOMEM);
+	if (stack == 0)
+		return -ENOMEM;
 
 	sp = stack + (page_size() << stack_order) - sizeof(void *);
 	pid = clone(proc, (void *) sp, flags | SIGCHLD, arg);
-	if(pid < 0){
+	if (pid < 0) {
 		err = -errno;
 		printk("run_helper_thread : clone failed, errno = %d\n",
 		       errno);
 		return err;
 	}
-	if(stack_out == NULL){
+	if (stack_out == NULL) {
 		CATCH_EINTR(pid = waitpid(pid, &status, 0));
-		if(pid < 0){
+		if (pid < 0) {
 			err = -errno;
 			printk("run_helper_thread - wait failed, errno = %d\n",
 			       errno);
 			pid = err;
 		}
-		if(!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
+		if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
 			printk("run_helper_thread - thread returned status "
 			       "0x%x\n", status);
 		free_stack(stack, stack_order);
-	}
-	else *stack_out = stack;
-	return(pid);
+	} else
+		*stack_out = stack;
+	return pid;
 }
 
 int helper_wait(int pid)
@@ -162,9 +165,9 @@ int helper_wait(int pid)
 	int ret;
 
 	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG));
-	if(ret < 0){
+	if (ret < 0) {
 		ret = -errno;
 		printk("helper_wait : waitpid failed, errno = %d\n", errno);
 	}
-	return(ret);
+	return ret;
 }
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

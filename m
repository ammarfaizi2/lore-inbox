Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSK1A2z>; Wed, 27 Nov 2002 19:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSK1A2z>; Wed, 27 Nov 2002 19:28:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10757 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264986AbSK1A2v>;
	Wed, 27 Nov 2002 19:28:51 -0500
Date: Wed, 27 Nov 2002 16:28:05 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] More LSM changes for 2.5.49
Message-ID: <20021128002805.GF7187@kroah.com>
References: <20021127230626.GB7187@kroah.com> <20021128002638.GD7187@kroah.com> <20021128002730.GE7187@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128002730.GE7187@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.927, 2002/11/27 15:12:52-08:00, greg@kroah.com

LSM: change if statements into something more readable for the ipc/*, mm/*, and net/* files.


diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Wed Nov 27 15:18:04 2002
+++ b/ipc/msg.c	Wed Nov 27 15:18:04 2002
@@ -101,7 +101,8 @@
 	msq->q_perm.key = key;
 
 	msq->q_perm.security = NULL;
-	if ((retval = security_msg_queue_alloc(msq))) {
+	retval = security_msg_queue_alloc(msq);
+	if (retval) {
 		ipc_rcu_free(msq, sizeof(*msq));
 		return retval;
 	}
diff -Nru a/ipc/sem.c b/ipc/sem.c
--- a/ipc/sem.c	Wed Nov 27 15:18:04 2002
+++ b/ipc/sem.c	Wed Nov 27 15:18:04 2002
@@ -136,7 +136,8 @@
 	sma->sem_perm.key = key;
 
 	sma->sem_perm.security = NULL;
-	if ((retval = security_sem_alloc(sma))) {
+	retval = security_sem_alloc(sma);
+	if (retval) {
 		ipc_rcu_free(sma, size);
 		return retval;
 	}
diff -Nru a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c	Wed Nov 27 15:18:04 2002
+++ b/ipc/shm.c	Wed Nov 27 15:18:04 2002
@@ -188,7 +188,8 @@
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 
 	shp->shm_perm.security = NULL;
-	if ((error = security_shm_alloc(shp))) {
+	error = security_shm_alloc(shp);
+	if (error) {
 		ipc_rcu_free(shp, sizeof(*shp));
 		return error;
 	}
diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	Wed Nov 27 15:18:04 2002
+++ b/mm/mmap.c	Wed Nov 27 15:18:04 2002
@@ -504,7 +504,8 @@
 		}
 	}
 
-	if ((error = security_file_mmap(file, prot, flags)))
+	error = security_file_mmap(file, prot, flags);
+	if (error)
 		return error;
 		
 	/* Clear old maps */
diff -Nru a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	Wed Nov 27 15:18:04 2002
+++ b/mm/mprotect.c	Wed Nov 27 15:18:04 2002
@@ -263,7 +263,8 @@
 			goto out;
 		}
 
-		if ((error = security_file_mprotect(vma, prot)))
+		error = security_file_mprotect(vma, prot);
+		if (error)
 			goto out;
 
 		if (vma->vm_end > end) {
diff -Nru a/net/core/scm.c b/net/core/scm.c
--- a/net/core/scm.c	Wed Nov 27 15:18:04 2002
+++ b/net/core/scm.c	Wed Nov 27 15:18:04 2002
@@ -217,7 +217,8 @@
 	for (i=0, cmfptr=(int*)CMSG_DATA(cm); i<fdmax; i++, cmfptr++)
 	{
 		int new_fd;
-		if ((err = security_file_receive(fp[i])))
+		err = security_file_receive(fp[i]);
+		if (err)
 			break;
 		err = get_unused_fd();
 		if (err < 0)

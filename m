Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbTAZAGU>; Sat, 25 Jan 2003 19:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTAZAGT>; Sat, 25 Jan 2003 19:06:19 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:54184 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S265205AbTAZAGT>;
	Sat, 25 Jan 2003 19:06:19 -0500
Date: Sun, 26 Jan 2003 01:15:11 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] epoll for 2.4.20 updated ...
Message-ID: <20030126001511.GE1507@werewolf.able.es>
References: <Pine.LNX.4.50.0301242004010.2858-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.50.0301242004010.2858-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Sat, Jan 25, 2003 at 05:06:30 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.25 Davide Libenzi wrote:
> 
> I updated the 2.4.20 patch with the changes posted today and I fixed a
> little error about the wait queue function prototype :
> 
> http://www.xmailserver.org/linux-patches/sys_epoll-2.4.20-0.61.diff
> 

I needed this to build smbfs:

--- linux-2.4.21-pre3-jam3/fs/smbfs/sock.c.orig	2003-01-26 01:02:32.000000000 +0100
+++ linux-2.4.21-pre3-jam3/fs/smbfs/sock.c	2003-01-26 01:03:11.000000000 +0100
@@ -314,7 +314,7 @@
 smb_receive_poll(struct smb_sb_info *server)
 {
 	struct file *file = server->sock_file;
-	poll_table wait_table;
+	struct poll_wqueues wait_table;
 	int result = 0;
 	int timeout = server->mnt->timeo * HZ;
 	int mask;
@@ -323,7 +323,7 @@
 		poll_initwait(&wait_table);
                 set_current_state(TASK_INTERRUPTIBLE);
 
-		mask = file->f_op->poll(file, &wait_table);
+		mask = file->f_op->poll(file, &wait_table.pt);
 		if (mask & POLLIN) {
 			poll_freewait(&wait_table);
 			current->state = TASK_RUNNING;

Is it correct ?

TIA 

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre3-jam3 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-4mdk))

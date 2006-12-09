Return-Path: <linux-kernel-owner+w=401wt.eu-S1030681AbWLIMTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030681AbWLIMTm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030715AbWLIMTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:19:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59861 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030646AbWLIMTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:19:41 -0500
Message-ID: <457AA9D7.7050509@redhat.com>
Date: Sat, 09 Dec 2006 07:19:35 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] ensure unique i_ino in filesystems without permanent
 inode numbers (pipefs)
References: <457891F8.9090607@redhat.com>
In-Reply-To: <457891F8.9090607@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
 > pipefs is a rather busy filesystem and so is a good place to start to make
 > sure we flush out any performance problems
 >

This patch changes the earlier patch to use the new_registered_inode wrapper
and that simplifies things a bit. It also goes ahead and changes over sockfs
in the same way.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/pipe.c b/fs/pipe.c
index f8b6bdc..4d30f49 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -846,7 +846,7 @@ static struct dentry_operations pipefs_d

  static struct inode * get_pipe_inode(void)
  {
-	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
+	struct inode *inode = new_registered_inode(pipe_mnt->mnt_sb, 0);
  	struct pipe_inode_info *pipe;

  	if (!inode)
diff --git a/net/socket.c b/net/socket.c
index 4e39631..ec63a96 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -486,7 +486,7 @@ static struct socket *sock_alloc(void)
  	struct inode *inode;
  	struct socket *sock;

-	inode = new_inode(sock_mnt->mnt_sb);
+	inode = new_registered_inode(sock_mnt->mnt_sb, 0);
  	if (!inode)
  		return NULL;


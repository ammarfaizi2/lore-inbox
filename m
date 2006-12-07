Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163503AbWLGWNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163503AbWLGWNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163506AbWLGWNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:13:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56082 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163495AbWLGWNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:13:14 -0500
Message-ID: <457891F8.9090607@redhat.com>
Date: Thu, 07 Dec 2006 17:13:12 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] ensure unique i_ino in filesystems without permanent
 inode numbers (pipefs)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pipefs is a rather busy filesystem and so is a good place to start to make
sure we flush out any performance problems

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/pipe.c b/fs/pipe.c
index b1626f2..d74ae65 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -845,6 +845,9 @@ static struct inode * get_pipe_inode(voi
  	if (!inode)
  		goto fail_inode;

+	if (iunique_register(inode, 0))
+		goto fail_iput;
+
  	pipe = alloc_pipe_info(inode);
  	if (!pipe)
  		goto fail_iput;

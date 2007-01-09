Return-Path: <linux-kernel-owner+w=401wt.eu-S932106AbXAITb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbXAITb5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbXAITb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:31:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:24714 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbXAITb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:31:56 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rT/imIq8ZIQWeROQyD8PKHwcK8p2MIBk3l5X0uyHpbPAxGGN2c60sTVVh+4pl4Wi5uJfic58KgHBkWG/wfCwv6vptD8WNo5RClG7M8TJ/CsLNvXUrgwFRJ6Fo07w69NZ3MBvCBspyg/PagRcZHdSP1YV7NpulHSE549O2gLLIz8=
Date: Tue, 9 Jan 2007 22:31:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [PATCH] cpia.c: buffer overflow
Message-ID: <20070109193153.GB4996@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If assigned minor is 10 or greater, terminator will be put beyound the end.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/media/video/cpia.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/media/video/cpia.c
+++ b/drivers/media/video/cpia.c
@@ -1350,13 +1350,13 @@ out:
 
 static void create_proc_cpia_cam(struct cam_data *cam)
 {
-	char name[7];
+	char name[5 + 1 + 10 + 1];
 	struct proc_dir_entry *ent;
 
 	if (!cpia_proc_root || !cam)
 		return;
 
-	sprintf(name, "video%d", cam->vdev.minor);
+	snprintf(name, sizeof(name), "video%d", cam->vdev.minor);
 
 	ent = create_proc_entry(name, S_IFREG|S_IRUGO|S_IWUSR, cpia_proc_root);
 	if (!ent)
@@ -1376,12 +1376,12 @@ static void create_proc_cpia_cam(struct 
 
 static void destroy_proc_cpia_cam(struct cam_data *cam)
 {
-	char name[7];
+	char name[5 + 1 + 10 + 1];
 
 	if (!cam || !cam->proc_entry)
 		return;
 
-	sprintf(name, "video%d", cam->vdev.minor);
+	snprintf(name, sizeof(name), "video%d", cam->vdev.minor);
 	remove_proc_entry(name, cpia_proc_root);
 	cam->proc_entry = NULL;
 }


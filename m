Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWFZU4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWFZU4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWFZU4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:56:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59405 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932126AbWFZU4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:56:31 -0400
Date: Mon, 26 Jun 2006 22:56:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, neilb@cse.unsw.edu.au,
       linux-raid@vger.kernel.org
Subject: [-mm patch] make variables static after klibc merge
Message-ID: <20060626205629.GE23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can now make the following variables static:
- drivers/md/md.c: mdp_major
- init/main.c: envp_init[]

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 May 2006

 drivers/md/md.c |    2 +-
 init/main.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc4-mm1-full/drivers/md/md.c.old	2006-05-16 12:49:59.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/md/md.c	2006-05-16 12:50:17.000000000 +0200
@@ -2563,7 +2563,7 @@
 	.default_attrs	= md_default_attrs,
 };
 
-int mdp_major = 0;
+static int mdp_major = 0;
 
 static struct kobject *md_probe(dev_t dev, int *part, void *data)
 {
--- linux-2.6.17-rc4-mm1-full/init/main.c.old	2006-05-16 13:20:22.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/init/main.c	2006-05-16 13:20:43.000000000 +0200
@@ -161,7 +161,7 @@
 __setup("maxcpus=", maxcpus);
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
-char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
+static char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 static const char *panic_later, *panic_param;
 
 extern struct obs_kernel_param __setup_start[], __setup_end[];


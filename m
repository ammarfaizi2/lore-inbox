Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVGWRJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVGWRJD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVGWRJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:09:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7442 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262368AbVGWRIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:08:17 -0400
Date: Sat, 23 Jul 2005 19:08:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/core/memalloc.c: fix PROC_FS=n compilation
Message-ID: <20050723170811.GH3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC      sound/core/memalloc.o
sound/core/memalloc.c: In function 'snd_mem_exit':
sound/core/memalloc.c:657: error: 'snd_mem_proc' undeclared (first use in this function)
sound/core/memalloc.c:657: error: (Each undeclared identifier is reported only once
sound/core/memalloc.c:657: error: for each function it appears in.)
make[2]: *** [sound/core/memalloc.o] Error 1

<--  snip  -->


Since snd_mem_proc was needlessly global, I've also made it static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/sound/core/memalloc.c.old	2005-07-23 01:25:03.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/sound/core/memalloc.c	2005-07-23 01:30:35.000000000 +0200
@@ -505,13 +505,13 @@
 	up(&list_mutex);
 }
 
+static struct proc_dir_entry *snd_mem_proc;
 
 #ifdef CONFIG_PROC_FS
 /*
  * proc file interface
  */
 #define SND_MEM_PROC_FILE	"driver/snd-page-alloc"
-struct proc_dir_entry *snd_mem_proc;
 
 static int snd_mem_proc_read(char *page, char **start, off_t off,
 			     int count, int *eof, void *data)


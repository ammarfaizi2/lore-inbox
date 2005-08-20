Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932787AbVHTTDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbVHTTDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbVHTTDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:03:05 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17163 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932786AbVHTTDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:03:00 -0400
Date: Sat, 20 Aug 2005 21:02:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/core/memalloc.c: fix PROC_FS=n compilation
Message-ID: <20050820190258.GA3615@stusta.de>
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
sound/core/memalloc.c:658: error: 'snd_mem_proc' undeclared (first use in this function)
sound/core/memalloc.c:658: error: (Each undeclared identifier is reported only once
sound/core/memalloc.c:658: error: for each function it appears in.)
make[2]: *** [sound/core/memalloc.o] Error 1

<--  snip  -->



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/sound/core/memalloc.c.old	2005-08-20 15:12:55.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/sound/core/memalloc.c	2005-08-20 15:16:55.000000000 +0200
@@ -506,13 +506,13 @@
 	up(&list_mutex);
 }
 
+static struct proc_dir_entry *snd_mem_proc;
 
 #ifdef CONFIG_PROC_FS
 /*
  * proc file interface
  */
 #define SND_MEM_PROC_FILE	"driver/snd-page-alloc"
-static struct proc_dir_entry *snd_mem_proc;
 
 static int snd_mem_proc_read(char *page, char **start, off_t off,
 			     int count, int *eof, void *data)

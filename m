Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTFGN1b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 09:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTFGN1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 09:27:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43734 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263179AbTFGN1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 09:27:30 -0400
Date: Sat, 7 Jun 2003 15:41:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [patch] 2.5.70-mm5: Compile error if !CONFIG_PROC_FS
Message-ID: <20030607134100.GJ15311@fs.tum.de>
References: <20030605021231.2b3ebc59.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605021231.2b3ebc59.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following compile error if !CONFIG_PROC_FS comes from 
Linus' tree:

<--  snip  -->

...
  CC      init/main.o
In file included from init/main.c:15:
include/linux/proc_fs.h:238: redefinition of `kclist_add'
include/linux/proc_fs.h:231: `kclist_add' previously defined here
include/linux/proc_fs.h:239: redefinition of `kclist_del'
include/linux/proc_fs.h:234: `kclist_del' previously defined here
include/linux/proc_fs.h: In function `kclist_del':
include/linux/proc_fs.h:239: syntax error before '}' token
include/linux/proc_fs.h:239: warning: no return statement in function 
returning non-void
make[1]: *** [init/main.o] Error 1

<--  snip  -->


The fis is trivial:


--- linux-2.5.70-mm5/include/linux/proc_fs.h.old	2003-06-07 15:33:21.000000000 +0200
+++ linux-2.5.70-mm5/include/linux/proc_fs.h	2003-06-07 15:34:04.000000000 +0200
@@ -235,8 +235,6 @@
 	return NULL;
 }
 
-static inline void kclist_add(struct kcore_list *new, void *addr, size_t size) {};
-static inline struct kcore_list * kclist_del(void *addr) {return NULL};
 #endif /* CONFIG_PROC_FS */
 
 struct proc_inode {




cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


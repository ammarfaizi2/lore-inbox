Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSHaFRq>; Sat, 31 Aug 2002 01:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSHaFRq>; Sat, 31 Aug 2002 01:17:46 -0400
Received: from dp.samba.org ([66.70.73.150]:30091 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316089AbSHaFRo>;
	Sat, 31 Aug 2002 01:17:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: mzyngier@freesurf.fr
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu, torvalds@transmeta.com
Subject: Re: [Patch] Futex misses kill_sb 
In-reply-to: Your message of "30 Aug 2002 16:52:37 +0200."
             <wrpptw05rgq.fsf@hina.wild-wind.fr.eu.org> 
Date: Sat, 31 Aug 2002 15:12:32 +1000
Message-Id: <20020831002231.153AB2C06D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <wrpptw05rgq.fsf@hina.wild-wind.fr.eu.org> you write:
> Hi all,
> 
> The enclosed patch fixes a missing .kill_sb in futexes' fs_type
> declaration. Without this patch, kernel oopses if someone ever tries
> to mount futexfs...

<shrug>Viro ripped it out in 2.5.26.  Al?

Rusty.

From: Marc Zyngier <mzyngier@freesurf.fr>
diff -Nru a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c	Fri Aug 30 19:26:44 2002
+++ b/kernel/futex.c	Fri Aug 30 19:26:44 2002
@@ -359,6 +359,7 @@
 static struct file_system_type futex_fs_type = {
 	.name		= "futexfs",
 	.get_sb		= futexfs_get_sb,
+	.kill_sb	= kill_anon_super,
 };
 
 static int __init init(void)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

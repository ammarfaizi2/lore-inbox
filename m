Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSLBBZd>; Sun, 1 Dec 2002 20:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSLBBYJ>; Sun, 1 Dec 2002 20:24:09 -0500
Received: from dp.samba.org ([66.70.73.150]:17043 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263256AbSLBBXh>;
	Sun, 1 Dec 2002 20:23:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't sort kallsyms symbols twice
Date: Mon, 02 Dec 2002 12:26:22 +1100
Message-Id: <20021202013103.1E00B2C083@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

	Trivial optimization from Andrew Morton.

Name: Don't sort kallsyms symbols twice
Author: Andrew Morton
Status: Trivial

D:  scripts/kallsyms |    2 +-
D: 1 files changed, 1 insertion(+), 1 deletion(-)

--- 25/scripts/kallsyms~b	Tue Nov 19 21:54:27 2002
+++ 25-akpm/scripts/kallsyms	Tue Nov 19 21:54:34 2002
@@ -31,7 +31,7 @@ encode_symbols()
 }
 
 # FIXME: Use System.map as input, and regenerate each time in Makefile.
-$NM $1 | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > kallsyms.map
+$NM -n $1 | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > kallsyms.map
 
 encode_symbols kallsyms.map > kallsyms.c
 $CC $CFLAGS -c -o $2 kallsyms.c

_


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSJaJ67>; Thu, 31 Oct 2002 04:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264807AbSJaJ67>; Thu, 31 Oct 2002 04:58:59 -0500
Received: from angband.namesys.com ([212.16.7.85]:41604 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S264806AbSJaJ65>; Thu, 31 Oct 2002 04:58:57 -0500
Date: Thu, 31 Oct 2002 13:05:17 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: [2.4] [PATCH] Make reiserfs to refuse mounting of non 4K blocksize filesystems
Message-ID: <20021031130517.A13414@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There seems to be some confusion going on among the users who try
   to use non-standard blocksize reiserfs filesystems with 2.4 kernels
   (where this support is not yet merged) and are able to easily crash
   kernel this way, so it seems following patch is necessary for now,
   that only allows to mount 4K-blocksize reiserfs filesystems.

   Please apply.

   Thank you.

Bye,
    Oleg

===== fs/reiserfs/super.c 1.26 vs edited =====
--- 1.26/fs/reiserfs/super.c	Thu Sep 12 12:39:21 2002
+++ edited/fs/reiserfs/super.c	Wed Oct 30 16:42:36 2002
@@ -863,6 +863,12 @@
 	s->s_blocksize_bits ++;
 
     brelse (bh);
+
+    if (s->s_blocksize != 4096) {
+	printk("Unsupported reiserfs blocksize: %ld on %s, only 4096 bytes "
+	       "blocksize is supported.\n", s->s_blocksize, kdevname (s->s_dev));
+	return 1;
+    }
     
     if (s->s_blocksize != size)
 	set_blocksize (s->s_dev, s->s_blocksize);

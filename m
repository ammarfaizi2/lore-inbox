Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281529AbRKMGES>; Tue, 13 Nov 2001 01:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281534AbRKMGEJ>; Tue, 13 Nov 2001 01:04:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63874 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281529AbRKMGDu>;
	Tue, 13 Nov 2001 01:03:50 -0500
Date: Mon, 12 Nov 2001 22:03:41 -0800 (PST)
Message-Id: <20011112.220341.54186374.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15344.46456.814742.182373@notabene.cse.unsw.edu.au>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
	<15344.46456.814742.182373@notabene.cse.unsw.edu.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Tue, 13 Nov 2001 16:54:00 +1100 (EST)

   uhci.c:2986: warning: initialization discards qualifiers from pointer target type

The correct fix for this one is below and already sent
to Linus:

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/linux/module.h linux/include/linux/module.h
--- vanilla/linux/include/linux/module.h	Mon Nov 12 15:13:12 2001
+++ linux/include/linux/module.h	Mon Nov 12 17:11:04 2001
@@ -317,7 +317,7 @@
  * const, other exit data may be writable.
  */
 #define MODULE_GENERIC_TABLE(gtype,name) \
-static struct gtype##_id * __module_##gtype##_table \
+static const struct gtype##_id * __module_##gtype##_table \
   __attribute__ ((unused, __section__(".data.exit"))) = name
 
 #ifndef __GENKSYMS__

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278209AbRJ1MGi>; Sun, 28 Oct 2001 07:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278218AbRJ1MG3>; Sun, 28 Oct 2001 07:06:29 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:53641 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S278209AbRJ1MGO>;
	Sun, 28 Oct 2001 07:06:14 -0500
Date: Sun, 28 Oct 2001 13:06:43 +0100
From: Dirk Mueller <dmuell@gmx.net>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] 2.4.14-pre3 and umount
Message-ID: <20011028130643.A20591@rotes20.wohnheim.uni-kl.de>
In-Reply-To: <20011028045744.BE5C22A109@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20011028045744.BE5C22A109@oscar.casa.dyndns.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Son, 28 Okt 2001, Ed Tomlinson wrote:

> else see this behavior?  With straight 2.4.14-pre3?

Try this patch, which is floating around for over half a year already and 
still not in the kernel:


Dirk

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=53_reiser-snapshot-fix

diff -urN linux-2.4.4.tmp/fs/reiserfs/super.c linux-2.4.4.SuSE/fs/reiserfs/super.c
--- linux-2.4.4.tmp/fs/reiserfs/super.c	Mon Apr 30 16:01:29 2001
+++ linux-2.4.4.SuSE/fs/reiserfs/super.c	Mon Apr 30 16:02:13 2001
@@ -80,7 +80,7 @@
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     reiserfs_block_writes(&th) ;
-    journal_end(&th, s, 1) ;
+    journal_end_sync(&th, s, 1) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;

--zhXaljGHf11kAtnf--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274347AbRITGly>; Thu, 20 Sep 2001 02:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274345AbRITGlo>; Thu, 20 Sep 2001 02:41:44 -0400
Received: from [195.223.140.107] ([195.223.140.107]:11006 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274346AbRITGlf>;
	Thu, 20 Sep 2001 02:41:35 -0400
Date: Thu, 20 Sep 2001 08:41:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Robert Love <rml@tech9.net>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Message-ID: <20010920084131.C1629@athlon.random>
In-Reply-To: <1000939458.3853.17.camel@phantasy> <20010920063143.424BD1E41A@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920063143.424BD1E41A@Cantor.suse.de>; from Dieter.Nuetzel@hamburg.de on Thu, Sep 20, 2001 at 08:31:34AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Those inodes lines reminded me one thing, you may want to give it a try:

--- 2.4.10pre12aa1/fs/inode.c.~1~	Thu Sep 20 01:44:07 2001
+++ 2.4.10pre12aa1/fs/inode.c	Thu Sep 20 08:37:33 2001
@@ -295,6 +295,12 @@
 			 * so we have to start looking from the list head.
 			 */
 			tmp = head;
+
+			if (unlikely(current->need_resched)) {
+				spin_unlock(&inode_lock);
+				schedule();
+				spin_lock(&inode_lock);
+			}
 		}
 	}
 
Andrea

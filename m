Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271332AbRHZRDx>; Sun, 26 Aug 2001 13:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271334AbRHZRDn>; Sun, 26 Aug 2001 13:03:43 -0400
Received: from [194.213.32.142] ([194.213.32.142]:48901 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S271332AbRHZRDb>;
	Sun, 26 Aug 2001 13:03:31 -0400
Message-ID: <20010826190121.A24395@bug.ucw.cz>
Date: Sun, 26 Aug 2001 19:01:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Swap reclaiming
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Browsing through 2.4.8 patch, I found this:

+/*
+ * When swap space gets filled up, we will set this flag.
+ * This will make do_swap_page(), in the page fault path,
+ * free swap entries on swapin so we'll reclaim swap space
+ * in order to be able to swap something out.
+ *
+ * At the moment we start reclaiming when swap usage goes
+ * over 80% of swap space.
+ *
+ * XXX: Random numbers, fixme.
+ */
+#define SWAP_FULL_PCT 80
+int vm_swap_full (void)
+{
+       int swap_used = total_swap_pages - nr_swap_pages;
+
+       return swap_used * 100 > total_swap_pages * SWAP_FULL_PCT;
+}
+

Hmm... This kind-of defeats purposes on swap priorities: with this,
you are going to fill slow swap even through there is lots of fast
swap that could be reclaimed.

I'm not sure what fix should be.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

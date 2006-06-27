Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWF0GeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWF0GeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWF0GeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:34:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36803 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932157AbWF0GeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:34:18 -0400
Date: Mon, 26 Jun 2006 23:33:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 07/13] [Suspend2] Page_alloc paranoia.
Message-Id: <20060626233353.052ae23c.pj@sgi.com>
In-Reply-To: <20060627044248.15066.52507.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
	<20060627044248.15066.52507.stgit@nigel.suspend2.net>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel wrote:
-	do {
-		if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
-			wakeup_kswapd(*z, order);
-	} while (*(++z));
+	if (likely(!test_freezer_state(FREEZER_ON))) {
+		do {
+			if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
+				wakeup_kswapd(*z, order);
+		} while (*(++z));
+	}


The cpuset_zone_allowed() check above was removed recently, thanks to 
a Chris Wright patch.  So the above patch won't apply to Linus's or
Andrew's current tree.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

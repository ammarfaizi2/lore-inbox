Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVLNIl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVLNIl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVLNIl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:41:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47806 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932149AbVLNIkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:40:55 -0500
Date: Wed, 14 Dec 2005 00:40:43 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Simon Derr <Simon.Derr@bull.net>,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051214084043.21054.37648.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 03/04] Cpuset: mark number_of_cpusets read_mostly
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark cpuset global 'number_of_cpusets' as __read_mostly.

This global is accessed everytime a zone is considered
in the zonelist loops beneath __alloc_pages, looking for
a free memory page.  If number_of_cpusets is just one,
then we can short circuit the mems_allowed check.

Since this global is read alot on a hot path, and written
rarely, it is an excellent candidate for __read_mostly.

Thanks to Christoph Lameter for the suggestion.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-13 18:08:26.644979252 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-13 18:09:55.658647865 -0800
@@ -62,7 +62,7 @@
  * When there is only one cpuset (the root cpuset) we can
  * short circuit some hooks.
  */
-int number_of_cpusets;
+int number_of_cpusets __read_mostly;
 
 /* See "Frequency meter" comments, below. */
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

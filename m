Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVASAbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVASAbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVASAbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:31:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14331 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261504AbVASAbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:31:49 -0500
Message-ID: <41EDAA6E.5000900@mvista.com>
Date: Tue, 18 Jan 2005 16:31:42 -0800
From: Steve Longerbeam <stevel@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-mm <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: BUG in shared_policy_replace() ?
Content-Type: multipart/mixed;
 boundary="------------020207020808080703030302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020207020808080703030302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andi,

Why free the shared policy created to split up an old
policy that spans the whole new range? Ie, see patch.

Steve

--------------020207020808080703030302
Content-Type: text/plain;
 name="mempolicy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempolicy.diff"

--- mm/mempolicy.c.orig	2005-01-18 16:13:35.573273351 -0800
+++ mm/mempolicy.c	2005-01-18 16:24:23.940608135 -0800
@@ -1052,10 +1052,6 @@
 	if (new)
 		sp_insert(sp, new);
 	spin_unlock(&sp->lock);
-	if (new2) {
-		mpol_free(new2->policy);
-		kmem_cache_free(sn_cache, new2);
-	}
 	return 0;
 }
 

--------------020207020808080703030302--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUCOF1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUCOF1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:27:36 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:49025 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262256AbUCOF1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:27:33 -0500
Date: Mon, 15 Mar 2004 00:23:57 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.4-mm2
Message-ID: <20040315002357.GE5972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040315000615.GA5972@neo.rr.com> <20040315001029.GB5972@neo.rr.com> <20040315001519.GC5972@neo.rr.com> <20040315002146.GD5972@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315002146.GD5972@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ISAPNP] Remove uneeded MOD_INC/DEC_USE_COUNT

From: Christoph Hellwig <hch@lst.de>

isapnp_cfg_begin and isapnp_cfg_end are exported symbols, so if any
module using them is loaded isapnp.o can't be unloaded anyway.


--- 1.43/drivers/pnp/isapnp/core.c	Sun Sep 21 21:10:18 2003
+++ edited/drivers/pnp/isapnp/core.c	Sun Oct  5 16:17:52 2003
@@ -934,7 +934,6 @@
 {
 	if (csn < 1 || csn > 10 || logdev > 10)
 		return -EINVAL;
-	MOD_INC_USE_COUNT;
 	down(&isapnp_cfg_mutex);
 	isapnp_wait();
 	isapnp_key();
@@ -962,7 +961,6 @@
 {
 	isapnp_wait();
 	up(&isapnp_cfg_mutex);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }

 #undef SPRINTF


 

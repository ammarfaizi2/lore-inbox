Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752114AbWFWWLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbWFWWLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWFWWLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:11:06 -0400
Received: from fmr17.intel.com ([134.134.136.16]:35291 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752114AbWFWWLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:11:04 -0400
Date: Fri, 23 Jun 2006 15:13:07 -0700
From: mark gross <mgross@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: mbellon@mvista.com, mark.gross@intel.com
Subject: [PATCH] type-oh bug in tlclk.c
Message-ID: <20060623221307.GA5205@linux.intel.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Bellon found a bug in my tlclk driver.  Thanks!

I botch the register mask for store_received_ref_clk3a.  

See http://download.intel.com/design/network/manuals/30412001.pdf
tables 124 and 136 for details.

Please apply.

thanks,

--mgross

Signed-off-by : Mark Gross <mark.gross@intel.com>

diff -urN -X ../linux-2.6.17.1/Documentation/dontdiff ../linux-2.6.17.1/drivers/char/tlclk.c tlclk/linux-2.6.17.1/drivers/char/tlclk.c
--- ../linux-2.6.17.1/drivers/char/tlclk.c	2006-06-20 02:31:55.000000000 -0700
+++ tlclk/linux-2.6.17.1/drivers/char/tlclk.c	2006-06-23 14:12:21.000000000 -0700
@@ -343,7 +343,7 @@
 
 	val = (unsigned char)tmp;
 	spin_lock_irqsave(&event_lock, flags);
-	SET_PORT_BITS(TLCLK_REG1, 0xef, val << 1);
+	SET_PORT_BITS(TLCLK_REG1, 0xdf, val << 1);
 	spin_unlock_irqrestore(&event_lock, flags);
 
 	return strnlen(buf, count);


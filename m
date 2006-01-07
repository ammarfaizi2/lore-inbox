Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbWAGTow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWAGTow (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWAGTow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:44:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15808 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030565AbWAGTov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:44:51 -0500
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
From: Arjan van de Ven <arjan@infradead.org>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <20060107190531.GB8990@kurtwerks.com>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	 <1136544309.2940.25.camel@laptopd505.fenrus.org>
	 <20060107190531.GB8990@kurtwerks.com>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 20:44:48 +0100
Message-Id: <1136663088.2936.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 14:05 -0500, Kurt Wall wrote:

> 
> This patch was applied on top of the previous 6 in the series from
> Arjan. NB that it _did_ build with 3.4.4 and -Os enabled. I'm
> rechecking, but this is the second time I've encountered this failure.


Does this fix it?

Signed-off-by: Arjan van de Ven <arjan@infradead.org>

--- linux-2.6.15/include/asm-x86_64/fixmap.h~	2006-01-07 20:42:31.000000000 +0100
+++ linux-2.6.15/include/asm-x86_64/fixmap.h	2006-01-07 20:42:31.000000000 +0100
@@ -76,7 +76,7 @@
  * directly without translation, we catch the bug with a NULL-deference
  * kernel oops. Illegal ranges of incoming indices are caught too.
  */
-static inline unsigned long fix_to_virt(const unsigned int idx)
+static __always_inline unsigned long fix_to_virt(const unsigned int idx)
 {
 	/*
 	 * this branch gets completely eliminated after inlining,



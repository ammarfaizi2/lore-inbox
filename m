Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWF2SKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWF2SKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWF2SKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:10:23 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:3000 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751232AbWF2SKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:10:22 -0400
Date: Thu, 29 Jun 2006 19:10:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>
Cc: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
Message-ID: <20060629181013.GA18777@linux-mips.org>
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca> <20060628140825.692f31be.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628140825.692f31be.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 02:08:25PM -0700, Randy.Dunlap wrote:

> Hi,
> Peter Anvin mentioned just a few days ago that this threshold value
> should be 4095 for all arches.  I think we need to get that patch
> done & submitted to Andrew for -mm.

So here the patch is:

 o Raise the maximum error number in IS_ERR_VALUE to 4095.
 o Make that number available as a new constant MAX_ERRNO.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/linux/err.h b/include/linux/err.h
index ff71d2a..cd3b367 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -13,7 +13,9 @@ #include <asm/errno.h>
  * This should be a per-architecture thing, to allow different
  * error and pointer decisions.
  */
-#define IS_ERR_VALUE(x) unlikely((x) > (unsigned long)-1000L)
+#define MAX_ERRNO	4095
+
+#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
 
 static inline void *ERR_PTR(long error)
 {

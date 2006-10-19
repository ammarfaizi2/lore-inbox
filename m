Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161370AbWJSJgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161370AbWJSJgB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161371AbWJSJgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:36:00 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:50386 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1161370AbWJSJf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:35:59 -0400
Date: Thu, 19 Oct 2006 18:35:49 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] s390: Point sys_getcpu_wrapper at the proper syscall.
Message-ID: <20061019093549.GA28354@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the new syscall additions, I noticed that
sys_getcpu_wrapper wraps in to sys_tee, in what appears to be
a copy and paste error.  Switch it to point to sys_getcpu..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 arch/s390/kernel/compat_wrapper.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index cb0efae..71e54ef 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1664,4 +1664,4 @@ sys_getcpu_wrapper:
 	llgtr	%r2,%r2			# unsigned *
 	llgtr	%r3,%r3			# unsigned *
 	llgtr	%r4,%r4			# struct getcpu_cache *
-	jg	sys_tee
+	jg	sys_getcpu

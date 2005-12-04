Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVLDOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVLDOik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVLDOik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:38:40 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60104 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932235AbVLDOik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:38:40 -0500
Date: Sun, 4 Dec 2005 20:28:23 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rt21 & evolution
Message-ID: <20051204145823.GA5756@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1133642866.16477.11.camel@cmn3.stanford.edu> <1133647737.5890.2.camel@mindpipe> <1133653696.16477.47.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <1133653696.16477.47.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 03, 2005 at 03:48:16PM -0800, Fernando Lopez-Lezcano wrote:
> 
> To tell the truth this does not seem like a -rt related problem except
> that it started happening the day I booted into -rt21. 
> 

Can you try this patch below. Ingo has already included it in his tree
and will probably show up in -rt22.

This was changed in -rt14 and returns spurious -ETIMEDOUT from
FUTEX_WAIT calls which I just checked that evo does a lot of

	-Dinakar


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="revert-timeout.patch"

Index: linux-2.6.14-rt21-rayrt4/kernel/futex.c
===================================================================
--- linux-2.6.14-rt21-rayrt4.orig/kernel/futex.c	2005-12-02 16:55:26.000000000 +0530
+++ linux-2.6.14-rt21-rayrt4/kernel/futex.c	2005-12-02 17:21:20.000000000 +0530
@@ -1527,7 +1527,7 @@
 			  int val3)
 {
 	struct timespec t;
-	unsigned long timeout = 0;
+	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 	int val2 = 0;
 
 	if ((op == FUTEX_WAIT || op == FUTEX_WAIT_ROBUST) && utime) {

--dDRMvlgZJXvWKvBx--

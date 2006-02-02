Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWBBXag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWBBXag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWBBXag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:30:36 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:28397 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932467AbWBBXaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:30:35 -0500
Date: Thu, 2 Feb 2006 18:28:17 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc1-mm4 i386 atomic operations broken on SMP (in
  modules at least)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kraxel@suse.de, neilb@suse.de
Message-ID: <200602021830_MC3-1-B773-597F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060202135205.08d91b76.akpm@osdl.org>

On Thu, 2 Feb 2006 at 13:52:05 -0800, Andrew Morton wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > 
> > SMP alternatives is re-using the constant_tsc X86 feature bit.
> > 
> 
> Darn, how did you spot that?

I went looking for which bit represented X86_FEATURE_UP and there
it was...

>
> Should `feature_up' appear in /proc/cpuinfo?

Probably.  The bug would have been nearly impossible if that had
been done to begin with.


i386: show x86 feature "up" in cpuinfo

Show feature bit "up" (SMP kernel running on uniprocessor) in
/proc/cpuinfo.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/proc.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/proc.c
@@ -40,7 +40,7 @@ static int show_cpuinfo(struct seq_file 
 		/* Other (Linux-defined) */
 		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr",
 		NULL, NULL, NULL, NULL,
-		"constant_tsc", NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		"constant_tsc", "up", NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
-- 
Chuck

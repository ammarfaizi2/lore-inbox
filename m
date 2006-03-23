Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWCWTJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWCWTJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWCWTJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:09:30 -0500
Received: from fmr21.intel.com ([143.183.121.13]:52870 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932569AbWCWTJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:09:28 -0500
Date: Thu, 23 Mar 2006 11:09:22 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
Message-ID: <20060323190922.GA13695@agluck-lia64.sc.intel.com>
References: <20060323164623.699f569e.sfr@canb.auug.org.au> <20060323185234.GA13486@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323185234.GA13486@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 10:52:34AM -0800, Luck, Tony wrote:
> Applied this and patch #2 ... builds cleanly on ia64.  I don't have
> a handy test case to confirm that adjtimex works (but since the old
> version was inside "#ifdef NOTYET", it's probably safe to assume that
> this patch is a step forward).

Oh ... but since we didn't have adjtimex implemented, it wasn't
hooked into the syscall table.  This additional patch does that.
I'm in two minds whether it would be useful to add (nobody has
complained about the lack of 32-bit adjtimex support so far, so
this may be all risk, with no benefit).

Add it if you like.

Signed-off-by: Tony Luck <tony.luck@intel.com>


diff --git a/arch/ia64/ia32/ia32_entry.S b/arch/ia64/ia32/ia32_entry.S
index 95fe044..9cb61a3 100644
--- a/arch/ia64/ia32/ia32_entry.S
+++ b/arch/ia64/ia32/ia32_entry.S
@@ -334,7 +334,7 @@ ia32_syscall_table:
 	data8 sys_setdomainname
 	data8 sys32_newuname
 	data8 sys32_modify_ldt
-	data8 sys_ni_syscall	/* adjtimex */
+	data8 sys32_adjtimex
 	data8 sys32_mprotect	  /* 125 */
 	data8 compat_sys_sigprocmask
 	data8 sys_ni_syscall	/* create_module */

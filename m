Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVHBVnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVHBVnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVHBVnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:43:50 -0400
Received: from fmr22.intel.com ([143.183.121.14]:10961 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261803AbVHBVMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:12:54 -0400
Date: Tue, 2 Aug 2005 14:12:39 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [Patch] don't kick ALB in the presence of pinned task
Message-ID: <20050802141238.A27704@unix-os.sc.intel.com>
References: <20050801174221.B11610@unix-os.sc.intel.com> <42EF0E0D.8000906@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42EF0E0D.8000906@yahoo.com.au>; from nickpiggin@yahoo.com.au on Tue, Aug 02, 2005 at 04:09:17PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 04:09:17PM +1000, Nick Piggin wrote:
> I have a patch here which I still need to do more testing with,
> which might help performance on HT systems.
> 
> I found that idle siblings could cause SMP and NUMA balancing to
> be too aggressive in some cases.
> -- 
> If an idle sibling of an HT queue encounters a busy sibling, then
> make higher level load balancing of the non-idle variety.

Makes sense and patch looks good. Please push this minor comment fix along
with your patch. Thanks.

--- linux-2.6.13-rc4/kernel/sched.c~	2005-08-02 13:36:34.804764128 -0700
+++ linux-2.6.13-rc4/kernel/sched.c	2005-08-02 13:38:00.689707632 -0700
@@ -2316,7 +2316,9 @@
 
 		if (j - sd->last_balance >= interval) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
-				/* We've pulled tasks over so no longer idle */
+				/* We've pulled tasks over so no longer idle
+				 * or one of our SMT sibling is not idle.
+				 */
 				idle = NOT_IDLE;
 			}
 			sd->last_balance += interval;

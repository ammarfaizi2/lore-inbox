Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWFNW7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWFNW7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWFNW7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:59:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38033 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964990AbWFNW7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:59:21 -0400
Subject: Re: [PATCH 07/11] Task watchers:  Register per-task delay
	accounting task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>
In-Reply-To: <448F8302.3030706@watson.ibm.com>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242889.21787.147.camel@stark>  <448F8302.3030706@watson.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 15:52:57 -0700
Message-Id: <1150325578.21787.293.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 23:31 -0400, Shailabh Nagar wrote:
> 
> 
> Matt Helsley wrote:
> 
> >Adapts delayacct to use Task Watchers. Does not adapt taskstats to use Task
> >Watchers.
> >
> >Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> >Cc: Shailabh Nagar <nagar@watson.ibm.com>
> >Cc: Balbir Singh <balbir@in.ibm.com>
> >Cc: Chandra S. Seetharaman <sekharan@us.ibm.com>
> >--
> >
> > include/linux/delayacct.h |    2 +-
> > kernel/delayacct.c        |   23 +++++++++++++++++++++++
> > kernel/exit.c             |    2 --
> > kernel/fork.c             |    2 --
> > 4 files changed, 24 insertions(+), 5 deletions(-)
> >
> >
> >  
> >
> <snip>
> 
> >Index: linux-2.6.17-rc5-mm2/include/linux/delayacct.h
> >===================================================================
> >--- linux-2.6.17-rc5-mm2.orig/include/linux/delayacct.h
> >+++ linux-2.6.17-rc5-mm2/include/linux/delayacct.h
> >@@ -59,11 +59,11 @@ static inline void delayacct_tsk_init(st
> > 		__delayacct_tsk_init(tsk);
> > }
> > 
> > static inline void delayacct_tsk_exit(struct task_struct *tsk)
> > {
> >-	if (tsk->delays)
> >+	if (unlikely(tsk->delays))
> > 		__delayacct_tsk_exit(tsk);
> > }
> >  
> >
> 
> This snippet does not belong to this patchset...since the same check 
> (for tsk->delays) is
> being used elsewhere in the delay accounting code, changes to use of 
> likely/unlikely should
> be done elsewhere too, if deemed necesssary.

Good point. I'll remove this chunk of the patch.

<snip>

Cheers,
	-Matt Helsley


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWFNDbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWFNDbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 23:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWFNDbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 23:31:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:63666 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751085AbWFNDbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 23:31:18 -0400
Message-ID: <448F8302.3030706@watson.ibm.com>
Date: Tue, 13 Jun 2006 23:31:14 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>
Subject: Re: [PATCH 07/11] Task watchers:  Register per-task delay accounting
 task watcher
References: <20060613235122.130021000@localhost.localdomain> <1150242889.21787.147.camel@stark>
In-Reply-To: <1150242889.21787.147.camel@stark>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Matt Helsley wrote:

>Adapts delayacct to use Task Watchers. Does not adapt taskstats to use Task
>Watchers.
>
>Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
>Cc: Shailabh Nagar <nagar@watson.ibm.com>
>Cc: Balbir Singh <balbir@in.ibm.com>
>Cc: Chandra S. Seetharaman <sekharan@us.ibm.com>
>--
>
> include/linux/delayacct.h |    2 +-
> kernel/delayacct.c        |   23 +++++++++++++++++++++++
> kernel/exit.c             |    2 --
> kernel/fork.c             |    2 --
> 4 files changed, 24 insertions(+), 5 deletions(-)
>
>
>  
>
<snip>

>Index: linux-2.6.17-rc5-mm2/include/linux/delayacct.h
>===================================================================
>--- linux-2.6.17-rc5-mm2.orig/include/linux/delayacct.h
>+++ linux-2.6.17-rc5-mm2/include/linux/delayacct.h
>@@ -59,11 +59,11 @@ static inline void delayacct_tsk_init(st
> 		__delayacct_tsk_init(tsk);
> }
> 
> static inline void delayacct_tsk_exit(struct task_struct *tsk)
> {
>-	if (tsk->delays)
>+	if (unlikely(tsk->delays))
> 		__delayacct_tsk_exit(tsk);
> }
>  
>

This snippet does not belong to this patchset...since the same check 
(for tsk->delays) is
being used elsewhere in the delay accounting code, changes to use of 
likely/unlikely should
be done elsewhere too, if deemed necesssary.

Otherwise patch looks good though I've not tested whether delay 
accounting works unaffected
(don't see any reason why it shouldn't).


--Shailabh



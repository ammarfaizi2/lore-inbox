Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUC3HpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbUC3HpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:45:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24511 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263335AbUC3Ho5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:44:57 -0500
Date: Tue, 30 Mar 2004 09:45:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040330074506.GB21596@elte.hu>
References: <20040329084531.GB29458@wotan.suse.de> <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <20040330064015.GA19036@elte.hu> <20040330090716.67d2a493.ak@suse.de> <40691E58.2080500@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40691E58.2080500@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >This works much better, but wildly varying (my tests go from 2.8xCPU to 
> >~3.8x CPU for 4 CPUs. 2,3 CPU cases are ok). A bit more consistent 
> >results would be better though.
> 
> Oh good, thanks Ingo. Andi you probably want to lower your minimum
> balance time too then, and maybe try with an even lower maximum. Maybe
> reduce cache_hot_time a bit too.

i dont think we want to balance with that high of a frequency on NUMA
Opteron. These tunes were for testing only.

i'm dusting off the balance-on-clone patch right now, that should be the
correct solution. It is based on a find_idlest_cpu() function which
searches for the least loaded CPU and checks whether we can do passive
load-balancing to it. Ie. it's yet another balancing point in the
scheduler, _not_ some balancing logic change.

	Ingo

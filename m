Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVHBJm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVHBJm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVHBJm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:42:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21716 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261439AbVHBJm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:42:56 -0400
Date: Tue, 2 Aug 2005 11:43:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [Patch] don't kick ALB in the presence of pinned task
Message-ID: <20050802094318.GC20978@elte.hu>
References: <20050801174221.B11610@unix-os.sc.intel.com> <42EF0E0D.8000906@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EF0E0D.8000906@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Siddha, Suresh B wrote:
> >Jack Steiner brought this issue at my OLS talk.
> >
> >Take a scenario where two tasks are pinned to two HT threads in a physical
> >package. Idle packages in the system will keep kicking migration_thread
> >on the busy package with out any success.
> >
> >We will run into similar scenarios in the presence of CMP/NUMA.
> >
> >Patch appended.
> >
> 
> Hmm, I would have hoped the new "all_pinned" logic should have handled 
> this case properly. [...]

no, active_balance is a different case, not covered by the all_pinned 
logic. This is a HT-special scenario, where busiest->nr_running == 1, 
and we have to do active load-balancing. This does not go through 
move_tasks() and does not set all_pinned. (If nr_running werent 1 we'd 
not have to kick active load-balancing.)

	Ingo

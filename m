Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268883AbUIQPed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbUIQPed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUIQPd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:33:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:41630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268883AbUIQPQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:16:29 -0400
Date: Fri, 17 Sep 2004 08:16:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
In-Reply-To: <20040917103945.GA19861@elte.hu>
Message-ID: <Pine.LNX.4.58.0409170813520.2338@ppc970.osdl.org>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Sep 2004, Ingo Molnar wrote:
> 
> the attached patch is a simplified variant of the remove-bkl patch i
> sent two days ago: it doesnt do the ->cpus_allowed trick.
> 
> The question is, is there any BKL-using kernel code that relies on the
> task not migrating to another CPU within the BLK critical section?

I don't think there can be any _valid_ such use.

Anything that knows about CPU's has to use "get_cpu()/put_cpu()" anyway. 
You might add back in the debugging checks that we used to have for 
"smp_processor_id()" in this patch for testing, and if it goes into -mm 
we'd see if anything triggers.

I still don't exactly love this patch to death, but making the cpumask 
trickery go away does make it look a lot simpler, I have to say.

			Linus

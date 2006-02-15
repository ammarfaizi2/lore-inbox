Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWBOSml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWBOSml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWBOSmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:42:40 -0500
Received: from ns.suse.de ([195.135.220.2]:18357 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750774AbWBOSmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:42:40 -0500
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Date: Wed, 15 Feb 2006 19:42:19 +0100
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060215151711.GA31569@elte.hu> <p73lkwc5xv2.fsf@verdi.suse.de> <43F36A00.602@redhat.com>
In-Reply-To: <43F36A00.602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151942.20494.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 18:50, Ulrich Drepper wrote:
> Andi Kleen wrote:
> > e.g. you could add a new VMA flag that says "when one user
> > of this dies unexpectedly by a signal kill all" 
> 
> "kill all"?  

It would solve the problem statement given by Ingo in the rationale 
for this kernel patch - cleaning up after a hanging yum. 

If there are any other problems this is intended to solve then they 
should be stated in the rationale.

> > And what happens if the patch is rejected? I don't really think you
> > can force patches in this way ("do it or I break glibc")
> 
> Nothing which relies on the syscalls goes into cvs unless the kernel
> side is first committed. I never do this. 

Great we agree on that then.

> The list being corrupted means that the mutexes are corrupted.  In which
> case the application would crash anyway.

I'm not concerned about the application, just about the kernel.

> As for the "endless loop".  You didn't read the code, it seems.  There
> are two mechanisms to prevent this: the list is destroyed when the
> individual elements are handled and there is an upper limit on the
> number of robust mutexes which can be registered.  The limit is
> ridiculously high so it'll no problem for correct programs and it also
> will eliminate run-away list following code.

Ok good that's handled. How about long blocking on swapped out pages
in exit?

You would need a SO_LINGER I guess, but implementing that would be 
fairly nasty.

I think the "kill all" approach would be much simpler.


-Andi

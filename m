Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWIRPdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWIRPdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWIRPdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:33:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:22145 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751778AbWIRPdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:33:23 -0400
Date: Mon, 18 Sep 2006 17:24:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, bcrl@kvack.org
Subject: Re: Sysenter crash with Nested Task Bit set
Message-ID: <20060918152458.GA13273@elte.hu>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com> <20060917222537.55241d19.akpm@osdl.org> <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org> <200609181729.23934.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609181729.23934.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> >  #define switch_to(prev,next,last) do {					\
> >  	unsigned long esi,edi;						\
> > -	asm volatile("pushl %%ebp\n\t"					\
> > +	asm volatile("pushfl\n\t"		/* Save flags */	\
> > +		     "pushl %%ebp\n\t"					\
> 
> We used to do that pushfl/popfl some time ago, but Ben removed it 
> because it was slow on P4.  Ok, nobody thought of that case back then.

I _should_ have thought of that though, because when this change was 
done originally i had to reintroduce it both for exec-shield and for 
-rt, so apparently it must have triggered in certain circumstances - i 
just didnt notice the reason. (but recent exec-shield and -rt patches 
dont have this revert, so the condition must have gone away. But it was 
a long time ago.)

	Ingo

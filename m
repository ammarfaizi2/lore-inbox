Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWIRQNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWIRQNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWIRQNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:13:10 -0400
Received: from kanga.kvack.org ([66.96.29.28]:30885 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751822AbWIRQNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:13:09 -0400
Date: Mon, 18 Sep 2006 12:12:51 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Sysenter crash with Nested Task Bit set
Message-ID: <20060918161251.GC19815@kvack.org>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com> <20060917222537.55241d19.akpm@osdl.org> <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org> <200609181729.23934.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609181729.23934.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 05:29:23PM +0200, Andi Kleen wrote:
> > -	asm volatile("pushl %%ebp\n\t"					\
> > +	asm volatile("pushfl\n\t"		/* Save flags */	\
> > +		     "pushl %%ebp\n\t"					\
> 
> We used to do that pushfl/popfl some time ago, but Ben removed it because
> it was slow on P4.  Ok, nobody thought of that case back then.

It's the pushfl that will be slow on any OoO CPU, as it has dependancies on 
any previous instructions that modified the flags, which ends up bringing 
all of the memory ordering dependancies into play.  Doing a popfl to set the 
flags to some known value is much less expensive.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.

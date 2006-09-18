Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWIRQue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWIRQue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWIRQue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:50:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:47305 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751844AbWIRQub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:50:31 -0400
From: Andi Kleen <ak@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Sysenter crash with Nested Task Bit set
Date: Mon, 18 Sep 2006 18:39:45 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com> <200609181729.23934.ak@suse.de> <20060918161251.GC19815@kvack.org>
In-Reply-To: <20060918161251.GC19815@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181839.45546.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 18:12, Benjamin LaHaise wrote:
> On Mon, Sep 18, 2006 at 05:29:23PM +0200, Andi Kleen wrote:
> > > -	asm volatile("pushl %%ebp\n\t"					\
> > > +	asm volatile("pushfl\n\t"		/* Save flags */	\
> > > +		     "pushl %%ebp\n\t"					\
> > 
> > We used to do that pushfl/popfl some time ago, but Ben removed it because
> > it was slow on P4.  Ok, nobody thought of that case back then.
> 
> It's the pushfl that will be slow on any OoO CPU, as it has dependancies on  
> any previous instructions that modified the flags, which ends up bringing 
> all of the memory ordering dependancies into play.  Doing a popfl to set the 
> flags to some known value is much less expensive.

Yes it's never fast, but on basically all non P4 CPUs it is still fast enough
to not be a problem. I suppose it causes a trace cache flush or something like
that there.

-Andi

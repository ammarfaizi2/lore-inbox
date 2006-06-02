Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWFBUxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWFBUxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWFBUxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:53:23 -0400
Received: from nevyn.them.org ([66.93.172.17]:63950 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S964884AbWFBUxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:53:22 -0400
Date: Fri, 2 Jun 2006 16:53:01 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jan Beulich <jbeulich@novell.com>, jeff@garzik.org, htejun@gmail.com,
       Andrew Morton <akpm@osdl.org>, reuben-lkml@reub.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602205301.GA5928@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Jan Beulich <jbeulich@novell.com>, jeff@garzik.org,
	htejun@gmail.com, Andrew Morton <akpm@osdl.org>,
	reuben-lkml@reub.net, linux-kernel@vger.kernel.org
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu> <20060601105300.GA2985@elte.hu> <447EF7A8.76E4.0078.0@novell.com> <448006F6.76E4.0078.0@novell.com> <20060602075150.GA12212@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602075150.GA12212@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 09:51:50AM +0200, Ingo Molnar wrote:
> 
> * Jan Beulich <jbeulich@novell.com> wrote:
> 
> > >firstly, i'd suggest to use another magic value for 'bottom of call 
> > >stacks' - it is way too common to jump or call a NULL pointer. Something 
> > >like 0xfedcba9876543210 would be better.
> > 
> > That's contrary to common use (outside of the kernel). I'm opposed to 
> > this. Detecting an initial bad EIP isn't a problem, and the old code 
> > can be used easily in that case.
> 
> but 0 is pretty much the worst choice for something that needs to be 
> reliable - it's the most common type of machine word in existence, 
> amongst all the 18446744073709551616 possibilities. And we need not care 
> about userspace's prior choices, this code and data is totally under the 
> kernel's control.

I've missed some context here, but assuming you're talking about DWARF
and reliably marking the end of the backtrace, why not actually mark
stack termination instead of futzing around with zeros?  GDB now
detects the return address column in the unwind info being set to
undefined and treats that as an end of stack.  Then you can treat any
other zeros you encounter as problems.


-- 
Daniel Jacobowitz
CodeSourcery

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUHENGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUHENGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUHENF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:05:28 -0400
Received: from colin2.muc.de ([193.149.48.15]:55559 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267205AbUHEMy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:54:28 -0400
Date: 5 Aug 2004 14:54:23 +0200
Date: Thu, 5 Aug 2004 14:54:23 +0200
From: Andi Kleen <ak@muc.de>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: prasanna@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [1/3] kprobes-func-args-268-rc3.patch
Message-ID: <20040805125423.GA63682@muc.de>
References: <2pMJz-13N-9@gated-at.bofh.it> <m3acx9yh6t.fsf@averell.firstfloor.org> <20040805122431.GA4411@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805122431.GA4411@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 05:54:31PM +0530, Suparna Bhattacharya wrote:
> > I think you misunderstood Linus' suggestion.  The problem with
> > modifying arguments on the stack frame is always there because the C
> > ABI allows it. One suggested solution was to use a second function
> 
> I did realise that it is the ABI which allows this, but I thought
> that the only situation in which we know gcc to actually clobber
> arguments from the callee in practice is for tailcall optimization. 

It just breaks the most common workaround. 

> I'm not sure if that can be guaranteed and yes saving bytes from
> stack would avoid the problem totally (hence the comment) and make
> it less tied to expected innards of the compiler. The only issue 
> with that is deciding the maximum number of arguments so it is 
> generic enough. 

64bytes, aka 16 arguments seem far enough.

> > call that passes the arguments again to get a private copy. But the
> > compiler's tail call optimization could sabotate that when you a
> > are not careful.
> > 
> > That's all quite hackish and compiler dependent. I would suggest an 
> > assembly wrapper that copies the arguments when !CONFIG_REGPARM.
> > Just assume the function doesn't have more than a fixed number
> > of arguments, that should be good enough.
> > 
> > This way you avoid any subtle compiler dependencies.
> > With CONFIG_REGPARM it's enough to just save/restore pt_regs,
> > which kprobes will do anyways.
> > >  
> 
> Even with CONFIG_REGPARM, if you have a large 
> number of arguments for example, is spill over into stack 
> a possibility ?

Yes. For more than three (Linux uses -mregparm=3) 
Also varargs arguments will be always on the stack I think.

-Andi

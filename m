Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVK2N1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVK2N1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 08:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVK2N1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 08:27:44 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:14985 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751356AbVK2N1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 08:27:43 -0500
Date: Tue, 29 Nov 2005 18:57:30 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH & RFC] kdump and stack overflows
Message-ID: <20051129132730.GA3803@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1133183463.2327.96.camel@localhost.localdomain> <m1lkz8gad7.fsf@ebiederm.dsl.xmission.com> <1133200815.2425.98.camel@localhost.localdomain> <m1hd9wfwxi.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hd9wfwxi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 11:29:29AM -0700, Eric W. Biederman wrote:
> Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:
> 
> > On Mon, 2005-11-28 at 06:39 -0700, Eric W. Biederman wrote: 
> >> Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:
> 
> > Regarding the stack overflow audit of the nmi path, we have the problem
> > that both nmi_enter and nmi_exit in do_nmi (see code below) make heavy
> > use of "current" indirectly (specially through the kernel preemption
> > code).
> 
> Ok.  I wonder if it would be saner to simply replace the nmi trap
> handler on the crash dump path?
> 

Sounds interesting.

> >> I believe we have a separate interrupt stack that
> >> should help but..
> > Yes, when using 4K stacks we have a separate interrupt stack that should
> > help, but I am afraid that crash dumping is about being paranoid.
> 
> Oh I agree.  If we had a private 4K stack for the nmi handler we
> would not need to worry about overflow in that case. 

Having private 4K stack makes sense as crash_nmi_callback() itself
requires quite some space on stack. If one has enabled CONFIG_4KSTACKS,
then we use separate interrupt stack and we are probably safe from stack
overflows but otherwise we need it. 

> (baring
> nmi happening during nmis)  Hmm.  Is there anything to keep
> us doing something bad in that case?
> 
> I guess as long as we don't clear the high bit of port 0x70 we
> should be reasonably safe from the nmi firing multiple times.

Are you referring to port 0x23 for IMCR register.

Thanks
Vivek

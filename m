Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVK3GJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVK3GJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 01:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVK3GJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 01:09:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:31204 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751077AbVK3GJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 01:09:42 -0500
Date: Wed, 30 Nov 2005 11:39:39 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH & RFC] kdump and stack overflows
Message-ID: <20051130060939.GA3784@in.ibm.com>
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
> >> I believe we have a separate interrupt stack that
> >> should help but..
> > Yes, when using 4K stacks we have a separate interrupt stack that should
> > help, but I am afraid that crash dumping is about being paranoid.
> 
> Oh I agree.  If we had a private 4K stack for the nmi handler we
> would not need to worry about overflow in that case.  (baring
> nmi happening during nmis)  Hmm.  Is there anything to keep
> us doing something bad in that case?
> 

Can a NMI happen inside a NMI? As per Intel software developer manual vol3
(section 5.7.1 Handling multiple NMIs), after occurrence of an NMI, CPU
will not accept next NMI till iret is executed. Then it should not be a
problem. I hope, I understood the problem right.

Thanks
Vivek

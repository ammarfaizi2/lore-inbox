Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVK2Ps0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVK2Ps0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVK2Ps0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:48:26 -0500
Received: from 58x158x20x104.ap58.ftth.ucom.ne.jp ([58.158.20.104]:9945 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751383AbVK2PsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:48:25 -0500
Subject: Re: [PATCH & RFC] kdump and stack overflows
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
In-Reply-To: <m1hd9wfwxi.fsf@ebiederm.dsl.xmission.com>
References: <1133183463.2327.96.camel@localhost.localdomain>
	 <m1lkz8gad7.fsf@ebiederm.dsl.xmission.com>
	 <1133200815.2425.98.camel@localhost.localdomain>
	 <m1hd9wfwxi.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 30 Nov 2005 00:43:32 +0900
Message-Id: <1133279013.2972.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 11:29 -0700, Eric W. Biederman wrote: 
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
That seems to be the cleanest way to solve the problem. I will write a
patch implementing that and see how it works.

> >> I believe we have a separate interrupt stack that
> >> should help but..
> > Yes, when using 4K stacks we have a separate interrupt stack that should
> > help, but I am afraid that crash dumping is about being paranoid.
> 
> Oh I agree.  If we had a private 4K stack for the nmi handler we
> would not need to worry about overflow in that case.  (baring
> nmi happening during nmis)  Hmm.  Is there anything to keep
> us doing something bad in that case?
I think that is a sensible thing to do. I am just back from a day
off, but tomorrow I will take a closer look at this.

Regards,

Fernando


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUD1D3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUD1D3A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 23:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264631AbUD1D3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 23:29:00 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:48069 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264629AbUD1D2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 23:28:35 -0400
In-Reply-To: <1083117450.2152.222.camel@bach>
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com> <1083117450.2152.222.camel@bach>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1EF114FF-98C4-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: pmarques@grupopie.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       malda@slashdot.org, c-d.hailfinger.kernel.2004@gmx.net,
       Linus Torvalds <torvalds@osdl.org>, jon787@tesla.resnet.mtu.edu
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Tue, 27 Apr 2004 23:28:30 -0400
To: Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Rusty,

We generally prefer to focus on making stuff work for users,
rather than waste time arguing about controversial GPL politics.
That's why after the practical workaround was done we moved on
to deal with more acute technical issues at the time and failed
to properly discuss/follow up on the matter with you. Please accept my
sincere personal apology for this.

I would like however to point out that part of the reason why people
sometimes resort to such kludges is that some kernel maintainers have
been rather reluctant to accommodate proprietary drivers which
unfortunately are a necessary real-world evil (Linus told me just a few
days ago that he didn't care and to "go away" after we requested a clean
solution to handle larger kernel stacks for "foreign" NDIS drivers in a 
way
that could perhaps coexist with the new 4K stacks used by default in
recent 2.6.6/fedora kernels).

Anyway, in an effort to reasonably resolve the \0 issue, to (hopefully) 
mutual
satisfaction I propose that we update our drivers to explicitly set the 
tainted
bit manually after they are loaded - perhaps via sysctl() or by running
"echo 1 > /proc/sys/kernel/tainted" via {modules,modprobe}.conf,
or simply changing the '\0' to ' ' in one of the modules' 
MODULE_LICENSE()
macro, causing the kernel to be tainted upon load and the confusing 
messages
to appear once instead of 5-6 times in a row. The latter approach seems
simple and straightforward. Would it be acceptable to you as a 
compromise until
your patch and hopefully something equivalent for 2.4 propagate to 
users?

Regards
Marc

--
Marc Boucher
Linuxant inc.

On Apr 27, 2004, at 9:57 PM, Rusty Russell wrote:

> On Wed, 2004-04-28 at 10:02, Marc Boucher wrote:
>>  In other cases, we have gladly submitted patches when we
>> encountered bugs and
>> could fix them. Had we known that the module fix was so simple, it
>> would of course have been
>> submitted it to you in parallel.
>
> Let me spell it out.
>
> You deceived users by circumventing a check designed to tell them that
> their kernel was tainted.  You deceived maintainers who receive
> "untainted" bug reports.  In a way, you lied directly to the kernel
> community: the module code is our agent in checking module licenses.
>
> That you've been doing it for a while, or that you didn't spend
> significant time investigating alternatives or talking to the 
> maintainer
> about your problem only compounds the damage.  That I know and like you
> only heightens my disappointment.
>
> Hence I stand by my original comment:
>
> 	This shows a lack of integrity that I find personally repulsive.
>
> Hope that clarifies,
> Rusty.
> -- 
> Anyone who quotes me in their signature is an idiot -- Rusty Russell
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUD3WTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUD3WTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUD3WTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:19:40 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:25385 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261680AbUD3WTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:19:39 -0400
Date: Fri, 30 Apr 2004 15:11:38 -0700
From: Paul Jackson <pj@sgi.com>
To: bart@samwel.tk
Cc: miller@techsource.com, vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au,
       jgarzik@pobox.com, akpm@osdl.org, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040430151138.73bb98c9.pj@sgi.com>
In-Reply-To: <1083328293.2204.53.camel@samwel.tk>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<409175CF.9040608@techsource.com>
	<20040429144737.3b0c736b.pj@sgi.com>
	<40917F1E.8040106@techsource.com>
	<20040429154632.4ca07cf9.pj@sgi.com>
	<40918AD2.9060602@techsource.com>
	<1083328293.2204.53.camel@samwel.tk>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thought experiment: what would happen when you set the hypothetical
> cpu-nice and io-nice knobs very differently?

If there was one, single implementation hook in the kernel where making
some decision depend on a user setting cleanly adapted both i/o and cpu
priority, then yes, your thought experiment would recommend that this
one hook was sufficient, and lead to a single user knob to control it.

But in this case, there are obviously two implementation hooks - the
classic one in the scheduler that affects cpu usage, and another off in
some i/o code that affects i/o usage.

So then the question comes - do we have one knob over this that is
ganged to both hooks, or do we have two knobs, one per hook.

Ganging these two hooks together, to control them in synchrony to a
single user setting, is a policy choice.  It's saying that we don't
think you will ever want to run them out of sync, so as a matter of
policy, we are ganging them together.

I prefer to avoid nonessential policy in the kernel.  Best to simply
expose each independent kernel facility, 1-to-1, to the user.  Let
them decide when and if if these two settings should be ganged.

I find gratuitous (not needed for system reliability) policy in the
kernel to be a greater negative than another system call.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

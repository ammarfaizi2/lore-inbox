Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUAUHmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 02:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUAUHmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 02:42:47 -0500
Received: from [66.35.79.110] ([66.35.79.110]:28035 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263697AbUAUHmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 02:42:46 -0500
Date: Tue, 20 Jan 2004 23:42:38 -0800
From: Tim Hockin <thockin@hockin.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: vatsa@in.ibm.com, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040121074238.GB2078@hockin.org>
References: <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au> <20040120084352.GD15733@hockin.org> <20040121093633.A3169@in.ibm.com> <400DFC8B.7020906@cyberone.com.au> <20040121070939.GB31807@hockin.org> <400E2ABA.2060809@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400E2ABA.2060809@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 06:31:06PM +1100, Nick Piggin wrote:
> >If hotplug scripts are failing, you're in really deep trouble.  I can't 
> >find
> >a single case where a hotplug script failing would not indicate some other
> >larger failure.
> >
> 
> sigh. threads-max, pid_max, ulimit, -ENOMEM, oom.

These affect ALL hotplug scripts.  If you can't run a hotplug script because
you've exceeded root's ulimit, or the max # of tasks/threads in the system,
you're in trouble - regardless of what the hotplug event was - SOMETHING is
going to go wrong.

If you get ENOMEM you have a bigger problem.

If you get OOM killed, then the OOM killer has gone haywire (not uncommon,
historically).

> I'd rather not add something that, by design can hang any number of 
> processes
> including the entire system if a hotplug script fails. Thats just my honest
> opinion, I know its rare enough it probably would never happen to anyone.
> 
> Sorry I keep repeating this, its not my call and its never going to affect
> me so I'll shut up now ;)

I'd rather not add anything like that either.  I'm not saying I advocate
fast-and-loose at all.  On the contrary, I think any action taken in
response to a CPU removal needs to be accountable, and wantonly changing
affinity is NOT.

It'll probably not affect me either, nor is it my decision :)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVKWWTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVKWWTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVKWWTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:19:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932583AbVKWWTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:19:40 -0500
Date: Wed, 23 Nov 2005 14:19:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <20051123214835.GA24044@nevyn.them.org>
Message-ID: <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org>
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>
 <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de>
 <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
 <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
 <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
 <20051123214835.GA24044@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Daniel Jacobowitz wrote:
> 
> I don't think I see the point.  This would let you optimize for the
> "multi-threaded, but hasn't created any threads yet" or even
> "multi-threaded, but not right now" cases.  But those really aren't the
> interesting case to optimize for - that's the equivalent of supporting
> CPU hotplug.

NO.

There is not a _single_ compiler that is multi-threaded, and I'd argue 
that there probably never will be. It's pointless.

There's a _lot_ of really performance-sensitive stuff that will NEVER EVER 
be threaded. You may run a hundred copies of them at the same time, but 
every single copy will be single-threaded.

And this will optimize that case in a BIG way.

This is _not_ about "CPU hotplug". This is _not_ about "threaded apps 
before they are threaded". This is all about the fact that serious 
computation is done single-threaded, and anybody who thinks that 
single-threading is going away is so totally out to lunch that it's not 
even fun.

And yes, Sun will die. Single-thread performance matters a hell of a lot, 
and any company that bets that it doesn't, is a failure.

		Linus

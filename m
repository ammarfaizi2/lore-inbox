Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWEVR1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWEVR1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWEVR1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:27:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63364 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750996AbWEVR1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:27:21 -0400
Date: Mon, 22 May 2006 19:27:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, jakub@redhat.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Message-ID: <20060522172710.GA22823@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060522162949.GG30682@devserv.devel.redhat.com> <4471EA60.8080607@vmware.com> <20060522101454.52551222.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522101454.52551222.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Zachary Amsden <zach@vmware.com> wrote:
> >
> > Jakub Jelinek wrote:
> > >
> > > That's known bug in early glibcs short after adding vDSO support.
> > > The vDSO support has been added in May 2003 to CVS glibc (i.e. post glibc
> > > 2.3.2) and the problems have been fixed when they were discovered, in
> > > February 2004:
> > > http://sources.redhat.com/ml/libc-hacker/2004-02/msg00053.html
> > > http://sources.redhat.com/ml/libc-hacker/2004-02/msg00059.html
> > >
> > > I strongly believe we want randomized vDSOs, people are already abusing the
> > > fix mapped vDSO for attacks, and I think the unfortunate 10 months of broken
> > > glibc shouldn't stop that forever.  Anyone using such glibc can still use
> > > vdso=0, or do that just once and upgrade to somewhat more recent glibc.
> > >   
> > 
> > While I'm now inclined to agree with randomization, I think the default 
> > should be off.  You can quite easily "echo 1 > 
> > /proc/sys/kernel/vdso_randomization" in the RC scripts, which allows you 
> > to maintain compatibility for everyone and get randomization turned on 
> > early enough to thwart attacks against any vulnerable daemons.
> > 
> 
> It kinda sucks but yes, that's obviously least-breakage approach.  It 
> does mean that many people won't benefit from (and won't test!) the 
> new feature though.

very much so. Especially for security it's really bad if a feature is 
default-off. I'm quite strongly against such an approach.

> Unless there's some sneaky way of auto-detecting a modern userspace, 
> perhaps (something which mounts /sys?).

i'd rather not overdesign it. And unfortunately there is no good way to 
autodetect it.

> All very sad.

is it really a big problem to add "vdso=0" to the long list of 
requirements you need to run a 2.6 kernel on an old distribution (or to 
disable CONFIG_VDSO)? FC1 wasnt even 2.6-ready, it used a 2.4 kernel!

	Ingo

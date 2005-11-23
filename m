Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVKWSqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVKWSqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVKWSqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:46:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:15500 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932176AbVKWSqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:46:47 -0500
Date: Wed, 23 Nov 2005 19:46:37 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
Message-ID: <20051123184636.GN20775@brahms.suse.de>
References: <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 10:42:40AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 23 Nov 2005, H. Peter Anvin wrote:
> >
> > Linus Torvalds wrote:
> > > What I suggested to Intel at the Developer Days is to have a MSR (or, better
> > > yet, a bit in the page table pointer %cr0) that disables "lock" in _user_
> > > space. Ie a lock would be a no-op when in CPL3, and only with certain
> > > processes.
> > 
> > You mean %cr3, right?
> 
> Yes. 
> 
> It _should_ be fairly easy to do something like that - just a simple 
> global flag that gets set and makes CPL3 ignore lock prefixes. Even timing 
> doesn't matter - it it takes a hundred cycles for the setting to take 
> effect, we don't care, since you can't write %cr3 from user space anyway, 
> and it will certainly take a hundred cycles (and a few serializing 
> instructions) until we get to CPL3.

Another bit for ring 0 would be actually useful too. Then the patching
patch here wouldn't be needed.

-Andi

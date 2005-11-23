Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVKWVOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVKWVOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKWVOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:14:06 -0500
Received: from mx1.suse.de ([195.135.220.2]:62611 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932447AbVKWVOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:14:03 -0500
Date: Wed, 23 Nov 2005 22:13:53 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <20051123211353.GR20775@brahms.suse.de>
References: <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132782245.13095.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:44:05PM +0000, Alan Cox wrote:
> On Mer, 2005-11-23 at 10:42 -0800, Linus Torvalds wrote:
> > Of course, if it's in one of the low 12 bits of %cr3, there would have to 
> > be a "enable this bit" in %cr4 or something. Historically, you could write 
> > any crap in the low bits, I think.
> 
> There is a much much better way to do it than just user space and
> without hitting cr3/cr4 - put "lock works" in the PAT and while we'll
> have to add PAT support which we need to do anyway we would get a world
> where on uniprocessor lock prefix only works on addresse targets we want
> it to - ie pci_alloc_consistent() pages.

The idea was to turn LOCK on only if the process has any
shared writable mapping and num_online_cpus() > 0.

Might be a bit costly to rewrite all the page tables for that case
just to change the PAT index.  A bit is nicer for that.

-Andi

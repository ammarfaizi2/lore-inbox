Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVKXNjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVKXNjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVKXNjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:39:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:11653 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750932AbVKXNjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:39:10 -0500
Date: Thu, 24 Nov 2005 14:39:07 +0100
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124133907.GG20775@brahms.suse.de>
References: <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <20051123165923.GJ20775@brahms.suse.de> <1132783243.13095.17.camel@localhost.localdomain> <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zmnugom7.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I see the source of the confusion.  Scrubbing is the
> process of taking data that is correctable and writing it back to
> memory so that if a second correctable error occurs the net is still
> corrected.

That's supposed to be done by hardware, no? 
At least the K8 has a hardware scrubber (although it's not always enabled)

> Directed killing of processes is something that must be done
> inside a synchronous exception (like a machine check) because otherwise
> it is so racy you don't know who has seen the bad data.  

If you try to do it this way then the code will become such
a mess if not impossible to write that your changes to merge them
and get it right are very slim. The only sane way to do all the locking etc. 
is to hand over the handling to a thread. While that make the window
of misusing the data wider it's the only sane alternative vs not
doing it at all.

Also due to the way hardware works with machine checks usually being
async and not precise works you have that window anyways, so it's 
not even worse. Also consider multiple CPUs.

-Andi

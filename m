Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVHIJW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVHIJW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVHIJW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:22:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39615 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S932479AbVHIJW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:22:59 -0400
Date: Tue, 9 Aug 2005 11:23:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@mbligh.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       zach@vmware.com, torvalds@osdl.org
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <20050809092317.GA20557@elte.hu>
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net> <374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org> <20050808113014.GA15165@elte.hu> <20050808095755.23810b15.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808095755.23810b15.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Furthermore, why should we hamper Xen by going to _any_ sort of 
> > "formalized" hypervisor API, when we dont even know what we want, as Xen 
> > is pretty much work in progress? And whatever Xen support is exported 
> > from the kernel, it should be a _GPL symbol export. We dont want to tie 
> > down things like pagetable format or access methods. It's a very much 
> > kernel-internal thing.
> 
> Well that's the other side of the coin.  I told the vmware guys to GPL 
> their hypervisor to make this issue go away, but that hasn't happened 
> yet ;)
> 
> I think we need to deliberately deal with all this purely at the 
> technical level and to carefully set aside thoughts such as the above.  
> Others would disagree with that.

mine are mostly technical arguments. I just also wanted to vent away 
this slowly gathering false notion of building 'interoperability', while 
the only apparent goal seems to be to maximize benefits to the closed 
hypervisors, while allowing them to not open up their code.

just grep the historic Linux changelogs for contributions from the most 
prominent of these closed-source hypervisors. It's quite close to zero.  
That's what Linux wins from this one-way relationship. Now the action 
was forced by Xen, and it sounds so hypocritical to me to talk about 
'interoperability'. Once the goal of having the APIs to pull even with 
Xen has been achieved, that prominent closed-source hypervisor vendor 
could just as easily go back into 'take from Linux'-only mode, as 
they've done for so many years.

> At the technical level, I do think that the kernel->hypervisor 
> interface is a brand new and *major* kernel interface.  As such, it 
> simply seems good design to put some thought and some formality into 
> it.  If that interface suits more than one paravirtualised hypervisor 
> implementation then that's a sign that it has succeeded.

it just wont be done right first time around. It will be like with all 
the other APIs we had: they went through dozens of major iterations, and 
will go through iterations as the hardware changes and things get 
cleaned up.

And yes, i do believe the Xen hypervisor should eventually live within 
Linux itself. (i.e. Linux should be extended to offer hypervisor 
services. This would enable to share drivers and technologies, etc.) No 
specifications, no formal agreements necessary - just hack away and 
things will be sorted out as they happen.

and no, it's not like with syscalls, for a number of reasons - 
hypervisor/OS-kernel integration is a brand-new thing (at least in the 
OSS space).

> The other design approach is to make this interface purely some 
> xen-private thing which the Xen guys maintain and the rest of us don't 
> worry about much.  That's also a legitimate approach, but my current 
> thinking is that it's technically not as good.  Plus other hypervisor 
> development teams may come along and have to graft their stuff onto 
> the xen-interface-of-the-day, which isn't good.

having a robust API never hurts, no doubt about that - and Xen has 
pretty good hypervisor APIs to begin with. But there is no connection 
between formality and a technological sound API - you can have a crap 
formal API just as much as you can have a good non-formal API. (e.g. the 
current Linux device driver APIs are good non-formal APIs)

in fact, history has shown that formality often _hurts_ the 
technological soundness of an API, mostly due to the inflebility and the 
inherent lag inserted between design and implementation.

Formalizing an API if Xen asks for it is OK in my book, but formalizing 
an API mostly for the sake of bin-only virtualization, under the 
pretense of 'interoperability' sounds pretty backwards to me.

	Ingo

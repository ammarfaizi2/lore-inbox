Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWHHCtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWHHCtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWHHCtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:49:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37079 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751215AbWHHCtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:49:13 -0400
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060807194159.f7c741b5.akpm@osdl.org>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	 <m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
	 <20060807165512.dabefb63.akpm@osdl.org> <200608080417.59462.ak@suse.de>
	 <20060807194159.f7c741b5.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 08 Aug 2006 04:47:49 +0200
Message-Id: <1155005284.3042.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 19:41 -0700, Andrew Morton wrote:
> On Tue, 8 Aug 2006 04:17:59 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > 
> > > 
> > > And it's a pretty nasty one because it can get people into the situation
> > > where the kernel worked fine for those who released it, but users who
> > > happen to load more modules (or the right combination of them) will
> > > experience per-cpu memory exhaustion.
> > 
> > Yes, and a high value will waste a lot of memory for normal users.
> >  
> > > So shouldn't we being scaling the per-cpu memory as well?
> > 
> > If we move it into vmalloc space it would be easy to extend at runtime - just the
> > virtual address space would need to be prereserved, but then more pages
> > could be mapped. Maybe we should just do that instead of continuing to kludge around?
> 
> Sounds sane.
> 
> otoh, we need something for 2.6.19.
> 
> > Drawback would be some more TLB misses.
> 
> yup.  On some (important) architectures - I'm not sure which architectures
> do the bigpage-for-kernel trick.

also most of the architectures that do bigpage-for-kernel stuff only
have a very limited number of tlb entries for bigpages (usually 2 to 4)
while they have many more entries for normal pages.. so it's not
automatically worse (now if these data structures are close to the
kernel text or so.. then yes there's sharing. but with the sorting of
kernel text that's a lot less true already)




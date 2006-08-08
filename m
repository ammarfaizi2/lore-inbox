Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWHHCmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWHHCmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWHHCmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:42:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751211AbWHHCmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:42:06 -0400
Date: Mon, 7 Aug 2006 19:41:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Message-Id: <20060807194159.f7c741b5.akpm@osdl.org>
In-Reply-To: <200608080417.59462.ak@suse.de>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
	<20060807165512.dabefb63.akpm@osdl.org>
	<200608080417.59462.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 04:17:59 +0200
Andi Kleen <ak@suse.de> wrote:

> 
> > 
> > And it's a pretty nasty one because it can get people into the situation
> > where the kernel worked fine for those who released it, but users who
> > happen to load more modules (or the right combination of them) will
> > experience per-cpu memory exhaustion.
> 
> Yes, and a high value will waste a lot of memory for normal users.
>  
> > So shouldn't we being scaling the per-cpu memory as well?
> 
> If we move it into vmalloc space it would be easy to extend at runtime - just the
> virtual address space would need to be prereserved, but then more pages
> could be mapped. Maybe we should just do that instead of continuing to kludge around?

Sounds sane.

otoh, we need something for 2.6.19.

> Drawback would be some more TLB misses.

yup.  On some (important) architectures - I'm not sure which architectures
do the bigpage-for-kernel trick.

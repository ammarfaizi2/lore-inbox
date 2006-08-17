Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWHQOsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWHQOsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWHQOsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:48:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:34800 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965084AbWHQOse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:48:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A6ZG+wY6gnUB3xbmJ/j0VPfGUeR6zg08BUzXMVt1RFQgkRddTfWM1PRvsi0Na4pfgypjueCwErqa0H8M9ZRLFZBen4vxPwnMCDNRStQCBOWNI2FZjtkvBqNZKNmITwVnTY4hgHbJrXp9q1uUezTephNflWYTjodHaim4O9Ey4kk=
Message-ID: <6bffcb0e0608170748v332cc93cv3f1b79c45800d20d@mail.gmail.com>
Date: Thu, 17 Aug 2006 16:48:29 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <6bffcb0e0608170745s8145df4ya4e946c76ab83c1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
	 <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
	 <6bffcb0e0608130726x8fc1c0v7717165a63391e80@mail.gmail.com>
	 <b0943d9e0608170602v13dea49bgf64dbf17b7a52273@mail.gmail.com>
	 <6bffcb0e0608170745s8145df4ya4e946c76ab83c1b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi Catalin,
>
> On 17/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > On 13/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > It's kmemleak 0.9 issue. I have tested kmemleak 0.8 on 2.6.18-rc1and
> > > 2.6.18-rc2. I haven't seen this before.
> >
> > it looks like it was caused by commit
> > fc818301a8a39fedd7f0a71f878f29130c72193d where free_block() now calls
> > slab_destroy() with l3->list_lock held.
>
> I'll revert this commit.
>
> >
> > The prio_tree use (which doesn't alloc memory) instead of the
> > radix_tree is about 4 times slower when scanning the memory and I
> > don't think I'll use it.
> >
> > It leaves me with the options of either implementing my own memory
> > allocator based on pages

[MODSLAB 7/7] A slab allocator: Page Slab allocator
"The page slab is a specialized slab allocator that can only handle
page order size object. It directly uses the page allocator to
track the objects and can therefore avoid the overhead of the
slabifier."
http://www.ussg.iu.edu/hypermail/linux/kernel/0608.1/3023.html

>(including a simple hash table instead of
> > radix tree) or fix the locking in kmemleak so that memory allocations
> > happen without memleak_lock held. The latter is a bit complicated as
> > well since any slab allocation causes a re-entrance into kmemleak.
> >
> > Any other suggestions?
>
> Please talk with Christoph Lameter, he is working on Modular Slab.
> http://www.ussg.iu.edu/hypermail/linux/kernel/0608.1/0951.html
> http://www.ussg.iu.edu/hypermail/linux/kernel/0608.2/0030.html
> Maybe he can help with this problem.
>
> >
> > Thanks.
> >
> > --
> > Catalin
> >

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

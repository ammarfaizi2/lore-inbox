Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSHPCgM>; Thu, 15 Aug 2002 22:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSHPCgM>; Thu, 15 Aug 2002 22:36:12 -0400
Received: from [195.223.140.120] ([195.223.140.120]:22612 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318060AbSHPCgL>; Thu, 15 Aug 2002 22:36:11 -0400
Date: Fri, 16 Aug 2002 04:40:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816024035.GL14394@dualathlon.random>
References: <20020815220054.J29874@redhat.com> <Pine.LNX.4.44.0208151905500.1271-100000@home.transmeta.com> <20020815221647.M29874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020815221647.M29874@redhat.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 10:16:47PM -0400, Benjamin LaHaise wrote:
> On Thu, Aug 15, 2002 at 07:08:30PM -0700, Linus Torvalds wrote:
> > 
> > On Thu, 15 Aug 2002, Benjamin LaHaise wrote:
> > > 
> > > A 4G/4G split flushes the TLB on every syscall.
> > 
> > This is just not going to happen. It will have to continue being a 3/1G 
> > split, and we'll just either find a way to move stuff to highmem and 
> > shrink the "struct page", or we'll just say "screw those 16GB+ machines on 
> > x86". 
> 
> I wish life were that simple.  Unfortunately, struct page isn't the only 
> problem with these abominations: the system can run out of kvm for 
> vm_area_struct, task_struct, files...  Personally, I *never* want to see 
> those data structures being kmap()'d as it would hurt kernel code quality 
> whereas a 4G/4G split is well confined, albeit sickening.

after the mem_map is gone, there's still the option of CONFIG_2G or even
CONFIG_1G if kernel metadata is the problem. Of course it wouldn't be
a generic kernel, but I guess a 4G/4G would probably be even less
generic.  In short we can do little at runtime to be generic. I guess a
16G with large softpagesize should be not too bad now that the
pagetables are in highmem, most problematic is >16G. Not that the
softpagesize is easy at all to implement (4G/4G is certainly simpler
because self contained in the include/arch) but at least it can payoff
for the lower mem setups too.

Andrea

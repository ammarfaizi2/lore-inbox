Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318036AbSHPCMw>; Thu, 15 Aug 2002 22:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSHPCMw>; Thu, 15 Aug 2002 22:12:52 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:45307 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318036AbSHPCMv>; Thu, 15 Aug 2002 22:12:51 -0400
Date: Thu, 15 Aug 2002 22:16:47 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020815221647.M29874@redhat.com>
References: <20020815220054.J29874@redhat.com> <Pine.LNX.4.44.0208151905500.1271-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208151905500.1271-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Aug 15, 2002 at 07:08:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 07:08:30PM -0700, Linus Torvalds wrote:
> 
> On Thu, 15 Aug 2002, Benjamin LaHaise wrote:
> > 
> > A 4G/4G split flushes the TLB on every syscall.
> 
> This is just not going to happen. It will have to continue being a 3/1G 
> split, and we'll just either find a way to move stuff to highmem and 
> shrink the "struct page", or we'll just say "screw those 16GB+ machines on 
> x86". 

I wish life were that simple.  Unfortunately, struct page isn't the only 
problem with these abominations: the system can run out of kvm for 
vm_area_struct, task_struct, files...  Personally, I *never* want to see 
those data structures being kmap()'d as it would hurt kernel code quality 
whereas a 4G/4G split is well confined, albeit sickening.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

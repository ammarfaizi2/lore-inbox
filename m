Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSG3S2W>; Tue, 30 Jul 2002 14:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSG3S2W>; Tue, 30 Jul 2002 14:28:22 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:55293 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S310190AbSG3S2W>; Tue, 30 Jul 2002 14:28:22 -0400
Date: Tue, 30 Jul 2002 14:31:46 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Dike <jdike@karaya.com>, Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730143146.G10315@redhat.com>
References: <20020730140939.F10315@redhat.com> <Pine.LNX.4.33.0207301114001.2534-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0207301114001.2534-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jul 30, 2002 at 11:15:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 11:15:26AM -0700, Linus Torvalds wrote:
> That still doesn't get the TLB advantages of a globally shared page at the
> same address.. It also has the overhead of mapping it, which you don't
> have if the thing is just always in the address space, and all processes
> just get created with that page mapped. That can be a big deal for process
> startup latency for small processes.

That might be a concern once glibc startup can occur with less than a few 
dozen calls to grope through the local files. ;-)  Hmmm, it would be possible 
to make the vsyscall page mapped by default and leave the global bit enabled 
until UML forcibly unmapped it (and then clear the global bit and do a global 
invalidate).  Would that be acceptible?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

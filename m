Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSHPBia>; Thu, 15 Aug 2002 21:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSHPBia>; Thu, 15 Aug 2002 21:38:30 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:39159 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317859AbSHPBi3>; Thu, 15 Aug 2002 21:38:29 -0400
Date: Thu, 15 Aug 2002 21:42:25 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020815214225.H29874@redhat.com>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020815235459.GG14394@dualathlon.random>; from andrea@suse.de on Fri, Aug 16, 2002 at 01:54:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 01:54:59AM +0200, Andrea Arcangeli wrote:
> the window a kernel window inside a preempt_disable and a __cli() will
> have a goodness effect in a number of cases, but I don't think it
> matters significantly because you still need some gettimeofday in
> userspace (or clock_gettime if that matters, clock_gettime infact is
> even worse than gettimeofday due its certainly lower resolution).

Yeah, I've come full circle back to the relative timeout point of view.  
By grabbing a copy of jiffies at the beginning of the function the race 
with preempt can be avoided.

> Now reading the SuS specifications I also like less and less our current
> kernel API of this sumbit_io, the SuS does exactly what I suggested
> originally that is aio_read/aio_write/aio_fsync as separate calls. So
> the merging effect mentioned by Ben cannot be taken advantage of by the
> kernel anyways because userspace will issue separate calls for each
> command.

Read it again.  You've totally missed lio_listio.  Also keep in mind what 
happens with 4G/4G split for x86 which are needed to address the kernel 
virtual memory starvation issues.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314743AbSEPVkz>; Thu, 16 May 2002 17:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314755AbSEPVky>; Thu, 16 May 2002 17:40:54 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:9688 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S314743AbSEPVkx>; Thu, 16 May 2002 17:40:53 -0400
Message-Id: <200205162140.g4GLelw01400@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Thu, 16 May 2002 14:40:24 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Daniel Jacobowitz <dan@debian.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E178SrT-00057L-00@the-village.bc.nu> <1021584279.914.4.camel@sinai>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 May 2002 05:24 pm, Robert Love wrote:
> On Thu, 2002-05-16 at 14:32, Alan Cox wrote:
> > > For this to happen that semaphore would have to held across
> > > schedule()'s. The ONLY place I've seen that in the kernel is
> > > set_CPUs_allowed + migration_thread.
> >
> > The 2.5 kernel is pre-emptible.
>
> Indeed :)
>
> But there is plenty of places in the kernel - sans preemption - where we
> sleep while holding a semaphore.  Was that the original question?  If
> so, set_cpus_allowed by be one of the few _explicit_ places but we
> implicitly sleep holding a semaphore all over.  Heck, we use them for
> user-space synchronization.
>
> 	Robert Love
>

The original question was:
Couldn't the TCore patch deadlock in elf_core_dump on a semiphore held by a 
sleeping process that gets placed onto the phantom runque?

So far I can't tell the problem is real or not, but I'm worried :(

I haven't hit any such deadlocks in my stress testing, such as it is.  In my 
review of the code I don't see any obviouse problems dispite the fact that 
the mmap_sem is explicitly grabbed by elf_core_dump.

--mgross

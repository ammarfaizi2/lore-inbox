Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310577AbSCPUNB>; Sat, 16 Mar 2002 15:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310576AbSCPUMx>; Sat, 16 Mar 2002 15:12:53 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:15116 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310570AbSCPUMn>;
	Sat, 16 Mar 2002 15:12:43 -0500
Date: Sat, 16 Mar 2002 13:12:19 -0700
From: yodaiken@fsmlabs.com
To: Andi Kleen <ak@suse.de>
Cc: yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316131219.C20436@hq.fsmlabs.com>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel> <20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel> <p73g0301f79.fsf@oldwotan.suse.de> <20020316125711.B20436@hq.fsmlabs.com> <20020316210504.A24097@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020316210504.A24097@wotan.suse.de>; from ak@suse.de on Sat, Mar 16, 2002 at 09:05:04PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 09:05:04PM +0100, Andi Kleen wrote:
> On Sat, Mar 16, 2002 at 12:57:11PM -0700, yodaiken@fsmlabs.com wrote:
> > On Sat, Mar 16, 2002 at 08:32:26PM +0100, Andi Kleen wrote:
> > > x86-64 aka AMD Hammer does hardware (or more likely microcode) search of 
> > > page tables.
> > > It has a 4 level page table with 4K pages. Generic Linux MM code only sees
> > > the first slot in 4th level page limit user space to 512GB with 3 levels. 
> > 
> > What about 2M pages?
> 
> They are not supported for user space, but used in private mappings
> for kernel text and direct memory mappings. Generic code never sees them.
> 
> That will hopefully change eventually because 2M pages are a bit help for
> a lot of applications that are limited by TLB thrashing, but needs some 
> thinking on how to avoid the fragmentation trap (e.g. I'm considering
> to add a highmem zone again just for that and use rmap with targetted
> physical freeing to allocating them) 

To me, once you have a G of memory, wasting a few meg on unused process 
memory seems no big deal.

> > There was something in some AMD doc about preventing tlbflush on process
> > switch - through a context like thing perhaps? Any idea?
> 
> There are global pages which are normally not flushed over context switch.
> That is used for all kernel mappings. 
> 
> There is also some optimization in the CPU that tries to do a selective
> flush only when you reload CR3, but as far as I can see doesn't help
> for the Linux context switch. It only works around broken TLB flushing
> algorithms in some Windows version.

They say:
	Hammer microarchitecture features a flush filter allowing multiple
	processes to share TLB without SW intervention.

Not a lot of technical detail in that.

> 
> -Andi

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSJ1UbX>; Mon, 28 Oct 2002 15:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSJ1UbX>; Mon, 28 Oct 2002 15:31:23 -0500
Received: from bozo.vmware.com ([65.113.40.131]:52746 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261323AbSJ1UbW>; Mon, 28 Oct 2002 15:31:22 -0500
Date: Mon, 28 Oct 2002 12:38:53 -0800
From: chrisl@vmware.com
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021028203853.GD1564@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <3DB990FE.A1B8956@digeo.com> <20021028191745.GA1564@vmware.com> <3DBD95B8.321C4D6E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBD95B8.321C4D6E@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 11:53:28AM -0800, Andrew Morton wrote:
> chrisl@vmware.com wrote:
> > 
> > On Fri, Oct 25, 2002 at 11:44:14AM -0700, Andrew Morton wrote:
> > > chrisl@vmware.com wrote:
> > > >
> > > > bigmm -i 3 -t 2 -c 1024
> > >
> > > That's a nice little box killer you have there.
> > 
> 
> I tested Andrea's latest kernel.  It survived.

great. I can try the hundred-win2k-vm test on linux some day and
see what happen. 

> 
> Probably because it left 100 megabytes of lowmem unallocated
> throughout the test.
> 
> > >
> > > With mem=4G, running bigmm -i 5 -t 2 -c 1024:
> > >
> > > 2.4.19: Ran for a few minutes, got slower and slower and
> > > eventually stopped.  kupdate had taken 30 seconds CPU and
> > > all CPUs were spinning in shrink_cache().  Had to reset.
> > >
> > > 2.4.20-pre8-ac1: Ran for a minute, froze up for a couple of
> > > minutes then recovered and remained comfortable.
> > 
> > How many instance of bigmm left there? It should be 10 bigmm
> > processes before oom kickin.
> 
> Well, they should all be left running?  All this memory has
> file-backing, and is easily reclaimable.

In my experiment, if some bigmm get killed by oom killer.

> 
> umm, yes.  There could be bogus oom-killings in the combined-LRU
> VMs.  But I saw none in testing.
> 
> 
> 
> All of which is great fun, but it leaves open the question "what
> the heck can vmware do about it". I wish there was a clear answer.

We told them to dump the ram file at /dev/shm and prepare a large
swap space. And be gentle to linux, don't push vm's total ram
beyond what is on the machine. It is running OK so far.

We did try to recomment some SuSE or Redhat new kernel. It did not
work at that time. But I am not surprised at all, it is something
like 2.4.7 based. We have this problem on linux for some time now.

> 
> If the customer is running a suse/UL kernel they're presumably OK.
> 
> If their kernel comes from kernel.org they should add Andrea's patch.
> Which means they get an absolute boatload of stuff which they may
> not want:
>  1223 files changed, 306053 insertions(+), 9655 deletions(-)
> but that kernel performs well.

Patch kernel and ask them to build kernel is not an option at all.
They just want something reliable. They trust most major linux
distribution's kenrel just don't home make one.

> 
> If they're running an RH-rmap kernel then they're probably okayish,
> although I'd recommend more testing there.

That I don't know.

> 
> If they're running an RHAS-style kernel then I do not know.  It may
> fail.

Chris



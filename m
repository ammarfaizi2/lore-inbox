Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbRGLVw0>; Thu, 12 Jul 2001 17:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266780AbRGLVwS>; Thu, 12 Jul 2001 17:52:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31753 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266750AbRGLVwL>; Thu, 12 Jul 2001 17:52:11 -0400
Date: Thu, 12 Jul 2001 17:20:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dirk Wetter <dirkw@rentec.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: dead mem walking ;-) 
In-Reply-To: <Pine.LNX.4.33.0107121719590.2326-100000@monster000.rentec.com>
Message-ID: <Pine.LNX.4.21.0107121717120.2582-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Jul 2001, Dirk Wetter wrote:

> 
> 
> Hi guys,
> 
> On Thu, 12 Jul 2001, Mike Galbraith wrote:
> 
> > > > Have you had a chance to try 2.4.7-pre-latest yet?  I'd be interested
> > > > in a small sample of vmstat 1 leading into heavy swap with >=pre5 if
> > > > it is still a problem.
> > >
> > > i will definetely check it out and give a report, since the test i did
> > > yesterday the *command* "vmstat 1" in typed in appeared to be :)) more
> > > like "vmstat 180", no kidding.
> >
> > Ok, you have some 'io bound' issues that need to be looked at.  Present
> > the data in that light please.
> 
> so here is result of my testing: the scenario: vanilla kernel
> 2.4.6, config is CONFIG_HIGHMEM4G=y, it's a dual intel box with 4GB
> mem.  the machine was freshly booted before the test with profile=2
> (more detailed data is av. @ www.desy.de/~dirkw/linux-kernel/ )
> 
> 
> 
> a while before the jobs were submitted i did "readprofile | sort -nr | head -10":
> 296497 total                                      0.3442
> 295348 default_idle                             5679.7692
>    300 __rdtsc_delay                             10.7143
>    215 si_swapinfo                                1.2500
>    138 do_softirq                                 1.0147
>    107 printk                                     0.2816
>     28 do_wp_page                                 0.0272
>     17 schedule                                   0.0117
>     10 tcp_get_info                               0.0077
>     10 filemap_nopage                             0.0073
> 
> the same after i was able to kill the jobs (see below):
> 
> 836552 total                                      0.9710
> 458757 default_idle                             8822.2500
> 361961 __get_swap_page                          665.3695
>   6629 si_swapinfo                               38.5407
>   1655 do_anonymous_page                          5.3734
>    760 file_read_actor                            3.0645
>    652 statm_pgd_range                            1.6633
>    592 do_softirq                                 4.3529
>    498 skb_copy_bits                              0.5845
>    302 __rdtsc_delay                             10.7857


Ok, I've seen that before. __get_swap_page() is horribly innefficient.

The system is _not_ swaping out data, though. Its just aging the 
pte's and allocating swap. 

And that is what is eating the system performance.

<snip>

Can you please show us the output of /proc/meminfo when the system is
behaving badly ? 


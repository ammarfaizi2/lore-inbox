Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266883AbRGLWLg>; Thu, 12 Jul 2001 18:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266902AbRGLWL0>; Thu, 12 Jul 2001 18:11:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37899 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266883AbRGLWLN>; Thu, 12 Jul 2001 18:11:13 -0400
Date: Thu, 12 Jul 2001 17:39:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dirk Wetter <dirkw@rentec.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: dead mem walking ;-) 
In-Reply-To: <Pine.LNX.4.33.0107121753321.2326-100000@monster000.rentec.com>
Message-ID: <Pine.LNX.4.21.0107121730190.2582-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Jul 2001, Dirk Wetter wrote:

> On Thu, 12 Jul 2001, Marcelo Tosatti wrote:
> 
> 
> > > a while before the jobs were submitted i did "readprofile | sort -nr | head -10":
> > > 296497 total                                      0.3442
> > > 295348 default_idle                             5679.7692
> > >    300 __rdtsc_delay                             10.7143
> > >    215 si_swapinfo                                1.2500
> > >    138 do_softirq                                 1.0147
> > >    107 printk                                     0.2816
> > >     28 do_wp_page                                 0.0272
> > >     17 schedule                                   0.0117
> > >     10 tcp_get_info                               0.0077
> > >     10 filemap_nopage                             0.0073
> > >
> > > the same after i was able to kill the jobs (see below):
> > >
> > > 836552 total                                      0.9710
> > > 458757 default_idle                             8822.2500
> > > 361961 __get_swap_page                          665.3695
> > >   6629 si_swapinfo                               38.5407
> > >   1655 do_anonymous_page                          5.3734
> > >    760 file_read_actor                            3.0645
> > >    652 statm_pgd_range                            1.6633
> > >    592 do_softirq                                 4.3529
> > >    498 skb_copy_bits                              0.5845
> > >    302 __rdtsc_delay                             10.7857
> >
> >
> > Ok, I've seen that before. __get_swap_page() is horribly innefficient.
> 
> :-(
> 
> > The system is _not_ swaping out data, though. Its just aging the
> > pte's and allocating swap.
> 
> with that jobs it looks to me that swap allocation shouldn't be
> neccessary? total of all pages should have been below the physcial mem
> size.

Well, the kernel tries to keep a given amount of pages in a "deactivated"
state (deactivated = ready-to-free) so it can keep a low amount of actual
free pages (amongs other benefits). 

Anonymous pages (from your processes) need their space _allocated_ on swap
before they can be aged and possibly written out to swap and freed later.

If you look at the "inactive_target" field on /proc/meminfo you will see
how much data the kernel is trying to keep deactivated. 

> > And that is what is eating the system performance.
> 
> does it bring up the load up to 30 and make the machine unusable?
> (kswapd was also sometimes in the top-list of CPU hogs, but since i
> sorted it by memory...)

Yes. Obviously that should not happen. 

What you're seeing _is_ a problem.

> > <snip>
> >
> > Can you please show us the output of /proc/meminfo when the system is
> > behaving badly ?
> 
> hold on, we set s.th. up....

Ok, thanks. 


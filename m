Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313764AbSDHVgw>; Mon, 8 Apr 2002 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313765AbSDHVgv>; Mon, 8 Apr 2002 17:36:51 -0400
Received: from mailg.telia.com ([194.22.194.26]:44514 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S313764AbSDHVgt>;
	Mon, 8 Apr 2002 17:36:49 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Anssi Saari <as@sci.fi>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Date: Mon, 8 Apr 2002 23:32:09 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020408154732.GA10271@sci.fi> <Pine.LNX.3.96.1020408133036.22155A-100000@gatekeeper.tmr.com> <20020408190612.GA19419@sci.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204082332.09302.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tested with my computer - the CD-R:s that I had
limited the testing to 10x. But when testing
that it indicated 33% CPU in system, but not accouted
to any process by top.

I have done some profiling with my kernel
2.4.17-rmap12f
I think this indicates that the time spent for this kernel is
IRQ happening during idle time - correct?

I am not sure that this is the same situation that Anssi has
but 33% are quite a lot (more than he got, DMAs are enabled).
But at least it is another comparative datapoint...

/RogerL

--- output from readprofile (>=3) ------------------
     3 __aux_write_ack                            0.0938
     3 kmalloc                                    0.0115
     3 pipe_poll                                  0.0300
     3 sys_select                                 0.0026
     4 add_wait_queue                             0.1000
     4 link_path_walk                             0.0021
     4 rest_init                                  0.1000
     4 rmqueue                                    0.0059
     4 tasklet_action                             0.0303
     4 timer_bh                                   0.0066
     5 __free_pages_ok                            0.0068
     5 sock_poll                                  0.1250
     6 __rdtsc_delay                              0.2143
     6 __switch_to                                0.0326
     6 __wake_up                                  0.0375
     6 kfree                                      0.0405
     7 fget                                       0.1750
     7 poll_freewait                              0.1029
     7 sys_write                                  0.0357
     8 unix_poll                                  0.0541
     9 schedule                                   0.0110
    11 do_softirq                                 0.0671
    12 do_anonymous_page                          0.0517
    12 do_select                                  0.0252
    23 handle_IRQ_event                           0.2614
    24 file_read_actor                            0.1765
  5960 ide_intr                                  17.7381
 36056 default_idle                             901.4000
 42283 total                                      0.0418


On måndagen den 8 april 2002 21.06, Anssi Saari wrote:
> On Mon, Apr 08, 2002 at 01:35:35PM -0400, Bill Davidsen wrote:
> >   Okay, this is good information. At the risk of asking a dumb question,
> > are you sure that both the burner and the source drive ar using DMA?
>
> I'm fairly certain. I can read that test image at ~37MB/s and 35% CPU,
> which can't be PIO. The CD writer reads at ~3.7MB/s and 3% CPU usage.
>
> > that they are on separate cables (controllers)?
>
> Yes. Two HDs, one writer, all on different channels. The other HD is on
> the motherboards Promise 20265 "raid" controller.
>
> >   This would be a good question for the CD writing list,
> > cdwrite@other.debian.org.
>
> I tried that some time ago. So far, this is a sort of repetition of
> that. Joerg Schilling suggested that maybe I don't have DMA on or the
> reader and writer are on the same cable. Other discussion was off topic...
>
> In fact, I've also had this conversation from the other point of view
> with someone else, who  was asking about this same problem in the finnish
> Linux group, sfnet.atk.linux. Now I have the same LG CD writer, the same
> VIA KT133A chipset, the same problem and the same discussion... I'd be
> amused if the problem weren't still unresolved.
>
> I decided to post here after I tried FreeBSD, didn't have a problem
> and thus it seemed likely that this is a Linux specific problem.
>
> I think I'll try to put together another system and see what happens
> there. I wonder if SGI's kernprof thing would be useful with this.
> I'll try that too, when I have the time.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Roger Larsson
Skellefteå
Sweden


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288323AbSAHU4g>; Tue, 8 Jan 2002 15:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288333AbSAHU4S>; Tue, 8 Jan 2002 15:56:18 -0500
Received: from dsl-213-023-038-231.arcor-ip.net ([213.23.38.231]:58890 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288323AbSAHU4E>;
	Tue, 8 Jan 2002 15:56:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 21:59:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16Nxjg-00009W-00@starship.berlin> <3C3B4CB7.FEAAF5FC@zip.com.au>
In-Reply-To: <3C3B4CB7.FEAAF5FC@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16O3L5-0000B8-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 08:47 pm, Andrew Morton wrote:
> Daniel Phillips wrote:
> > What a preemptible kernel can do that a non-preemptible kernel can't is:
> > reschedule exactly as often as necessary, instead of having lots of extra
> > schedule points inserted all over the place, firing when *they* think the
> > time is right, which may well be earlier than necessary.
> 
> Nope.  `if (current->need_resched)' -> the time is right (beyond right,
> actually).

Oops, sorry, right.

The preemptible kernel can reschedule, on average, sooner than the 
scheduling-point kernel, which has to wait for a scheduling point to roll 
around.

And while I'm enumerating differences, the preemptable kernel (in this 
incarnation) has a slight per-spinlock cost, while the non-preemptable kernel 
has the fixed cost of checking for rescheduling, at intervals throughout all 
'interesting' kernel code, essentially all long-running loops.  But by clever 
coding it's possible to finesse away almost all the overhead of those loop 
checks, so in the end, the non-preemptible low-latency patch has a slight 
efficiency advantage here, with emphasis on 'slight'.

--
Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUCaNyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 08:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUCaNyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 08:54:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:33412 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261474AbUCaNyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 08:54:31 -0500
Date: Wed, 31 Mar 2004 08:53:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Ben Greear <greearb@candelatech.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() version 2.4.24
In-Reply-To: <Pine.LNX.4.53.0403301526100.7833@chaos>
Message-ID: <Pine.LNX.4.53.0403310846290.10546@chaos>
References: <Pine.LNX.4.53.0403301138260.6967@chaos> <4069AED1.4020102@nortelnetworks.com>
 <4069B3CC.1040904@candelatech.com> <200403302140.05820.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.53.0403301526100.7833@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Richard B. Johnson wrote:

> On Tue, 30 Mar 2004, Denis Vlasenko wrote:
>
> > On Tuesday 30 March 2004 19:52, Ben Greear wrote:
> > > Chris Friesen wrote:
> > > > The cpu util accounting code in kernel/timer.c hasn't changed in 2.4
> > > > since 2002.  Must be somewhere else.
> > > >
> > > > Anyone else have any ideas?
> > >
> > > As another sample point, I have fired up about 100 processes with
> > > each process having 10+ threads.  On my dual-xeon, I see maybe 15
> > > processes shown as 99% CPU in 'top'.  System load was near 25
> > > when I was looking, but the machine was still quite responsive.
> >
> > There was a top bug with exactly this symptom. Fixed.
> > I use procps-2.0.18.
> >
> Wonderful!  Now, where do I find the sources now that RedHat has
> gone "commercial" and is keeping everything secret?
>
> I followed the http://sources.redhat.com/procps/  instructions
> __exactly__ and get this:
>
> Script started on Tue Mar 30 15:27:02 2004
> quark:/home/johnson/foo[1] cvs -d :pserver:anoncvs@sources.redhat.com:/procps login anoncvs
> Logging in to :pserver:anoncvs@sources.redhat.com:2401/procps
> CVS password:
> /procps: no such repository
> quark:/home/johnson/foo[2] exit
> Script done on Tue Mar 30 15:28:32 2004
>

The RedHat server was apparently broken yesterday. There were many
persons who tried to get the source. Eventually Burton Windle
sent me a copy of the source, that he had previously acquired,
after he tried to access it also.

I compiled the source and the problem persists. Any task that
executes sched_yield() will get "charged" for the time that it
has given away. This is not correct. Maybe it is not correctable,
but it is still not correct. In addition to it being "unfair",
it messes up the totals because tasks that are using the CPU time
given up, also get charged.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



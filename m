Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbVKBA3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbVKBA3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVKBA3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:29:42 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:39763 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751478AbVKBA3l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:29:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HvSR2J98pkp25TM58MjREqffH5unjxbeYXP3nwS6sJrJYHAg1Yk/2pyugGarDVttXIyZCEjYFl2aRoeNg/yGoIuzWlgcqbtq4lslftOYjDjFoYJd/xWM8o26PpvINnqs9idia7TsC1WMj/PYRzZBD1C0oLO3BhNKG1+cNHz/n/0=
Message-ID: <cb2ad8b50511011629g3e5c4b41t82c1763b029acae2@mail.gmail.com>
Date: Tue, 1 Nov 2005 19:29:40 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Realtime-preempt performs worse for many threads?
Cc: Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <cb2ad8b50511011553x57ff9e4dv7f49875cf8a5d7e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cb2ad8b50511011202l5bdc8c82se145adf158221e28@mail.gmail.com>
	 <Pine.OSF.4.05.10511020010590.29420-100000@da410.phys.au.dk>
	 <cb2ad8b50511011553x57ff9e4dv7f49875cf8a5d7e0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Carlos Antunes <cmantunes@gmail.com> wrote:
> On 11/1/05, Esben Nielsen <simlo@phys.au.dk> wrote:
> > On Tue, 1 Nov 2005, Carlos Antunes wrote:
> >
> > > Hi!
> > >
> > > I've been developing some code for the OpenPBX project
> > > (http://www.openpbx.org) and wrote a program to test how the system,
> > > responds when hundreds of threads are spawned. These threads run at
> > > high priority (SCHED_FIFO) and use clock_nanocleep with absolute
> > > timeouts on a 20ms loop cycle.
> > >
> > > With the stock 2.6.14 kernel, I get latencies in the order of several
> > > milliseconds (but less than 20ms) when running 1250 threads
> > > simultaneously. However, when I switch to a kernel patched with
> > > realtime-preempt latency increases to several hundred milliseconds in
> > > many cases.
> >
> > There is only one explanation:
> > Some of the operations (task switch, nanosleep etc.) are more expensive in
> > the RT kernel. Thus your 1250 threads spend 100% CPU doing what they do.
> > You therefore get very bad latencies.
> >
>
> Esben,
>
> Thanks for replying. Let me chalenge this assumption of yours, though.
>
> I just ran a test with those 1250 threads (all they do is sleep for
> 20ms, wake up, increment a number, and repeat the process). The CPU
> was 86% *IDLE* while running this. One thread took 1.3 seconds to wake
> up once. Do you think this is, well, normal, given how RT is supposed
> to operate?
>

Esben,

If, instead of SCHD_FIFO, I use SCHED_OTHER, I get max latency in the
order 13ms running those 1250 threads. With SCHED_FIFO (the only
change), I get 1.3 seconds. Makes sense to you?

Thanks!

Carlos

--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson

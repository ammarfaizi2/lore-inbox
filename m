Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVF3Abl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVF3Abl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVF3Abk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:31:40 -0400
Received: from unused.mind.net ([69.9.134.98]:24260 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262758AbVF3AbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:31:13 -0400
Date: Wed, 29 Jun 2005 17:29:31 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050629125409.GA29188@elte.hu>
Message-ID: <Pine.LNX.4.58.0506291728490.16060@echo.lysdexia.org>
References: <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org>
 <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu>
 <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org> <20050625041453.GC6981@elte.hu>
 <Pine.LNX.4.58.0506262102250.32435@echo.lysdexia.org> <20050627081542.GA15096@elte.hu>
 <Pine.LNX.4.58.0506272001190.5720@echo.lysdexia.org> <20050628081053.GC7368@elte.hu>
 <Pine.LNX.4.58.0506281745040.10406@echo.lysdexia.org> <20050629125409.GA29188@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Ingo Molnar wrote:

> > I got a trace with VLC and one burnP6 instance running.  The second 
> > included trace was started in the background immediately before firing 
> > up a second burnP6, but I'm not sure it covers any of the time that 
> > the second burnP6 was running.
> 
> there doesnt seem to be too much of an interrupt related problem:
> 
>    $ grep 'do_IRQ (' trace-it.2.txt
>    <...>-18659 0Dnh.  228us : do_IRQ (80480d2 0 0)
>    <...>-18659 0Dnh. 1228us : do_IRQ (80480d6 0 0)
>    <...>-18659 0Dnh. 2232us : do_IRQ (80480d6 0 0)
>    <...>-18659 0Dnh. 3229us : do_IRQ (80480c4 0 0)
>    <...>-18659 0Dnh. 4227us : do_IRQ (80480e8 0 0)
>    <...>-18659 0Dnh. 5227us : do_IRQ (80480df 0 0)
>    <...>-18659 0Dnh. 6226us : do_IRQ (80480e8 0 0)
>    <...>-18659 0Dnh. 7226us : do_IRQ (80480df 0 0)
>    <...>-18659 0Dnh. 8225us : do_IRQ (80480c4 0 0)
>    <...>-18659 0Dnh. 9231us : do_IRQ (80480e3 0 0)
>    <...>-18659 0Dnh. 10225us : do_IRQ (80480e8 0 0)
> 
> you are getting a timer interrupt (IRQ 0) every 1000 usecs, as expected.
> 
> i'd suggest to capture trace-it traces only during a clearly identified 
> anomalous event such as an interrupt storm. For latency analysis 
> purposes the default latency traces are better.
> 
> > > on SMP this could occur if the TSCs of different CPUs are too apart from 
> > > each other. I'll probably put an automatic check for this into the 
> > > /proc/latency_trace code.
> > 
> > Yup.  Got another one of these.
> 
> was this on a -29 or later kernel? (-29 had a couple of latency.c fixes)

This one was on -50-30.

--ww

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVF2Myw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVF2Myw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 08:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVF2Myd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 08:54:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55482 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262562AbVF2My1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 08:54:27 -0400
Date: Wed, 29 Jun 2005 14:54:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050629125409.GA29188@elte.hu>
References: <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org> <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu> <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org> <20050625041453.GC6981@elte.hu> <Pine.LNX.4.58.0506262102250.32435@echo.lysdexia.org> <20050627081542.GA15096@elte.hu> <Pine.LNX.4.58.0506272001190.5720@echo.lysdexia.org> <20050628081053.GC7368@elte.hu> <Pine.LNX.4.58.0506281745040.10406@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506281745040.10406@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> I got a trace with VLC and one burnP6 instance running.  The second 
> included trace was started in the background immediately before firing 
> up a second burnP6, but I'm not sure it covers any of the time that 
> the second burnP6 was running.

there doesnt seem to be too much of an interrupt related problem:

   $ grep 'do_IRQ (' trace-it.2.txt
   <...>-18659 0Dnh.  228us : do_IRQ (80480d2 0 0)
   <...>-18659 0Dnh. 1228us : do_IRQ (80480d6 0 0)
   <...>-18659 0Dnh. 2232us : do_IRQ (80480d6 0 0)
   <...>-18659 0Dnh. 3229us : do_IRQ (80480c4 0 0)
   <...>-18659 0Dnh. 4227us : do_IRQ (80480e8 0 0)
   <...>-18659 0Dnh. 5227us : do_IRQ (80480df 0 0)
   <...>-18659 0Dnh. 6226us : do_IRQ (80480e8 0 0)
   <...>-18659 0Dnh. 7226us : do_IRQ (80480df 0 0)
   <...>-18659 0Dnh. 8225us : do_IRQ (80480c4 0 0)
   <...>-18659 0Dnh. 9231us : do_IRQ (80480e3 0 0)
   <...>-18659 0Dnh. 10225us : do_IRQ (80480e8 0 0)

you are getting a timer interrupt (IRQ 0) every 1000 usecs, as expected.

i'd suggest to capture trace-it traces only during a clearly identified 
anomalous event such as an interrupt storm. For latency analysis 
purposes the default latency traces are better.

> > on SMP this could occur if the TSCs of different CPUs are too apart from 
> > each other. I'll probably put an automatic check for this into the 
> > /proc/latency_trace code.
> 
> Yup.  Got another one of these.

was this on a -29 or later kernel? (-29 had a couple of latency.c fixes)

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbTDABab>; Mon, 31 Mar 2003 20:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261980AbTDABab>; Mon, 31 Mar 2003 20:30:31 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:44805
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S261979AbTDABaa>; Mon, 31 Mar 2003 20:30:30 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, rml@tech9.net,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20030329212330.225a96b6.akpm@digeo.com>
References: <3E8610EA.8080309@telia.com> <1048987260.679.7.camel@teapot>
	 <1048989922.13757.20.camel@localhost>
	 <200303301233.03803.kernel@kolivas.org>
	 <1048992365.13757.23.camel@localhost>
	 <1048996723.3058.41.camel@iso-8590-lx.zeusinc.com>
	 <20030329212330.225a96b6.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049161310.1043.440.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2003 17:41:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 21:23, Andrew Morton wrote:
> Tom Sightler <ttsig@tuxyturvy.com> wrote:
> >
> > On my system I get a starvation issue with just about any CPU intensive
> > task.  For example if create a bzip'd tar file from the linux kernel
> > source with the command:
> > 
> > tar cvp linux | bzip2 -9 > linux.tar.bz2
> > 
> 
> Ingo has determined that Linus's backboost trick is causing at least some
> of these problems. Please test and report upon the below patch.
>[...]
> From: Ingo Molnar <mingo@elte.hu>
> 
> the patch below fixes George's setiathome problems (as expected).  It
> essentially turns off Linus' improvement, but i dont think it can be fixed
> sanely.
> 
> the problem with setiathome is that it displays something every now and
> then - so it gets a backboost from X, and hovers at a relatively high
> priority.

This fixes the starvation I was getting with xmms visualizers, which
have a similar usage pattern: they're mostly CPU-bound, but they talk to
the X server for drawing.

	J


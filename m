Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTKCVxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTKCVxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:53:50 -0500
Received: from mail02.agrinet.ch ([81.221.250.51]:49417 "EHLO
	mail02.agrinet.ch") by vger.kernel.org with ESMTP id S263427AbTKCVxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:53:43 -0500
From: Erwin Telser <erwin.telser@pop.agri.ch>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Responsiveness of 2.6.0-Test9
Date: Mon, 3 Nov 2003 23:53:16 +0000
User-Agent: KMail/1.5.4
References: <200311022345.08192.erwin.telser@pop.agri.ch> <3FA5DD01.1070109@cyberone.com.au>
In-Reply-To: <3FA5DD01.1070109@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311032353.16570.erwin.telser@pop.agri.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Erwin Telser wrote:
> >Are there things to observe when switching from 2.4 to 2.6, if I want the
> > same responsiveness? I'm asking because I' ve made the following
> > observation. (I always had the feeling, 2.4 seems to faster, but this is
> > the first time it' s very obvious)
> >
> >I' ve connected two monitors on a Matrox G550. One runs with DRI the other
> > one doesn't (not possible with the current driver). The Monitor with DRI
> > I'm using as a TV Set, watching movies with xawtv. (With a bttv 878 tuner
> > card).
> >
> >Now with the 2.4.22 kernel (preemptible patch aplied) I can play the
> > little game kbounce on the other monitor, without to notice any slowdown,
> > no matter, whether xawtv is running or not.
> >
> >But with the 2.6 Kernel (compiled with preemptible option) the bouncing
> > balls slow down considerably, as soon as I move the mouse.
> >
> >I know the whole thing is a little foolish. But anyway, are there some
> > tricks to get the same responsiveness?
>
> Hi,
> Your report is not foolish at all ;)
> Please make sure your X process is at default static priority, 0.
> Report back if you are still having problems. What sort of processor
> do you have? Is your 2.6 video driver running with the same sort of
> acceleration as your 2.4 one (do you get the same frame rate in glxgears)?

I installed X from scratch and didn't edit any start script. so I assume, that 
it runs with priority 0. The processor is an Intel P4 2000MHz in an ASUS 
P4B266 Board. If I compare the frames per second with glxgears there is a 
slight advantage for 2.4

2.4: 
with DRI 358 - 364
without DRI 181 - 198

2.6
with DRI 350 - 362
without DRI 180 - 187

An even better way to show the differenze between 2.4 and 2.6 is to change the 
size of the xawtv window. If I do that, the slowdown is quite significant. 
But it happens only with xawtv. If I do the same with konqueror or MPlayer, 
nothing happens. A very strange thing are the values I get from ksysguard

Kernel 2.4, glxgears
user load: 3% - 4%
system load: 95%
IRQ per second: ~100

Kernel 2.6, glxgears
user load: 15%
system load: 85%
IRQ per second: ~1100 

Kernel 2.4, xawtv
user load: 2%
system load: 0%
IRQ per second: ~100

Kernel 2.6, xawtv
user load: 9%
system load: 0%
IRQ per second: ~1060 

Kernel 2.4, MPlayer
user load: 35%
system load: 2%
IRQ per second: ~1170

Kernel 2.6, MPlayer
user load: 42%
system load: 2%
IRQ per second: ~2130

Something is causing a high IRQ load with kernel 2.6. Probably an APIC 
problem?

Erwin


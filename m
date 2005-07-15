Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263292AbVGOP6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbVGOP6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 11:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbVGOP6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 11:58:08 -0400
Received: from graphe.net ([209.204.138.32]:56977 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263292AbVGOP6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 11:58:06 -0400
Date: Fri, 15 Jul 2005 08:57:36 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jakma <paul@clubi.ie>
cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org
Subject: Re: [OT] high precision hardware (was Re: [PATCH] i386: Selectable
 Frequency of the Timer Interrupt)
In-Reply-To: <Pine.LNX.4.63.0507151227240.31084@sheen.jakma.org>
Message-ID: <Pine.LNX.4.62.0507150855220.1986@graphe.net>
References: <1121282025.4435.70.camel@mindpipe>  <d120d50005071312322b5d4bff@mail.gmail.com>
  <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
  <20050713211650.GA12127@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <20050714083843.GA4851@elte.hu> <1121352941.4535.15.camel@mindpipe>
 <Pine.LNX.4.62.0507140757200.31521@graphe.net> <Pine.LNX.4.63.0507151227240.31084@sheen.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Paul Jakma wrote:

> On Thu, 14 Jul 2005, Christoph Lameter wrote:
> 
> > Linux can already provide a response time within < 3 usecs from user space
> > using f.e. the Altix RTC driver which can generate an interrupt that then
> > sends a signal to an application. The Altix RTC clock is supported via POSIX
> > timer syscalls and can be accessed using CLOCK_SGI_CYCLE. This has been
> > available in Linux since last fall and events can be specified with 50
> > nanoseconds accurary.
> 
> Out of curiosity, are there any cheap and 'embeddable' linux supported
> architectures which support such response times (User or kernel space)?

Well, just implement the proper hooks for the HPET so that you can use
CLOCK_HPET from user space.

> Input comes in at anywhere from 6kHz to 100kHz (variable), (T0 say),
> requirement is to assert an output line Ta seconds after each T0, Ta needs to
> be accurate to about 6us in the extreme case (how long the output is held has
> similar accuracy requirement).

Well the interrupt latency depends on many things in the linux kernel. 
Worst case is much greater than 6us. You probably need the RT patches as 
well.
 
> What kind of hardware is capable of this? Even in microcontroller space it's
> difficult to do (eg looked at some ARM microcontrollers, which still have
> several usec of interrupt latency - even with no OS, still likely cant use
> timers and interrupts.).

Try HPET which is pretty standard these days.



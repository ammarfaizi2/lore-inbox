Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271374AbTHHVKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271938AbTHHVKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 17:10:07 -0400
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:18561 "EHLO
	gnuppy") by vger.kernel.org with ESMTP id S271374AbTHHVKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 17:10:04 -0400
Date: Fri, 8 Aug 2003 14:09:50 -0700
To: Daniel Phillips <phillips@arcor.de>
Cc: Timothy Miller <miller@techsource.com>, Andrew Morton <akpm@osdl.org>,
       ed.sweetman@wmich.edu, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org, kernel@kolivas.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030808210950.GA2142@gnuppy.monkey.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271517.55549.phillips@arcor.de> <3F267CF9.40500@techsource.com> <200307300946.41674.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307300946.41674.phillips@arcor.de>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:46:41AM -0500, Daniel Phillips wrote:
> On Tuesday 29 July 2003 08:56, Timothy Miller wrote:
> > ...since we're dealing with real-time and audio issues, is there any
> > way we can do this:  When the interrupt arrives from the sound card so
> > that the driver needs to set up DMA for the next block or whatever it
> > does, move any processes which talk to an audio device to the head of
> > the process queue?
> 
> That would be a good thing.  To clarify, there are typically two buffers 
> involved:
> 
>   - A short DMA buffer
>   - A longer buffer into which the audio process generates samples
> 
> There are several cycles through the short buffer for each cycle through the 
> long buffer.  On one of these cycles, the contents of the long buffer will 
> drop below some threshold and the refill process should be scheduled, 
> according to your suggestion.  Developing a sane API for that seems a little 
> challenging.  Somebody should just hack this and demonstrate the benefit.
> 
> In the meantime, the SCHED_SOFTRR proposal provides a way of closely 
> approximating the above behaviour without being intrusive or 
> application-specific.

You might also like to think about driving the scheduler with an
interrupt from the DMA device, if it's regular, or VBL (vertical
retrace) for video/graphics applications. IRIX's REACT/pro RT system
does stuff like this.

	http://techpubs.sgi.com/library/tpl/cgi-bin/getdoc.cgi?coll=0650&db=bks&srch=&fname=/SGI_Developer/REACT_PG/sgi_html/pr02.html

It's in their frame scheduler section.

bill


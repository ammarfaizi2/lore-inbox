Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271758AbTG2OoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271838AbTG2OoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:44:23 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:43244 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S271758AbTG2OoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:44:22 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Timothy Miller <miller@techsource.com>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Wed, 30 Jul 2003 09:46:41 -0500
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, ed.sweetman@wmich.edu,
       eugene.teo@eugeneteo.net, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271517.55549.phillips@arcor.de> <3F267CF9.40500@techsource.com>
In-Reply-To: <3F267CF9.40500@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307300946.41674.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 July 2003 08:56, Timothy Miller wrote:
> ...since we're dealing with real-time and audio issues, is there any
> way we can do this:  When the interrupt arrives from the sound card so
> that the driver needs to set up DMA for the next block or whatever it
> does, move any processes which talk to an audio device to the head of
> the process queue?

That would be a good thing.  To clarify, there are typically two buffers 
involved:

  - A short DMA buffer
  - A longer buffer into which the audio process generates samples

There are several cycles through the short buffer for each cycle through the 
long buffer.  On one of these cycles, the contents of the long buffer will 
drop below some threshold and the refill process should be scheduled, 
according to your suggestion.  Developing a sane API for that seems a little 
challenging.  Somebody should just hack this and demonstrate the benefit.

In the meantime, the SCHED_SOFTRR proposal provides a way of closely 
approximating the above behaviour without being intrusive or 
application-specific.

Regards,

Daniel


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272069AbRHVSJH>; Wed, 22 Aug 2001 14:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272071AbRHVSI4>; Wed, 22 Aug 2001 14:08:56 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:38925 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272069AbRHVSIo>; Wed, 22 Aug 2001 14:08:44 -0400
Message-ID: <3B83F577.EAE07A6B@t-online.de>
Date: Wed, 22 Aug 2001 20:09:59 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: bcrl@redhat.com, linux-kernel@vger.kernel.org, satch@fluent-access.com
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
In-Reply-To: <200108212235.WAA197891@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> > Armed with docs I was able to see just why our code
> > is completely wrong for handling things like the ps/2
> > mouse being removed at runtime.
> 
> Yes, or being added, to be more precise. But it will not be
> easy to do it right. So many different ps2-like types of mouse.
> There are heuristics, like the AA 00 that I gave last week or so.
> (But not every ps2-mouse emits this sequence.)

Not every mouse controller lets this sequence thru ?
(e.g. laptops with simultaneous stick +ps2 mouse)

A mouse not emitting this sequence would be broken.
However you could easily recover by polling the mouse
status every second. A newly-plugged mouse will have
characteristic bit pattern.

> And one can keep track of the timing. But the fact that the length
> of a packet is unknown (3, 4, 5, 8 bytes), and that in some modes
> and relative positions arbitrary data is legal, makes it more or less
> impossible to write code that is provably correct.

See above for a perfect solution.

> Also state machines have difficulties. Many types of mouse react
> to special sequences of ordinary commands, and enter a non-ps2 mode.

See http://home.t-online.de/home/gunther.mayer/gm_psauxprint-0.01.c
for a _dirty_ hack collecting info from various sources. This is the first
linux tool to implement the PS2-PNP protocol (for identifying MS mice).

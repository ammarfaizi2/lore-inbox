Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTFBWdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 18:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTFBWdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 18:33:37 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:36244
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264197AbTFBWde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 18:33:34 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Tom Sightler <ttsig@tuxyturvy.com>
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
Date: Mon, 2 Jun 2003 18:49:34 -0400
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306021927170.10228-100000@localhost.localdomain> <1054582030.4679.15.camel@iso-8590-lx.zeusinc.com>
In-Reply-To: <1054582030.4679.15.camel@iso-8590-lx.zeusinc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306021849.35813.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 June 2003 15:27, Tom Sightler wrote:
> On Mon, 2003-06-02 at 13:28, Ingo Molnar wrote:
> > to prove this point, could you try and renice wineserver to -10 (as root)
> > - does that fix the latency issues still?
> >
> > (if this doesnt then it could be the foreground process starving yet
> > another process - we have to find out which one.)
>
> Yes, I thought the same thing, and I did just that, but no, it doesn't
> fix the latency issue.  This system has very little running, I made sure
> that there were no sound servers such as esd or arts running, nothing.
> Basically, a plain KDE (with artsd disabled), mozilla, and Crossover
> wine plugin.  Even though I couldn't see how it would affect anything I
> tried bumping up the priorities of other processes such as mozilla
> itself, X, etc.  Nothing fixed the problem except for lowering the
> priority of the wine process.

Back around March there was a discussion of sharing interactivity bonus with 
the server an interactive process was waiting for.  It was mostly about 
XFree86 not getting batch scheduled and making mouse movement unusable so 
easily, but this sounds eerily similar...

In this case, it seems like the wine client either isn't accumulating an 
interactivity bonus (busy-waiting?), or else it's not transmitting it to the 
wine server (going through the network stack)?

I've been a bit out of touch since then (old ISP blew up, then i got busy).  
Just resurfacing now.  Maybe it's old news, but assuming the patch I'm 
thinking of wasn't backed out while I was away, it may be relevant.  The 
thread about it started here:

http://lists.insecure.org/lists/linux-kernel/2003/Mar/1244.html

> Could this process be starving the kernel itself so that it simply
> doesn't have time to service the sound correctly?

Unlikely.  Interrupts don't depend on the scheduler.  (Neither did bottom 
halves or tasklets.  I don't think work queues do either, but I'm a bit 
behind...)

Rob

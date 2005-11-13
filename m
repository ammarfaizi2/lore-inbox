Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVKMCaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVKMCaq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 21:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVKMCaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 21:30:46 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25733
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750852AbVKMCap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 21:30:45 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Joel Schopp <jschopp@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Sat, 12 Nov 2005 20:30:35 -0600
User-Agent: KMail/1.8
References: <20051104010021.4180A184531@thermo.lanl.gov> <1131392070.14381.133.camel@localhost.localdomain> <436FE561.7080703@austin.ibm.com>
In-Reply-To: <436FE561.7080703@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511122030.35542.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 November 2005 17:38, you wrote:
> >>RAM removal, not RAM replacement. I explained all the variants in an
> >>earlier email in this thread. "extending RAM" is relatively easy.
> >>"replacing RAM" while doable, is probably undesirable. "removing RAM"
> >>impossible.
>
> <snip>
>
> > BTW, I'm not suggesting any of this is a good idea, I just like to
> > understand why something _cant_ be done.
>
> I'm also of the opinion that if we make the kernel remap that we can
> "remove RAM".  Now, we've had enough people weigh in on this being a bad
> idea I'm not going to try it.  After all it is fairly complex, quite a bit
> more so than Mel's reasonable patches.  But I think it is possible.  The
> steps would look like this:
>
> Method A:
> 1. Find some unused RAM (or free some up)
> 2. Reserve that RAM
> 3. Copy the active data from the soon to be removed RAM to the reserved RAM
> 4. Remap the addresses
> 5. Remove the RAM
>
> This of course requires step 3 & 4 take place under something like
> stop_machine_run() to keep the data from changing.

Actually, what I was thinking is that if you use the swsusp infrastructure to 
suspend all processes, all dma, quiesce the heck out of the devices, and 
_then_ try to move the kernel...  Well, you at least have a much more 
controlled problem.  Yeah, it's pretty darn intrusive, but if you're doing 
"suspend to ram" perhaps the downtime could be only 5 or 10 seconds...

I don't know how much of the problem that leaves unsolved, though.

Rob

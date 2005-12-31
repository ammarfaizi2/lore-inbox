Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVLaOiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVLaOiD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVLaOiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:38:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20492 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932283AbVLaOiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:38:01 -0500
Date: Sat, 31 Dec 2005 15:38:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051231143800.GJ3811@stusta.de>
References: <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org> <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230074916.GC25637@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 08:49:16AM +0100, Ingo Molnar wrote:
> 
> * Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> 
> > What about the previous suggestion to remove inline from *all* static 
> > inline functions in .c files?
> 
> i think this is a way too static approach. Why go from one extreme to 
> the other, when my 3 simple patches (which arguably create a more 
> flexible scenario) gives us savings of 7.7%?

This point only discusses the inline change, which were (without 
unit-at-a-time) in your measurements 2.9%.

Your patch might be simple, but it also might have side effects in cases 
where we _really_ want the code forced to be inlined. How simple is it 
to prove that your uninline patch doesn't cause a subtle breakage 
somewhere?

inline's in .c files are nearly always wrong (there might be very few 
exceptions), and this should simply be fixed.

Applying Arjan's uninlining patch [1] against 2.6.15-rc5-mm3 (ignoring a 
few rejects at applying the patch), I'm getting more than 0.6% .text 
savings (this is with a "compile everything .config", without 
unit-at-a-time and with -Os). 

> 	Ingo

cu
Adrian

[1] http://www.fenrus.org/noinline

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


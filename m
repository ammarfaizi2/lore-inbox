Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279731AbRJYJIR>; Thu, 25 Oct 2001 05:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279733AbRJYJIH>; Thu, 25 Oct 2001 05:08:07 -0400
Received: from inje.iskon.hr ([213.191.128.16]:39327 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S279732AbRJYJHw>;
	Thu, 25 Oct 2001 05:07:52 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <Pine.LNX.4.33.0110242117150.9147-100000@penguin.transmeta.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 25 Oct 2001 11:07:05 +0200
In-Reply-To: <Pine.LNX.4.33.0110242117150.9147-100000@penguin.transmeta.com> (Linus Torvalds's message of "Wed, 24 Oct 2001 21:19:55 -0700 (PDT)")
Message-ID: <dn1yjsytom.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 25 Oct 2001, Zlatko Calusic wrote:
> >
> > Sure. Output of 'vmstat 1' follows:
> >
> >  1  0  0      0 254552   5120 183476   0   0    12    24  178   438 2  37  60
> >  0  1  0      0 137296   5232 297760   0   0     4  5284  195   440 3  43  54
> >  1  0  0      0 126520   5244 308260   0   0     0 10588  215   230 0   3  96
> >  0  2  0      0 117488   5252 317064   0   0     0  8796  176   139 1   3  96
> >  0  2  0      0 107556   5264 326744   0   0     0  9704  174    78 0   3  97
> 
> This does not look like a VM issue at all - at this point you're already
> getting only 10MB/s, yet the VM isn't even involved (there's definitely no
> VM pressure here).

That's true, I'll admit. Anyway, -ac kernels don't have the problem,
and I was misleaded by the fact that only VM implementation differs in
those two branches (at least I think so).

> 
> > Notice how there's planty of RAM. I'm writing sequentially to a file
> > on the ext2 filesystem. The disk I'm writing on is a 7200rpm IDE,
> > capable of ~ 22 MB/s and I'm still getting only ~ 9 MB/s. Weird!
> 
> Are you sure you haven't lost some DMA setting or something?
> 

No. Setup is fine. I wouldn't make such a mistake. :)
If the disk were in some PIO mode, CPU usage would be much higher, but
it isn't.

This all definitely looks like a problem either in the bdflush daemon,
or request queue/elevator, but unfortunately I don't have enough
knowledge of that areas to pinpoint it more precisely.
-- 
Zlatko

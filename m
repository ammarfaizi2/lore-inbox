Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264040AbRFEQxe>; Tue, 5 Jun 2001 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264037AbRFEQxY>; Tue, 5 Jun 2001 12:53:24 -0400
Received: from inje.iskon.hr ([213.191.128.16]:53150 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S264040AbRFEQxN>;
	Tue, 5 Jun 2001 12:53:13 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Mike Galbraith <mikeg@wen-online.de>, lkml <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: Comment on patch to remove nr_async_pages limit
In-Reply-To: <Pine.LNX.4.21.0106050307250.2846-100000@freak.distro.conectiva>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 05 Jun 2001 18:05:04 +0200
In-Reply-To: <Pine.LNX.4.21.0106050307250.2846-100000@freak.distro.conectiva> (Marcelo Tosatti's message of "Tue, 5 Jun 2001 03:18:58 -0300 (BRT)")
Message-ID: <87y9r6yksv.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

[snip]
> Exactly. And when we reach a low watermark of memory, we start writting
> out the anonymous memory.
>

Hm, my observations are a little bit different. I find that writeouts
happen sooner than the moment we reach low watermark, and many times
just in time to interact badly with some read I/O workload that made a
virtual shortage of memory in the first place. Net effect is poor
performance and too much stuff in the swap.

> > In experiments, speeding swapcache pages on their way helps.  Special
> > handling (swapcache bean counting) also helps. (was _really ugly_ code..
> > putting them on a seperate list would be a lot easier on the stomach:)
> 
> I agree that the current way of limiting on-flight swapout can be changed
> to perform better. 
> 
> Removing the amount of data being written to disk when we have a memory
> shortage is not nice. 
> 

OK, then we basically agree that there is a place for improvement, and
you also agree that we must be careful while trying to achieve that.

I'll admit that my patch is mostly experimental, and its best effect
is this discussion, which I enjoy very much. :)
-- 
Zlatko

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264042AbRFEQxe>; Tue, 5 Jun 2001 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264034AbRFEQxY>; Tue, 5 Jun 2001 12:53:24 -0400
Received: from inje.iskon.hr ([213.191.128.16]:52638 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S264037AbRFEQxM>;
	Tue, 5 Jun 2001 12:53:12 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Comment on patch to remove nr_async_pages limit
In-Reply-To: <Pine.LNX.4.21.0106042142550.2521-100000@freak.distro.conectiva>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 05 Jun 2001 17:56:46 +0200
In-Reply-To: <Pine.LNX.4.21.0106042142550.2521-100000@freak.distro.conectiva> (Marcelo Tosatti's message of "Mon, 4 Jun 2001 22:04:22 -0300 (BRT)")
Message-ID: <877kyqzzr5.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> Zlatko, 
> 
> I've read your patch to remove nr_async_pages limit while reading an
> archive on the web. (I have to figure out why lkml is not being delivered
> correctly to me...)
> 
> Quoting your message: 
> 
> "That artificial limit hurts both swap out and swap in path as it
> introduces synchronization points (and/or weakens swapin readahead),
> which I think are not necessary."
> 
> If we are under low memory, we cannot simply writeout a whole bunch of
> swap data. Remember the writeout operations will potentially allocate
> buffer_head's for the swapcache pages before doing real IO, which takes
> _more memory_: OOM deadlock. 
> 

My question is: if we defer writing and in a way "loose" that 4096
bytes of memory (because we decide to keep the page in the memory for
some more time), how can a much smaller buffer_head be a problem?

I think we could always make a bigger reserve of buffer heads just for
this purpose, to make swapout more robust, and then don't impose any
limits on the number of the outstanding async io pages in the flight.

Does this make any sense?

-- 
Zlatko

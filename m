Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRBMNc3>; Tue, 13 Feb 2001 08:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129447AbRBMNcU>; Tue, 13 Feb 2001 08:32:20 -0500
Received: from [62.59.70.137] ([62.59.70.137]:41988 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129363AbRBMNcH>; Tue, 13 Feb 2001 08:32:07 -0500
Date: Tue, 13 Feb 2001 13:43:02 +0100 (CET)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.Linu.4.10.10102130649110.324-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.31.0102131340160.5111-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Mike Galbraith wrote:
> On Mon, 12 Feb 2001, Marcelo Tosatti wrote:
>
> > Could you please try the attached patch on top of latest Rik's patch?
>
> Sure thing.. (few minutes later) no change.

That's because your problem requires a change to the
balancing between swap_out() and refill_inactive_scan()
in refill_inactive()...

The big problem here is that no matter which magic
proportion between the two functions we use, it'll always
be wrong for a large proportion of the people out there.

This means we need to have a good way to auto-tune this
thing. I'm thinking of letting swap_out() start out way
less active than refill_inactive_scan() with extra calls
to swapout being made from refill_inactive_scan when we
think it's needed...

(... I'm writing a patch right now ...)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


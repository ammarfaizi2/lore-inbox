Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbRHUDge>; Mon, 20 Aug 2001 23:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269632AbRHUDgQ>; Mon, 20 Aug 2001 23:36:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24069 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S268901AbRHUDgE>;
	Mon, 20 Aug 2001 23:36:04 -0400
Date: Tue, 21 Aug 2001 00:36:04 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Mark Hemment <markhe@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: kswap spinning
In-Reply-To: <Pine.LNX.4.21.0108202257470.538-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0108210034080.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Marcelo Tosatti wrote:

> > Could you please boot with profile=2 and use readprofile to find out where
> > kswapd is spending its time?
>
> Well, I've just noted Linus made kswapd loop as long as there is any
> kind (inactive or free) shortage.

Well, duh.  Let me explain.

>From mm/vmscan.c::kswapd() a short comment I wrote while
implementing part of the current VM:

                /*
                 * We go to sleep if either the free page shortage
                 * or the inactive page shortage is gone. We do this
                 * because:
                 * 1) we need no more free pages   or
                 * 2) the inactive pages need to be flushed to disk,
                 *    it wouldn't help to eat CPU time now ...
                 *
                 * We go to sleep for one second, but if it's needed
                 * we'll be woken up earlier...
                 */
                if (!free_shortage() || !inactive_shortage()) {
                        interruptible_sleep_on_timeout(&kswapd_wait, HZ);

I wonder when Linus lost his ability to read comments ;)

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


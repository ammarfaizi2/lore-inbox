Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270268AbRHHB4A>; Tue, 7 Aug 2001 21:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270267AbRHHBzu>; Tue, 7 Aug 2001 21:55:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:45324 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270266AbRHHBzi>;
	Tue, 7 Aug 2001 21:55:38 -0400
Date: Tue, 7 Aug 2001 22:55:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <laughing@shared-source.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac9
In-Reply-To: <20010807235302.A16178@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L.0108072218370.17803-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Alan Cox wrote:

> 2.4.7-ac9

> o	Allow swap < 2*ram				(Rik van Riel)

... which I have verified to be functional, on SMP,
but still isn't fine-tuned.

Basically the code frees up swap space on swapin when
we are in danger of swap running out; currently we take
a threshold of 80% full, but this is just a random number.

Ideally the threshold would be such that:
1) swap usage is close to maximal ...
2) ... but (almost) never completely full

By having this we'd have the benefits of both keeping
stuff in swap (less fragmentation, less swapout IO) and
the benefits of freeing up swap on time (able to swap
out the pages we want to get rid of).

It would be cool if people with smallish swap areas
could test this patch to see if any extra tuning would
be needed.

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130563AbRADQYp>; Thu, 4 Jan 2001 11:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130546AbRADQYZ>; Thu, 4 Jan 2001 11:24:25 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:57584 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130563AbRADQYP>; Thu, 4 Jan 2001 11:24:15 -0500
Date: Thu, 4 Jan 2001 14:23:53 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
In-Reply-To: <20010104171807.B1507@athlon.random>
Message-ID: <Pine.LNX.4.21.0101041422360.1188-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Andrea Arcangeli wrote:
> On Thu, Jan 04, 2001 at 01:00:28PM -0200, Rik van Riel wrote:
> > Other tasks tend not to stress the dcache like updatedb does,
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > leading to the effect that updatedb can "flush out" the other
> > cached values faster than the other processes reference them.
> > 
> > This is something no amount of 2nd chance replacement or even
> > aging can prevent.
> 
> Your arguments are senseless.

I could say the same of yours if I let myself
sink to that level ;) </obflamebait>

> The dcache aging is mostly useful with _high_ VFS load like
> updatedb in background. The logic is the same of the VM aging
> (ask yourself when the VM aging is most useful: when there's
> high VM load, like a `cp /dev/zero .`

This is exactly the point where page aging alone isn't good
enough and you need something like drop-behind...

(yes, there IS a reason why we have drop_behind() and page
deactivation in generic_file_write)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271677AbRHUPpv>; Tue, 21 Aug 2001 11:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271681AbRHUPpl>; Tue, 21 Aug 2001 11:45:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34015 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271677AbRHUPpZ>;
	Tue, 21 Aug 2001 11:45:25 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 21 Aug 2001 15:45:39 GMT
Message-Id: <200108211545.PAA189159@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: BUG: pc_keyb.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From alan@lxorguk.ukuu.org.uk Tue Aug 21 00:48:32 2001

    > But the present code does not guarantee such a delay at all.
    > For example, kbd_write_cmd() does
    >     kb_wait();
    >     outb(...);
    >     kb_wait();
    > where the second kb_wait reads the status very quickly after the first.

    Thats wrong by the spec. I dug out my docs - there is a required 1mS (not
    2 tho) delay for keyboard port accesses.

Since there are various keyboard and mouse paths that can lead to
register access, it seems that we must either prefix each access
by a wait, or otherwise we must remember at what time we last did
a read.

Something else is that on some ancient (MCA) systems a delay is required
between finding the ready bit and actually reading the data
(Frank van Gilluwe, p. 273: wait 7 us).

On the other hand, 1 ms is a very long time these days; it is a bit
surprising that modern hardware should need delays in that order of
magnitude; maybe the problem is elsewhere and the mdelay(2) happens
to change the timing and avoid the problem.



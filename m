Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbQKFN5X>; Mon, 6 Nov 2000 08:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129504AbQKFN5N>; Mon, 6 Nov 2000 08:57:13 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:60150 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129193AbQKFN44>;
	Mon, 6 Nov 2000 08:56:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A06B45A.E75EC748@mandrakesoft.com> 
In-Reply-To: <3A06B45A.E75EC748@mandrakesoft.com>  <3A069CA8.5BB5FF20@mandrakesoft.com> <3A0698A8.8D00E9C1@mandrakesoft.com> <3A0693E9.B4677F4E@mandrakesoft.com> <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> <28752.973510632@redhat.com> <29788.973511264@redhat.com> <7013.973516333@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 13:56:24 +0000
Message-ID: <11673.973518984@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  I am thinking about the bigger picture:  You are unloading a driver,
> then continuing to use the hardware.  To me, that is an undefined
> state.

We're only using the pass-through levels. It's undefined but it doesn't
matter to the software. I'd actually suggest that for hardware which does
stop the pass-through audio when the driver is unloaded, we really ought not
unload the driver while those levels are non-zero.

We should still reset the hardware completely when we reload the driver -
it's just that we should reset it to the levels previously set by the user,
rather than resetting it to zeroes.


jgarzik@mandrakesoft.com said:
>  However, since simply leaving the driver loaded solves all this mess,
> it doesn't seem worth changing drivers to do anything different. 

Leaving the driver loaded has been my solution ever since kerneld was taken 
out. I merely commented that Keith's new stuff would allow me to get 
persistent storage working again. It's not very difficult to change the 
driver to use it.

I believe the SBLive! driver is a little larger than the example you 
pasted. I think we probably do care about adding a little bit more to the 
pool of permanently unswappable pages here and there.


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

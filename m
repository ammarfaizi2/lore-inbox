Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAIRFI>; Tue, 9 Jan 2001 12:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbRAIRE6>; Tue, 9 Jan 2001 12:04:58 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:12000 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S129534AbRAIREs>;
	Tue, 9 Jan 2001 12:04:48 -0500
Date: Tue, 9 Jan 2001 09:04:27 -0800
To: John Ruttenberg <rutt@chezrutt.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: wavelan has fatal error with 2.4.0 (but worked in 2.4.0-test12)
Message-ID: <20010109090427.A30175@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <200101091217.f09CH1n01252@mojo.chezrutt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101091217.f09CH1n01252@mojo.chezrutt.com>; from rutt@chezrutt.com on Tue, Jan 09, 2001 at 07:17:01AM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 07:17:01AM -0500, John Ruttenberg wrote:
> I get:
> 
>     Jan  9 07:04:51 mojo cardmgr[511]: socket 1: Digital RoamAbout/DS
>     Jan  9 07:04:52 mojo cardmgr[511]: executing: 'modprobe wavelan_cs'
>     Jan  9 07:04:52 mojo cardmgr[511]: + /lib/modules/2.4.0-test11/pcmcia/wavelan_cs.o: unresolved symbol __bad_udelay
>     Jan  9 07:04:52 mojo cardmgr[511]: + /lib/modules/2.4.0-test11/pcmcia/wavelan_cs.o: insmod /lib/modules/2.4.0-test11/pcmcia/wavelan_cs.o failed
>     Jan  9 07:04:52 mojo cardmgr[511]: + /lib/modules/2.4.0-test11/pcmcia/wavelan_cs.o: insmod wavelan_cs failed
>     Jan  9 07:04:52 mojo cardmgr[511]: modprobe exited with status 255
>     Jan  9 07:04:52 mojo cardmgr[511]: executing: 'insmod /lib/modules/2.4.0/pcmcia/wavelan_cs.o'
>     Jan  9 07:04:52 mojo cardmgr[511]: + /lib/modules/2.4.0/pcmcia/wavelan_cs.o: unresolved symbol __bad_udelay
>     Jan  9 07:04:52 mojo cardmgr[511]: insmod exited with status 1

	This is a bug with the definition of udelay(). Somebody tried
to be too clever with udelay(), and the end result is that it breaks
perfectly good and valid code.
	Therefore, it should be reported as such on LKML, a bug in udelay().

	I think that Alan has a ugly workaround for this driver (or
maybe it's only for wavelan.c) in the ac4 tree, so please check
there. For my part, I insist that the code is correct, that replacing
an inline function by a #define is going backwards and that udelay()
should be fixed one way or another (easy, just define __bad_udelay()
as returning a compilation warning or an error message).
	Also, please remember that the version of wavelan_cs.c in the
kernel is outdated with respect to the version in the Pcmcia package.

	That's it...

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132453AbRACQMi>; Wed, 3 Jan 2001 11:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132290AbRACQM2>; Wed, 3 Jan 2001 11:12:28 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:11422 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132469AbRACQMQ>; Wed, 3 Jan 2001 11:12:16 -0500
Date: Wed, 3 Jan 2001 16:39:11 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, sfr@gmx.net
Subject: Re: Timeout: AT keyboard not present?
In-Reply-To: <UTC200101031432.PAA136866.aeb@texel.cwi.nl>
Message-ID: <Pine.GSO.3.96.1010103162016.28582A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001 Andries.Brouwer@cwi.nl wrote:

> (Ordinarily a key-up event gets scancode of key-down but with
> high-order bit set. In scancode set 1, a key-up event get the
> scancode of key-down prefixed by 0xf0. Since the high-order bit
> is masked here, this 0xf0 would show up as 0x70.
> Moreover, the key-up for a sequence like e0 71 is e0 f0 71,
> again what you see here.)
> 
> How you got into scancode mode 1 I don't know
> (maybe by sending the command f0 01 to the keyboard).

 It looks like untranslated mode 2 (i.e. the AT keyboard's mode).  You
switch translation on or off by toggling a bit in the onboard 8042's
command byte. 

 PS/2-style keyboards start in mode 2 usually.  An XT compatibility (bit 7
meaning release) is provided by the onboard 8042 translating codes.  Some
systems (I think DEC OSF/1, for example) program keyboards to work in mode
3 (the PS/2 native mode) or possibly mode 1 (XT compatibility mode); for
these modes the 8042's translation has to disabled or the keyboard will be
next to useless.  It's also meaningful to disable the translation in mode
2 -- you are presented with the AT interface then.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

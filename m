Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSA1Kyo>; Mon, 28 Jan 2002 05:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286687AbSA1KyZ>; Mon, 28 Jan 2002 05:54:25 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:7172 "EHLO
	inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S286411AbSA1KyQ>; Mon, 28 Jan 2002 05:54:16 -0500
Date: Mon, 28 Jan 2002 11:54:08 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Daniela Engert <dani@ngrt.de>
Cc: Martin Garton <martin@wrasse.demon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: sis.patch.20020123_1
Message-ID: <20020128115408.A21844@bouton.inet6-interne.fr>
Mail-Followup-To: Daniela Engert <dani@ngrt.de>,
	Martin Garton <martin@wrasse.demon.co.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201271412110.32403-100000@wrasse.demon.co.uk> <200201271559.QAA28129@myway.myway.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201271559.QAA28129@myway.myway.de>; from dani@ngrt.de on Sun, Jan 27, 2002 at 04:59:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 04:59:43PM +0100, Daniela Engert wrote:
> Your chipset cannot be detected by the surrent SiS IDE patch because it
> takes a list based approach to find supported chips and their
> capabilities rather than a more intelligent detection scheme (I've sent
> Lionel code which shows how to do that).

I didn't even know about SiS737 before! I guess I won't rely on SiSHostChipInfo in
v0.14.
I'll check your code next week (skying starting tomorrow).

> >I did a nasty hack to get the device recognised as SiS735, and all is 
> >fine. I haven't posted my patch for this since I don't know the Right fix.
> 
> You just thave to add it to the device list. There are other chips
> missing as well.
> 
> > 		case ATA_66: p += sprintf(p, active_time[(reg01 & 0x07) >> 4]); break;
> >-		case ATA_100: p += sprintf(p, active_time[(reg00 & 0x70)]); break;
> >+		case ATA_100: p += sprintf(p, active_time[(reg00 & 0x07)]); break;
> 
> The problem is that the calculation of the index into the active time
> table is incorrect in *all* three lines above! In the ATA66 case the
> shift is wrong and causes an zero value regardless of the register
> setting. In the "old" ATA100 case the index is calculated from the
> correct bits but is missing the shift by four from the line above;
> because of the too large index you see the OOPS. The "new" ATA100 case
> is wrong because it takes the wrong bits into calculation.

Ooops. Corrected in the last patch.

http://inet6.dyn.dhs.org/sponsoring/sis5513/sis.patch.20020128_1

LB.

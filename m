Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131684AbRA1LDq>; Sun, 28 Jan 2001 06:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131842AbRA1LDg>; Sun, 28 Jan 2001 06:03:36 -0500
Received: from 13dyn128.delft.casema.net ([212.64.76.128]:8717 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131684AbRA1LD2>; Sun, 28 Jan 2001 06:03:28 -0500
Message-Id: <200101281103.MAA04584@cave.bitwizard.nl>
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <3A73F1EB.B6F69A93@transmeta.com> from "H. Peter Anvin" at "Jan
 28, 2001 02:18:19 am"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Sun, 28 Jan 2001 12:03:09 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Rogier Wolff wrote:
> > 
> > Ok. I've thought about it some more, but I don't care enough about
> > this issue to do the painstaking legwork: I don't have one of those
> > POST-code indicators on port 0x80.
> > 
> > I've made the "pause" in outb_p just a few (*) ns slower, because it
> > now loads a variable before outputting the value to port 0x80. As the
> > whole idea about this is "pausing", making it a bit slower shouldn't
> > matter too much.  I've tested it: It compiles, it boots.
> > 
> > I'm not too familar with the syntax of the "asm" statement. So I may
> > illegally be modifying the AX register. I don't care enough about this
> > to figure it out right now.
> > 
> 
> It is; you'd have to specify "eax" as a clobber value, and that is
> undesirable.

OK. Then someone needs to do the legwork, and add that.

The "_P" version is intended to be inefficient "because the device
can't handle us pushing the limit". Thus a little more because of an
eax reload is unfortunate, but not the end of the world.

Everybody knows (I hope) that outb_p is not intended as an efficient
way to output a byte. So, when possible everybody should be avoiding
it already.

> And you're still overwriting the POST value written by the BIOS.

Yes, but by the time Linux boots, we should just start putting OUR
values there. If the BIOS goes up to 0x8f, then Linux could start at
0x90 and continue there. I don't have one of those thingies, so I
don't know what the last value would be that the BIOS leaves there.

				Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

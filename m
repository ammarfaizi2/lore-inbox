Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbQKVK2W>; Wed, 22 Nov 2000 05:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbQKVK2M>; Wed, 22 Nov 2000 05:28:12 -0500
Received: from 13dyn94.delft.casema.net ([212.64.76.94]:34834 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129873AbQKVK2I>; Wed, 22 Nov 2000 05:28:08 -0500
Message-Id: <200011220957.KAA26634@cave.bitwizard.nl>
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
In-Reply-To: <E13yNHb-0005O4-00@the-village.bc.nu> from Alan Cox at "Nov 21,
 2000 11:57:02 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 22 Nov 2000 10:57:53 +0100 (MET)
CC: jpranevich@lycos-inc.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > module that is pulling the definition of udelay() from asm/delay.h, it's
> > referencing __bad_udelay(). However, I can't seem to find the __bad_udelay()
> > function actually defined anyplace. (Although it could be somewhere in the
> > kernel source that my grep missed.)
> 
> Its intentionally missing

Alan, Linus, 

Would it be an idea to define __bad_udelay() somewhere? (No don't stop
reading!) ....

.... Inside a #if 0. This question keeps on popping up, and people
seem to be able to grep for definitions of stuff well enough. Then
near the definition you can explain this. It's a form of documenting
this "trick"...

#if 0
/* Note: This definition is not for real. The idea about __bad_udelay is
that you get a compile-time error if you call udelay with a number of 
microseconds that is too large for udelay. There is mdelay if you need 
delays on the order of miliseconds. Please update the places where
udelay is called with this large constant!

If you change the #if 0 to #if 1, the stuff you're trying to compile will
compile, but you'll crash your system when it's used.
*/

#define __bad_udelay() panic("Udelay called with too large a constant")
#endif


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

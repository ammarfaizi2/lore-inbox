Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132764AbQK3KSb>; Thu, 30 Nov 2000 05:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132780AbQK3KSV>; Thu, 30 Nov 2000 05:18:21 -0500
Received: from 13dyn240.delft.casema.net ([212.64.76.240]:16144 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S132764AbQK3KSG>; Thu, 30 Nov 2000 05:18:06 -0500
Message-Id: <200011300947.KAA27728@cave.bitwizard.nl>
Subject: Re: [PATCH] New user space serial port driver
In-Reply-To: <Pine.LNX.4.21.0011300817320.846-100000@penguin.homenet> from Tigran
 Aivazian at "Nov 30, 2000 08:22:13 am"
To: Tigran Aivazian <tigran@veritas.com>
Date: Thu, 30 Nov 2000 10:47:34 +0100 (MET)
CC: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> On Thu, 30 Nov 2000, Patrick van de Lageweg wrote:
> > +static struct tty_struct * ussp_table[USSP_MAX_PORTS] = { NULL, };
> 
> this wastes at least 4 * USSP_MAX_PORTS bytes in the kernel image.
> Typically around 64 bytes but could be more. For more info see the recent
> silly flamewars on the list.

And I think the guys who were saying that the "documentation is more
important than those few bytes" were winning. 

I am one of those guys. I think the documentation aspect is much more
important than those 64 bytes.

> The correct way is not to initialize the data
> to zero explicitly as BSS is cleared automatically on boot. It is also
> probably documented in the lkml FAQ at the bottom of this message.
> 
> Also, it makes your code look consistent as, e.g. in cases below you do
> the right thing:
> 
> > +static struct termios    * ussp_termios[USSP_MAX_PORTS];
> > +static struct termios    * ussp_termios_locked[USSP_MAX_PORTS];

this SHOULD mean that these are first initialized before use. 

If you think they can be used before first being initialized by the
code, then that's a bug, and I'll look into it.

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

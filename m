Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268845AbRG0NKQ>; Fri, 27 Jul 2001 09:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268842AbRG0NKK>; Fri, 27 Jul 2001 09:10:10 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:29958 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S268843AbRG0NJx>; Fri, 27 Jul 2001 09:09:53 -0400
Date: Fri, 27 Jul 2001 14:04:32 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cg14 frambuffer bug in 2.2.19 (and probably 2.4.x as well)
In-Reply-To: <15201.14426.240997.18614@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0107271357550.2983-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, David S. Miller wrote:

> I've made this change in both my 2.2.x and 2.4.x trees.
> Thanks a lot for hunting this down and making a fix.

Is the 2.4.7 fix anything like this:

       if (c->enable) {
                u8 tmp = sbus_readb(&cur->ccr);

                tmp |= CG14_CCR_ENABLE;
                sbus_writeb(tmp, &cur->ccr);
        }
        else {
                u8 tmp = sbus_readb(&cur->ccr);

                tmp &= ~CG14_CCR_ENABLE;
                sbus_writeb(tmp, &cur->ccr);
        }

It looks a bit ugly though. I'd prefer:

	u8 tmp = sbus_readb(&cur->ccr);

	if (c->enable)
		tmp != CG14_CCR_ENABLE;
	else
		tmp &= ~CG14_CCR_ENABLE;

	sbus_writeb(tmp, &cur->ccr);

I'll test this as soon as I recompile 2.4.7 with egcs 1.1.2 to prove a
theory of mine that using 2.95.3 results in non-bootable kernels.

PS: I'm still learning the internals of the sparc32 port. Lots of lovely
confusing bits to hack my way through. :o)

-- 
Hey, they *are* out to get you, but it's nothing personal.

http://www.tahallah.demon.co.uk


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282269AbRK2Bm0>; Wed, 28 Nov 2001 20:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282272AbRK2BmQ>; Wed, 28 Nov 2001 20:42:16 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:21092 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282269AbRK2BmG>; Wed, 28 Nov 2001 20:42:06 -0500
Message-ID: <3C059269.92CA09A2@mandrakesoft.com>
Date: Wed, 28 Nov 2001 20:42:01 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David C. Hansen" <haveblue@us.ibm.com>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C057410.3090201@us.ibm.com> <20011128234505.C2561@flint.arm.linux.org.uk> <3C0580A8.5030706@us.ibm.com> <20011129004113.D2561@flint.arm.linux.org.uk> <3C059087.9070900@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David C. Hansen" wrote:
> 
> Russell King wrote:
> 
> >The BKL is only held for the duration of the open, not until you close the
> >device.
> >
> I'll need to go back and review the changes to the char and block
> devices.  I believe that a big chunk of the drivers that we changed were
> misc drivers, so I might still be in luck.
> 
> Does everyone agree that we need to get the BKL out of common areas like
> this?  For starters, what about adding a pair of spinlocks for block
> devices and character devices to take the place of the BKL in
> serializing opens?  Or, should we make it the driver's responsibility
> completely?

Ideally we should eliminate the BKL completely...  but you need to
review tons of code when messing around with it, which makes removal
annoying.  Al Viro seems to know this stuff pretty well, and possibly
has plans to remove BKL from various bits of the fs's.

Alan Cox made the comment on IRC that BKL was put into the release
method in 2.4 to synchronize open-close-power management.  Don't forget
to take that third into account either, in the cases where such applies.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


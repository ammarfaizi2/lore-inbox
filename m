Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbRFBMhH>; Sat, 2 Jun 2001 08:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbRFBMg5>; Sat, 2 Jun 2001 08:36:57 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4519 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262548AbRFBMgl>;
	Sat, 2 Jun 2001 08:36:41 -0400
Message-ID: <3B18DDD6.9D20C5D4@mandrakesoft.com>
Date: Sat, 02 Jun 2001 08:36:38 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139too in 2.4.5
In-Reply-To: <UTC200106021230.OAA182199.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> My RTL8139 (Identified 8139 chip type 'RTL-8139A')
> was fine in 2.4.3 and doesnt work in 2.4.5.
> Copying the 2.4.3 version of 8139too.c makes things work again.
> 
> Since lots of people complained about this, I have not tried to
> debug - maybe a fixed version already exists?
> 
> One remark:
> 2.4.5 says "eth1: media is unconnected, link down, or incompatible connection"
> coming from 8139too.c line 1367. The code there is
> 
>         if (mii_reg5) {
>                 printk(KERN_INFO"%s: Setting %s%s-duplex based on"
>                         " auto-negotiated partner ability %4.4x.\n", dev->name,
>                         mii_reg5 == 0 ? "" :
>                         (mii_reg5 & 0x0180) ? "100mbps " : "10mbps ",
>                         tp->full_duplex ? "full" : "half", mii_reg5);
>         } else {
>                 printk(KERN_INFO"%s: media is unconnected, link down, "
>                         "or incompatible connection\n",
>                         dev->name);
>         }
> 
> where mii_reg5 is tested against zero inside a conditional
> where we know that it is nonzero.
> Probably the outer test is wrong.

good spotting, though, it's the inner test that's wrong, and surrounding
logic.  If the link partner is not advertising anything at all, mii_reg5
will be zero.  But, if we are forcing media type, mii_reg5 might be zero
and we don't care, so people get a misinformative message.  Not the core
problem (working on it) but a bug nonetheless.

	Jeff


-- 
Jeff Garzik      | Echelon words of the day, from The Register:
Building 1024    | FRU Lebed HALO Spetznaz Al Amn al-Askari Glock 26 
MandrakeSoft     | Steak Knife Kill the President anarchy echelon
                 | nuclear assassinate Roswell Waco World Trade Center

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280841AbRKGQ2a>; Wed, 7 Nov 2001 11:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280846AbRKGQ2U>; Wed, 7 Nov 2001 11:28:20 -0500
Received: from adsl-80-120-185.dab.bellsouth.net ([65.80.120.185]:39627 "EHLO
	midgaard.darktech.org") by vger.kernel.org with ESMTP
	id <S280841AbRKGQ2H>; Wed, 7 Nov 2001 11:28:07 -0500
Date: Wed, 7 Nov 2001 11:28:09 -0500
From: Andreas Boman <aboman@nerdfest.org>
To: Maxwell Spangler <maxwax@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon Bug Stomper Success Reports for 2.4.14
Message-Id: <20011107112809.06a64a94.aboman@nerdfest.org>
In-Reply-To: <Pine.LNX.4.33.0111070045320.20152-100000@tyan.doghouse.com>
In-Reply-To: <Pine.LNX.4.33.0111070045320.20152-100000@tyan.doghouse.com>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i386-nerdfest-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a abit KT7A board (via kt133a chipset). This board has an "Enhance Chip Performence" option in BIOS, previously I have been able to boot athlon optimized kernels with that option off, and anything but athlon optimized kernels with it on. Now with 2.4.14 I can boot an Athlon optimized kernel with it on. (I wonder what that option _really_ does -guess I'll have to find some benchmark to run now...)


	Andreas

On Wed, 7 Nov 2001 00:54:06 -0500 (EST)
Maxwell Spangler <maxwax@mindspring.com> wrote:

> 
> My Athlon Thunderbird has been happily compiling kernels for over 24 hours
> straight using 2.4.14 with an Athlon-optimized kernel.  It could not do this
> in many past kernels and I believe the code snippet offered in September is
> working nicely.  There was a long thread about this back then, but I haven't
> seen any Athlon problem reports between that time and now.  For the lurkers on
> the list, and the benefit of archives, could we please record a few successes?
> 
> If you are using an Athlon with 2.4.14 and you previously had problems but now
> have stability with an Athlon optimized, kernel, please respond.  (Just a few
> people, please.)
> 
> Oh, hardware is Tyan Trinity KT-A (S2390B) with Athlon Thunderbird 1.2Ghz,
> 512M Crucial PC133 Cas2 RAM, many drives..etc.
> 
> My sincere appreciation and thanks to all that were involved in tracking this
> down and making the fix possible.
> 
> /*
>  * Nobody seems to know what this does. Damn.
>  *
>  * But it does seem to fix some unspecified problem
>  * with 'movntq' copies on Athlons.
>  *
>  * VIA 8363 chipset:
>  *  - bit 7 at offset 0x55: Debug (RW)
>  */
> static void __init pci_fixup_via_athlon_bug(struct pci_dev *d)
> {
>   u8 v;
>   pci_read_config_byte(d, 0x55, &v);
>   if (v & 0x80) {
>     printk("Trying to stomp on Athlon bug...\n");
>     v &= 0x7f; /* clear bit 55.7 */
>     pci_write_config_byte(d, 0x55, v);
>   }
> }
> 
> -------------------------------------------------------------------------------
> Maxwell Spangler
> Program Writer
> Greenbelt, Maryland, U.S.A.
> Washington D.C. Metropolitan Area
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280777AbRKGF6T>; Wed, 7 Nov 2001 00:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280776AbRKGF57>; Wed, 7 Nov 2001 00:57:59 -0500
Received: from jgateadsl.cais.net ([205.252.5.196]:2081 "EHLO
	tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S280779AbRKGF5t>; Wed, 7 Nov 2001 00:57:49 -0500
Date: Wed, 7 Nov 2001 00:54:06 -0500 (EST)
From: Maxwell Spangler <maxwax@mindspring.com>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: <linux-kernel@vger.kernel.org>
Subject: Athlon Bug Stomper Success Reports for 2.4.14
Message-ID: <Pine.LNX.4.33.0111070045320.20152-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My Athlon Thunderbird has been happily compiling kernels for over 24 hours
straight using 2.4.14 with an Athlon-optimized kernel.  It could not do this
in many past kernels and I believe the code snippet offered in September is
working nicely.  There was a long thread about this back then, but I haven't
seen any Athlon problem reports between that time and now.  For the lurkers on
the list, and the benefit of archives, could we please record a few successes?

If you are using an Athlon with 2.4.14 and you previously had problems but now
have stability with an Athlon optimized, kernel, please respond.  (Just a few
people, please.)

Oh, hardware is Tyan Trinity KT-A (S2390B) with Athlon Thunderbird 1.2Ghz,
512M Crucial PC133 Cas2 RAM, many drives..etc.

My sincere appreciation and thanks to all that were involved in tracking this
down and making the fix possible.

/*
 * Nobody seems to know what this does. Damn.
 *
 * But it does seem to fix some unspecified problem
 * with 'movntq' copies on Athlons.
 *
 * VIA 8363 chipset:
 *  - bit 7 at offset 0x55: Debug (RW)
 */
static void __init pci_fixup_via_athlon_bug(struct pci_dev *d)
{
  u8 v;
  pci_read_config_byte(d, 0x55, &v);
  if (v & 0x80) {
    printk("Trying to stomp on Athlon bug...\n");
    v &= 0x7f; /* clear bit 55.7 */
    pci_write_config_byte(d, 0x55, v);
  }
}

-------------------------------------------------------------------------------
Maxwell Spangler
Program Writer
Greenbelt, Maryland, U.S.A.
Washington D.C. Metropolitan Area


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbQLTLDk>; Wed, 20 Dec 2000 06:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbQLTLDa>; Wed, 20 Dec 2000 06:03:30 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:46596 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S129735AbQLTLDW>; Wed, 20 Dec 2000 06:03:22 -0500
Date: Wed, 20 Dec 2000 12:32:54 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Cc: Kurt Garloff <garloff@suse.de>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001220123254.A208@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Kurt Garloff <garloff@suse.de>
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu> <20001217125656.A309@elektroni.ee.tut.fi> <20001217163802.O2589@garloff.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217163802.O2589@garloff.suse.de>; from garloff@suse.de on Sun, Dec 17, 2000 at 04:38:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2000 at 04:38:02PM +0100, Kurt Garloff wrote:
> On Sun, Dec 17, 2000 at 12:56:56PM +0200, Petri Kaukasoina wrote:
> > I guess the new memory detect does not work correctly with my old work
> > horse. It is a 100 MHz pentium with 56 Megs RAM. AMIBIOS dated 10/10/94 with
> > a version number of 51-000-0001169_00111111-101094-SIS550X-H.
> > 
> > 2.2.18 reports:
> > Memory: 55536k/57344k available (624k kernel code, 412k reserved, 732k data, 40k init)
> > 
> > 2.2.19pre2 reports:
> > Memory: 53000k/54784k available (628k kernel code, 408k reserved, 708k data, 40k init)
> > 
> > 57344k is 56 Megs which is correct.
> > 54784k is only 53.5 Megs.
> 
> It's this patch that changes things for you:
> o       E820 memory detect backport from 2.4            (Michael Chen)
> 
> The E820 memory detection parses a list from the BIOS, which specifies
> the amount of memory, holes, reserved regions, ...
> Apparently, your BIOS does not do it completely correctly; otherwise you
> should have had crashes before ...

OK, I booted 2.4.0-test12 which even prints that list:

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000003480000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000100000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000100000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Memory: 52232k/54784k available (831k kernel code, 2164k reserved, 62k data, 168k init, 0k highmem)

The last three reserved lines correspond to the missing 2.5 Megs. What are
they? 2.2.18 sees all 56 Megs and works ok and after adding mem=56M on the
kernel command line even 2.2.19pre2 works ok with all the 56 Megs. No
crashes.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

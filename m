Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272472AbRIOSCu>; Sat, 15 Sep 2001 14:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272466AbRIOSCl>; Sat, 15 Sep 2001 14:02:41 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:39177 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S272458AbRIOSCa>;
	Sat, 15 Sep 2001 14:02:30 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100300b7c94753f227@[192.168.239.101]>
In-Reply-To: <01091510441001.00174@c779218-a>
In-Reply-To: <E15i2Bp-00017m-00@the-village.bc.nu>
 <01091510441001.00174@c779218-a>
Date: Sat, 15 Sep 2001 19:02:37 +0100
To: tegeran@home.com
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > +static void __init pci_fixup_athlon_bug(struct pci_dev *d)
>>  > +{
>>  > +       u8 v;
>>  > +       pci_read_config_byte(d, 0x55, &v);
>>  > +       if(v & 0x80) {
>>  > +               printk(KERN_NOTICE "Stomping on Athlon bug.\n");
>>  > +               v &= 0x7f; /* clear bit 55.7 */
>>  > +               pci_write_config_byte(d, 0x55, v);
>>  > +       }
>>  > +}
>>  >
>>  > Well, these are cosmetic changes anyway...
>>  > What is more important now:
>>  > 1) Do we have people who still see Athlon bug with the patch?
>>  > 2) Do Alan read these messages? ;-)
>>
>>  Im watching the discussion with interest. If it proves to be the magic
>>  bullet I will ask VIA for guidance on the issue
>
>Not being a developer or guru on the internal software workings of the
>hardware here, I have to ask, does this clear up some bug, or does it
>disable the optimizations causing the problem? Is this a *fix* or a
>band-aid?

AFAICT, it's a *fix*.  The register in question is "for debug use 
only, never write anything other than zero in it" but generally shows 
non-zero when a faulty BIOS is installed.  We're zeroing the bit that 
appears to cause the problem.  It's highly unlikely to be an extra 
optimisation - if it is, it's an unsafe one.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.

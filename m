Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUHSXMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUHSXMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbUHSXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:12:27 -0400
Received: from web14926.mail.yahoo.com ([216.136.225.84]:13659 "HELO
	web14926.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267517AbUHSXMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:12:03 -0400
Message-ID: <20040819231158.97039.qmail@web14926.mail.yahoo.com>
Date: Thu, 19 Aug 2004 16:11:58 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Martin Mares <mj@ucw.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040819140152.GB12634@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Martin Mares <mj@ucw.cz> wrote:
> I was thinking again about the VGA ROM's and I tend to believe that
> even if you happen to guess correctly where is the ROM shadowed, it
> would be better to show the _original_ ROM image and deliver the
> shadow copy as a separate file. (If somebody decides to initialize 
> the VGA manually by running the code in the ROM, is the shadow copy
> any better?)

The shadowing logic is a must have for laptops. BenH and I discovered
this the hard way. Some laptops take the system and video ROM images,
combine them and then compress them into a ROM. At boot time these ROM
images are decompressed into RAM at C0000 and F0000. For these system
the only place to get the ROM data for things like video timings is
from the shadow area. Putting the shadow logic into the shared ROM code
lets up remove it from all of the video drivers. This lets us write
video drivers that don't care if the card is primary or secondary.

Video cards that are using the shadow copy don't need to be initially
reset. Since they are your boot display the system BIOS must have
already initialized them. Instead the you need the shadow image since
it may contain the timing data needed to change modes on a laptop display.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail

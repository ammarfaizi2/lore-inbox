Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbSKKJiQ>; Mon, 11 Nov 2002 04:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265988AbSKKJiP>; Mon, 11 Nov 2002 04:38:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3508 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265987AbSKKJiP>;
	Mon, 11 Nov 2002 04:38:15 -0500
Date: Mon, 11 Nov 2002 01:43:28 -0800 (PST)
Message-Id: <20021111.014328.87369858.davem@redhat.com>
To: geert@linux-m68k.org
Cc: alan@lxorguk.ukuu.org.uk, hch@infradead.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0211111029030.20946-100000@vervain.sonytel.be>
References: <1036939080.1005.10.camel@irongate.swansea.linux.org.uk>
	<Pine.GSO.4.21.0211111029030.20946-100000@vervain.sonytel.be>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Geert Uytterhoeven <geert@linux-m68k.org>
   Date: Mon, 11 Nov 2002 10:31:23 +0100 (MET)

[ Doug, you should just care about my eh_reset callback comments ]

   On 10 Nov 2002, Alan Cox wrote:
   > Reset is called with the lock held surely. How can the wait_event be
   > right ? 
   
   I don't know. I just ported the Sun/SPARC ESP SCSI driver changes in 2.5.45 to
   the NCR53C9x ESP SCSI drivers. If you're right, the same bug is present in
   esp.c.
   
   Dave?
   
That's a little inconvenient.

I have to wait for an interrupt from the chip to know the RESET
started by the eh_reset_bus_handler code is done, and I'm certainly
not going to spin there for 5 seconds or however long it decides to
take. :-)

Either eh_reset_bus_handler needs to be allowed to sleep, or it needs
to be changed so that an "RESET in progress, please wait" status can
be returned.

Doug?

   BTW, what about merging esp.c and NCR53C9x.c?
   
I don't have the time to abstract away all of the various DMA portion
of the ESP chip handling to allow that.  There are 12 different
combinations of ESP + DMA controller combinations on Sparc, so if you
do the changes you'll need to test that :-)

Franks a lot,
David S. Miller
davem@redhat.com

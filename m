Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131459AbQK2OG3>; Wed, 29 Nov 2000 09:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131483AbQK2OGU>; Wed, 29 Nov 2000 09:06:20 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:8421 "EHLO
        asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
        id <S131459AbQK2OGJ>; Wed, 29 Nov 2000 09:06:09 -0500
Date: Wed, 29 Nov 2000 15:35:26 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Subject: Re: test12-pre2
Message-ID: <20001129153526.W13759@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.10.10011271838080.15454-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10011271838080.15454-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 27, 2000 at 06:45:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 06:45:31PM -0800, Linus Torvalds wrote:
> Due to the birth of my third daughter last week (yes, I got /.'ed), if you
> sent me patches that aren't in pre2, you can pretty much consider them
> lost.

Congrats ;-)

>     - Kai Germaschewski: ISDN updates

There seem to be a questionable part of it (didn't see this part
on linux-kernel, why?).

diff -u --recursive --new-file v2.4.0-test11/linux/drivers/isdn/hisax/bkm_a8.c linux/drivers/isdn/hisax/bkm_a8.c
--- v2.4.0-test11/linux/drivers/isdn/hisax/bkm_a8.c	Mon Aug 21 07:49:02 2000
+++ linux/drivers/isdn/hisax/bkm_a8.c	Mon Nov 27 16:53:43 2000
@@ -282,17 +283,17 @@
 	return(0);
 }
 
-static struct pci_dev *dev_a8 __initdata = NULL;
-static u16  sub_vendor_id __initdata = 0;
-static u16  sub_sys_id __initdata = 0;
-static u_char pci_bus __initdata = 0;
-static u_char pci_device_fn __initdata = 0;
-static u_char pci_irq __initdata = 0;
+static struct pci_dev *dev_a8 __initdata;
+static u16  sub_vendor_id __initdata;
+static u16  sub_sys_id __initdata;
+static u_char pci_bus __initdata;
+static u_char pci_device_fn __initdata;
+static u_char pci_irq __initdata;
 
 #endif /* CONFIG_PCI */
 
-__initfunc(int
-setup_sct_quadro(struct IsdnCard *card))
+int __init
+setup_sct_quadro(struct IsdnCard *card)
 {
 #if CONFIG_PCI
 	struct IsdnCardState *cs = card->cs;

IIRC variables marked as "__initdata" need to be explicitly set
even to zero, because gcc won't put them into the right section
otherwise. One of Tigran's patches has been reverted because of
this.

So please reconsider this chunk and prove me wrong if I'm ;-)

PS: Same goes for several other chunks in the submitted
   ISDN-Patch. 
   
PPS: No, this is not fixed in pre3.

Regards

Ingo Oeser
-- 
To the systems programmer, users and applications
serve only to provide a test load.
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbTBFWxS>; Thu, 6 Feb 2003 17:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTBFWxS>; Thu, 6 Feb 2003 17:53:18 -0500
Received: from AMarseille-201-1-3-171.abo.wanadoo.fr ([193.253.250.171]:64295
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267678AbTBFWxR>; Thu, 6 Feb 2003 17:53:17 -0500
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: rossb@google.com, alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030206132043.1896a1c2.skraw@ithnet.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	 <3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>
	 <3E3D6367.9090907@pobox.com> <20030205104845.17a0553c.skraw@ithnet.com>
	 <1044443761.685.44.camel@zion.wanadoo.fr> <3E414243.4090303@google.com>
	 <1044465151.685.149.camel@zion.wanadoo.fr>
	 <20030206132043.1896a1c2.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044572658.6330.51.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Feb 2003 00:04:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 13:20, Stephan von Krawczynski wrote:
> On 05 Feb 2003 18:12:31 +0100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> 
> > Stephan: Can you try editing ide-dma.c, function
> > __ide_dma_test_irq(), and remove that line:
> > 
> > -	drive->waiting_for_dma++;
> > 
> > And tell us if it helps in any way.
> > 
> > Ben.
> 
> Hello Ben,
> 
> as requested I tried the above "patch" and had no problem so far. Current
> situation is:
> (ide2, ide3 are PDC, eth2 is tg3)

Ok, well, if it' still stable by now, I beleive we can safely remove
that line from ide_dma_test_irq(). AFAIK, it really have nothing to do
here.

(I suspect it got copied from ide-pmac somewhat... I use it as a counter
in there to implement some timeout when the DMA engine didn't start at
all because the disk issued an error, and on these, I know for sure
the IRQ isn't shared...)

Alan, can you include that ?

===== drivers/ide/ide-dma.c 1.10 vs edited =====
--- 1.10/drivers/ide/ide-dma.c  Sat Feb  1 20:37:36 2003
+++ edited/drivers/ide/ide-dma.c        Fri Feb  7 00:03:43 2003
@@ -826,7 +826,6 @@
        if (!drive->waiting_for_dma)
                printk(KERN_WARNING "%s: (%s) called while not
waiting\n",
                        drive->name, __FUNCTION__);
-       drive->waiting_for_dma++;
        return 0;
 }

(Patch against Marcelo's 2.4.21-pre4)



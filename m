Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264353AbRFLMc0>; Tue, 12 Jun 2001 08:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264361AbRFLMcP>; Tue, 12 Jun 2001 08:32:15 -0400
Received: from kosmo.edeal.de ([62.40.13.104]:45072 "EHLO kosmo.edeal.de")
	by vger.kernel.org with ESMTP id <S264353AbRFLMcG>;
	Tue, 12 Jun 2001 08:32:06 -0400
Date: Tue, 12 Jun 2001 14:31:42 +0200
From: Lukas Schroeder <lukas@edeal.de>
To: Ben Pfaff <pfaffben@msu.edu>
Cc: Alan Cox <alan@redhat.com>, Lukas Schroeder <lukas@edeal.de>,
        zab@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] ess maestro, support for hardware volume control
Message-ID: <20010612143142.A17450@kosmo.edeal.de>
In-Reply-To: <200106091931.f59JVw731673@devserv.devel.redhat.com> <87elst2vr2.fsf@pfaffben.user.msu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87elst2vr2.fsf@pfaffben.user.msu.edu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the little patch below (vs. 2.4.5-ac13) fixes a freeze which happens
when the maestro module was unloaded and a HWV button gets pushed 
generating the interrupt. so this disables all irqs of that chip 
on remove...


regards,
  lukas

--- linux-2.4.5-ac13/drivers/sound/maestro.c    Tue Jun 12 13:41:24 2001
+++ linux/drivers/sound/maestro.c       Tue Jun 12 14:13:40 2001
@@ -3575,6 +3575,12 @@
        struct ess_card *card = pci_get_drvdata(pcidev);
        int i;
 
+       /* turn off all irqs; _especially_ the one for hardware volume
+          control (bit 6), which locks the machine dead when occurring after
+          the maestro module was removed.
+        */
+       outw(0x0, card->iobase+0x18);
+
        /* XXX maybe should force stop bob, but should be all 
                stopped by _release by now */
        free_irq(card->irq, card);



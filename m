Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSGXNnl>; Wed, 24 Jul 2002 09:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSGXNnl>; Wed, 24 Jul 2002 09:43:41 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:5073 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S317278AbSGXNnj>; Wed, 24 Jul 2002 09:43:39 -0400
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Boot problem, 2.4.19-rc3-ac1
References: <9cfu1mp5kru.fsf@rogue.ncsl.nist.gov>
	<20020724131828.GF20028@alhambra.actcom.co.il>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 24 Jul 2002 09:46:49 -0400
In-Reply-To: <20020724131828.GF20028@alhambra.actcom.co.il>
Message-ID: <9cfk7nl5jcm.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@actcom.co.il> writes:

> On Wed, Jul 24, 2002 at 09:16:05AM -0400, Ian Soboroff wrote:
> 
> [snipped]
> 
> > [1] Actually, two one-liner patches... one to extend the ext3 journal
> > commit interval to 30 seconds, and another to fix suspend issues in
> > sound/trident.c.
> 
> what's the suspend issue with trident.c? 

Haven't witnessed personally.  Reference web pages (from Linux on
Laptops) are
http://www.geocities.com/robm351/lifebook/ and
http://www4.ncsu.edu/~tscoffe2/Fujitsu/

Apparently there is a problem with losing sound after a suspend.
Another reported fix is to reload the trident.o module.  The patch I
use (credited to Eric Lemar) is:

--- linux/drivers/sound/trident.c       Thu Mar 28 16:08:51 2002
+++ linux/drivers/sound/trident_new.c   Thu Mar 28 16:11:20 2002
@@ -3456,7 +3456,7 @@
 
 static int trident_suspend(struct pci_dev *dev, u32 unused)
 {
-       struct trident_card *card = (struct trident_card *) dev;
+       struct trident_card *card = pci_get_drvdata(dev);
 
        if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
                ali_save_regs(card);
@@ -3466,7 +3466,7 @@
 
 static int trident_resume(struct pci_dev *dev)
 {
-       struct trident_card *card = (struct trident_card *) dev;
+       struct trident_card *card = pci_get_drvdata(dev);
 
        if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
                ali_restore_regs(card);

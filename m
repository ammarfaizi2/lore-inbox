Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269238AbRIFXIw>; Thu, 6 Sep 2001 19:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269274AbRIFXIn>; Thu, 6 Sep 2001 19:08:43 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:45528 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S269238AbRIFXIg>; Thu, 6 Sep 2001 19:08:36 -0400
Date: Fri, 7 Sep 2001 00:08:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Mark W. Eichin" <eichin@thok.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_BLK_DEV_SL82C105 should not be PPC/ARM specific
Message-ID: <20010907000817.G23583@flint.arm.linux.org.uk>
In-Reply-To: <20010906223001.A63F613DC7@kuroneko>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906223001.A63F613DC7@kuroneko>; from eichin@thok.org on Thu, Sep 06, 2001 at 06:30:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 06, 2001 at 06:30:01PM -0400, Mark W. Eichin wrote:
> and if I bludgeon the config so that it actually builds, it does work
> (under 2.2, regrettably in pio-only mode, but I'll try 2.4.9 shortly)

Please report back when you've done your 2.4.9 testing; you might like
to apply the patch PaulM has been bouncing around here trying to get
Linus to accept.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


--mYCpIKhGyMATD0i+
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: rmk@flint.arm.linux.org.uk
Delivery-date: Mon, 03 Sep 2001 13:56:55 +0100
Received: from caramon.arm.linux.org.uk ([192.168.0.1])
	by flint.arm.linux.org.uk with esmtp (Exim 3.16 #1)
	id 15dtHa-0003qn-00
	for rmk@flint.arm.linux.org.uk; Mon, 03 Sep 2001 13:56:55 +0100
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	by caramon.arm.linux.org.uk (8.11.2/8.11.2) with ESMTP id f83Cuq225664
	for <rmk@arm.linux.org.uk>; Mon, 3 Sep 2001 13:56:53 +0100
Received: from [199.183.24.194] (helo=vger.kernel.org)
	by www.linux.org.uk with esmtp (Exim 3.13 #1)
	id 15dtHW-0001Wp-00
	for rmk@lists.arm.linux.org.uk; Mon, 03 Sep 2001 13:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271687AbRICMnF>; Mon, 3 Sep 2001 08:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271686AbRICMmz>; Mon, 3 Sep 2001 08:42:55 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:30219 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S271685AbRICMmi>;
	Mon, 3 Sep 2001 08:42:38 -0400
Received: by lists.samba.org (Postfix, from userid 1020)
	id 45A574699; Mon,  3 Sep 2001 05:40:03 -0700 (PDT)
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15251.31040.478167.658461@tango.paulus.ozlabs.org>
Date: Mon, 3 Sep 2001 22:36:16 +1000 (EST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: trini@kernel.crashing.org, benh@kernel.crashing.org
Subject: [PATCH] [RESEND] remove rubbish from sl82c105.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, drivers/ide/sl82c105.c has two sets of code in it: some
good code done by Russell King, and some old rubbishy code.  Russell's
code is inside #ifdef CONFIG_ARCH_NETWINDER.  I tried Russell's code
on my Longtrail CHRP PPC box and it not only compiles and links ok
(which the old code doesn't), it also works just fine.

So the patch below takes out the CONFIG_ARCH_NETWINDER and the old
code, so we use Russell's code on all platforms.  I put this patch out
on linux-kernel a couple of weeks ago and no one has complained since.
The old code won't link at the moment anyway (it references
ide_special_settings which isn't exported from ide-pci.c).

Linus, please apply this patch to your tree.

Paul.

diff -urN linux/drivers/ide/sl82c105.c linuxppc_2_4/drivers/ide/sl82c105.c
--- linux/drivers/ide/sl82c105.c	Wed Jul  4 14:33:21 2001
+++ linuxppc_2_4/drivers/ide/sl82c105.c	Sun Jul 22 17:58:43 2001
@@ -28,7 +28,6 @@
 
 extern char *ide_xfer_verbose (byte xfer_rate);
 
-#ifdef CONFIG_ARCH_NETWINDER
 /*
  * Convert a PIO mode and cycle time to the required on/off
  * times for the interface.  This has protection against run-away
@@ -272,37 +271,4 @@
 {
 	hwif->tuneproc = tune_sl82c105;
 }
-
-#else
-
-unsigned int pci_init_sl82c105(struct pci_dev *dev, const char *msg)
-{
-	return ide_special_settings(dev, msg);
-}
-
-void dma_init_sl82c105(ide_hwif_t *hwif, unsigned long dma_base)
-{
-	ide_setup_dma(hwif, dma_base, 8);
-}
-
-void __init ide_init_sl82c105(ide_hwif_t *hwif)
-{
-	struct pci_dev *dev = hwif->pci_dev;
-	unsigned short t16;
-	unsigned int t32;
-	pci_read_config_word(dev, PCI_COMMAND, &t16);
-	printk("SL82C105 command word: %x\n",t16);
-        t16 |= PCI_COMMAND_IO;
-        pci_write_config_word(dev, PCI_COMMAND, t16);
-	/* IDE timing */
-	pci_read_config_dword(dev, 0x44, &t32);
-	printk("IDE timing: %08x, resetting to PIO0 timing\n",t32);
-	pci_write_config_dword(dev, 0x44, 0x03e4);
-#ifndef CONFIG_MBX
-	pci_read_config_dword(dev, 0x40, &t32);
-	printk("IDE control/status register: %08x\n",t32);
-	pci_write_config_dword(dev, 0x40, 0x10ff08a1);
-#endif /* CONFIG_MBX */
-}
-#endif

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--mYCpIKhGyMATD0i+--

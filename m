Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbUKLXfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbUKLXfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbUKLXdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:33:52 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:31971 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262672AbUKLXWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:36 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017172508@kroah.com>
Date: Fri, 12 Nov 2004 15:21:57 -0800
Message-Id: <11003017171930@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.19, 2004/11/10 16:44:13-08:00, hannal@us.ibm.com

[PATCH] zr36120.c: Convert pci_find_device to pci_dev_present

--On Thursday, September 30, 2004 10:27:48 AM +0200 Gerd Knorr <kraxel@bytesex.org> wrote:
>> The whole driver is CONFIG_BROKEN anyway... I only verified my changes
>> didn't add new compiler errors. What part should I remove? Just this check?
>
> pci/quirks.c does these checks and sets the flags.
> Replacing with a check for "pci_pci_problems & PCIPCI_TRITON" should do.
>
> bttv does simliar things in bttv_check_chipset() (bttv-cards.c),
> you might want to have a look there ...
>

Thanks a lot for your help. Is this what you were thinking?

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/media/video/zr36120.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/media/video/zr36120.c b/drivers/media/video/zr36120.c
--- a/drivers/media/video/zr36120.c	2004-11-12 15:12:34 -08:00
+++ b/drivers/media/video/zr36120.c	2004-11-12 15:12:34 -08:00
@@ -145,14 +145,11 @@
 static
 void __init handle_chipset(void)
 {
-	struct pci_dev *dev = NULL;
-
 	/* Just in case some nut set this to something dangerous */
 	if (triton1)
 		triton1 = ZORAN_VDC_TRICOM;
 
-	while ((dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437, dev)))
-	{
+	if (pci_pci_problems & PCIPCI_TRITON) {
 		printk(KERN_INFO "zoran: Host bridge 82437FX Triton PIIX\n");
 		triton1 = ZORAN_VDC_TRICOM;
 	}


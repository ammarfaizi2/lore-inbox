Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282400AbRLQTRS>; Mon, 17 Dec 2001 14:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282491AbRLQTRJ>; Mon, 17 Dec 2001 14:17:09 -0500
Received: from ns01.netrox.net ([64.118.231.130]:10118 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S282400AbRLQTQ6>;
	Mon, 17 Dec 2001 14:16:58 -0500
Subject: Re: [PATCH] 2.4.16 Fix NULL pointer dereferencing in agpgart_be.c
From: Robert Love <rml@tech9.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Yoshiki Hayashi <yoshiki@xemacs.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0112171555190.3340-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0112171555190.3340-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.10.08.57 (Preview Release)
Date: 17 Dec 2001 14:16:18 -0500
Message-Id: <1008616583.1705.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-17 at 12:55, Marcelo Tosatti wrote:

> Well, Stephan, if you could send me only the part which fixes the oops for
> 2.4.17 then I'll be happy.

This patch is sufficient to prevent the oops (check for null pointer),
but as said the full patch from Nicolas is needed for completely correct
operation.

--- linux-2.4.17-rc1/drivers/char/agp/agpgart_be.c      Sat Nov 17 03:11:22 2001
+++ linux/drivers/char/agp/agpgart_be.c       Sat Dec 15 12:02:51 2001
@@ -3879,7 +3879,7 @@
                        i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
                                                                           PCI_DEVICE_ID_INTEL_830_M_1,
                                                                           NULL);
-                       if(PCI_FUNC(i810_dev->devfn) != 0) {
+                       if(i810_dev != NULL && PCI_FUNC(i810_dev->devfn) != 0) {
                                i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
                                                                                   PCI_DEVICE_ID_INTEL_830_M_1,
                                                                                   i810_dev);

	Robert Love


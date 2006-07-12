Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWGLGxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWGLGxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWGLGxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:53:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:13797 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750756AbWGLGxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:53:16 -0400
Message-ID: <44B49CAB.60206@manoweb.com>
Date: Wed, 12 Jul 2006 08:54:35 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
CC: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch>
In-Reply-To: <200607010003.31324.daniel.ritz-ml@swissonline.ch>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Ritz wrote:

> register is hidden at the very same place (32bit at 0x90 in function 3 of the
> "south" brigde)...so the attached little patch might be enough to fix things...
> 
> Alessio, could you try that one on top of a kernel that shows the problem?

well sorry for being so late but I had some lectures to do and... by the
way, everybody on this msiling list is officially invited at the
Planetarium of Lecco - if you happen to pass by northern Italy just drop
me an email... :)

You know... this patch works :)
I'm now running the latest kernel in the git repository with APM enabled
and everything is working fine! I will qute the patch below.

Thank you
Alessio Sangalli

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4364d79..1d26a64 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -401,6 +401,8 @@ static void __devinit quirk_piix4_acpi(s
 	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi );
+

 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by
longwords at

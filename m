Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVAEJfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVAEJfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVAEJfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:35:31 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:10365 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262300AbVAEJfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:35:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=uGXAspS3OZ7QrcCnzZcCt/6YjsTuTLULFe3nf5XA8Eo27f916CHFPUHNn9vtp+THJVAhJQUN9lsT1r9WpNUR/LxRjXQChMVN/5vhE++d3XBaqSIX9ePA6b9qIFuD/MdXY4N3aN+Kwr6heKU6B/an+ph4XoCgMl7PL5IpceNQv2c=
Message-ID: <799406d6050105013552d3e87b@mail.gmail.com>
Date: Wed, 5 Jan 2005 09:35:15 +0000
From: Adam Mercer <ramercer@gmail.com>
Reply-To: Adam Mercer <ramercer@gmail.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.6.10-ac3 compile failure
Cc: list linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <41DB3733.3060002@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_97_28150671.1104917715808"
References: <41DB3733.3060002@eyal.emu.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_97_28150671.1104917715808
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 05 Jan 2005 11:39:15 +1100, Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>    CC [M]  drivers/char/agp/intel-agp.o
> drivers/char/agp/intel-agp.c: In function `intel_i915_configure':
> drivers/char/agp/intel-agp.c:640: error: too many arguments to function `writel'
> make[3]: *** [drivers/char/agp/intel-agp.o] Error 1

Applying this patch worked for me

Cheers

Adam

------=_Part_97_28150671.1104917715808
Content-Type: text/x-patch; name="intel-agp-2.6.10-ac3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="intel-agp-2.6.10-ac3.patch"

--- drivers/char/agp/intel-agp.c-orig=092005-01-04 19:59:59.000000000 +0000
+++ drivers/char/agp/intel-agp.c=092005-01-04 19:50:56.000000000 +0000
@@ -637,7 +637,7 @@
 =09gmch_ctrl |=3D I830_GMCH_ENABLED;
 =09pci_write_config_word(agp_bridge->dev,I830_GMCH_CTRL,gmch_ctrl);
=20
-=09writel(agp_bridge->gatt_bus_addr | I810_PGETBL_ENABLED, intel_i830_priv=
ate.registers,I810_PGETBL_CTL);
+=09writel(agp_bridge->gatt_bus_addr | I810_PGETBL_ENABLED, intel_i830_priv=
ate.registers+I810_PGETBL_CTL);
 =09readl(intel_i830_private.registers+I810_PGETBL_CTL);=09/* PCI Posting. =
*/
 =09
 =09if (agp_bridge->driver->needs_scratch_page) {

------=_Part_97_28150671.1104917715808--

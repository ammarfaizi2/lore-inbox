Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753610AbWKFVBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbWKFVBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753753AbWKFVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:01:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:27861 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753610AbWKFVBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:01:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=qzOQsGellfDSGPTpDv0aDTb0zcyjOjCRiLkBKxAOUMRODy1ld6/I5yHdRORbdZr4TfmTv12WAfGIl5O9K4dzWgT1wlWfaCsxomBBJUrJq1CH+PVa1wz4VSB2AHQZKaY+eqPu4ThZbtCgr8/mTd+DwqgUCGS8S+8CzUFd8Z8JvCg=
Date: Mon, 6 Nov 2006 22:01:33 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Conke Hu <conke.hu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add pci revision id to struct pci_dev
Message-ID: <20061106210133.GA9717@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conke Hu <conke.hu@gmail.com> ha scritto:
> Hi all,
>    PCI revision id had better be added to struct pci_dev and
> initialized in pci_scan_device.
[...]
> diff -Nur linux-2.6.19-rc4-git10.orig/include/linux/pci.h
> linux-2.6.19-rc4-git10/include/linux/pci.h
> --- linux-2.6.19-rc4-git10.orig/include/linux/pci.h     2006-11-06
> 19:39:07.000000000 +0800
> +++ linux-2.6.19-rc4-git10/include/linux/pci.h  2006-11-06
> 19:41:57.000000000 +0800
> @@ -123,6 +123,7 @@
>       unsigned short  device;
>       unsigned short  subsystem_vendor;
>       unsigned short  subsystem_device;
> +       u8              revision;       /* PCI revision ID */
>       unsigned int    class;          /* 3 bytes: (base,sub,prog-if) */
>       u8              hdr_type;       /* PCI header type (`multi'
> flag masked out) */
>       u8              rom_base_reg;   /* which config register
> controls the ROM */

Hi,
I've noticed that after the 'class' field there are 3 u8 fields. If you
add the revision there then sizeof(struct pci_dev) stays constant:

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 09be0f8..c8586b7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -124,6 +124,7 @@ struct pci_dev {
 	unsigned short	subsystem_vendor;
 	unsigned short	subsystem_device;
 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
+	u8		revision;	/* PCI revision id */
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 	u8		rom_base_reg;	/* which config register controls the ROM */
 	u8		pin;  		/* which interrupt pin this device uses */


Luca
-- 
E' bene ricordare che l'intero Universo è formato,
con un'unica trascurabile eccezione, dagli "altri".
John Andrew Holmes

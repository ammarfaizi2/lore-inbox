Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbULMVrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbULMVrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULMVrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:47:43 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:19817 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261169AbULMVrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:47:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bbAJRsxpDFwrE9taEjhK9XstaKIEVFvb5N+a0d9d0qbHaVp3dsqn2/qG5CfFT3R6wRKRGmVczuWKRPnT9WQYqZ7JDhw7DCdy6y0PtEGwEhUjSLEpD2T1aUFMkVEXZGl455AlLnla+esi+kFQ9/QCJT9X+NSzU/9X0SYQd9pEVQA=
Message-ID: <58cb370e04121313473057143b@mail.gmail.com>
Date: Mon, 13 Dec 2004 22:47:32 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [2.6.10-rc2+] ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41B36021.5050600@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41B36021.5050600@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Dec 2004 20:23:13 +0100, Rene Herman
<rene.herman@keyaccess.nl> wrote:
> Hi Bart.

Hi,
 
> I see your 2004-11-01 IDE update:
> 
> http://lkml.org/lkml/2004/11/1/158
> 
> obsoleted the idex=ata66 option, saying that it "should be handled by
> host drivers needing it". As far as I can see, amd74xx does not handle this?
> 
> I do need a way to force an 80c cable on this AMD756 (ATA66 max) board,
> since the BIOS doesn't seem to be setting the cable bits correctly.

Ugh, I checked AMD datasheets and AMD756 doesn't support host
side cable detection.  Well, we can try doing disk side only for it.
[ ATi and ITE (in -ac kernels) drivers are also doing this. ]

--- amd74xx.c.orig	2004-11-02 14:17:14.000000000 +0100
+++ amd74xx.c	2004-12-13 22:41:50.406229168 +0100
@@ -344,10 +344,8 @@
 			break;
 
 		case AMD_UDMA_66:
-			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
-			for (i = 24; i >= 0; i -= 8)
-				if ((u >> i) & 4)
-					amd_80w |= (1 << (1 - (i >> 4)));
+			/* no host side cable detection */
+			amd_80w = 0x03;
 			break;
 	}

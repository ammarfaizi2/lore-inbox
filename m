Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWEOV4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWEOV4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWEOV4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:56:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:391 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964831AbWEOV4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:56:00 -0400
Subject: Re: Updated libata PATA patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0605100939r607ef30dya743a7f1a1dbe03f@mail.gmail.com>
References: <1147196676.3172.133.camel@localhost.localdomain>
	 <3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
	 <1147270145.17886.42.camel@localhost.localdomain>
	 <3b0ffc1f0605100905x18d07f76jda38d1807cf9e9d7@mail.gmail.com>
	 <1147279198.19935.6.camel@localhost.localdomain>
	 <3b0ffc1f0605100939r607ef30dya743a7f1a1dbe03f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 23:08:49 +0100
Message-Id: <1147730929.26686.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-10 at 12:39 -0400, Kevin Radloff wrote:
> > I'll do some more digging, but putting printks into ata_qc_issue_prot to
> > see where it explodes is the next step I suspect.
> 
> Ah, I see.. I'll be waiting. :)

Much scratching of heads and tracing later it looks like a libata-core
bug rather than pata_pcmcia. Glad this blew up as its a nasty little bug
if I follow it right

Anyway try this patch as well

--- drivers/scsi/libata-core.c~	2006-05-15 22:38:21.282153688 +0100
+++ drivers/scsi/libata-core.c	2006-05-15 22:38:21.283153536 +0100
@@ -1853,7 +1853,8 @@
 		goto err_out;
 
 	/* step 3: set host DMA timings */
-	ata_host_set_dma(ap);
+	if(dev->dma_mode)
+        	ata_host_set_dma(ap);
 
 	/* step 4: update devices' xfer mode */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {




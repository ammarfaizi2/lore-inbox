Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSKKN0g>; Mon, 11 Nov 2002 08:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265021AbSKKN0g>; Mon, 11 Nov 2002 08:26:36 -0500
Received: from rakis.net ([207.8.143.12]:61314 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S265019AbSKKN0g>;
	Mon, 11 Nov 2002 08:26:36 -0500
Date: Mon, 11 Nov 2002 08:33:13 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status for 10 Nov
In-Reply-To: <Pine.LNX.4.44.0211100834110.16968-100000@dad.molina>
Message-ID: <Pine.LNX.4.42.0211110829150.26970-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Thomas Molina wrote:

> I apologize for not being able to get a report out last week; I'm in the
> middle of a career change (anyone need a system administrator?).  I've
> (mostly) kept up with traffic, but there are a lot of older items I've not
> been able to close out.

> ------------------------------------------------------------------------
>    open   08 Nov 2002 piix driver oops
>   99. http://marc.theaimsgroup.com/?l=linux-kernel&m=103677362411873&w=2

There was apparently a patch to fix this that didn't get included with
2.5.47.  I'm not sure if it's a correct fix or not, but it did stop the
crashes for my machine.

Here it is.

http://www.cs.helsinki.fi/linux/linux-kernel/2002-44/1684.html

--- linux-2.5.46/drivers/ide/ide-dma.c.~1~	2002-11-08 09:29:10.000000000 +0100
+++ linux-2.5.46/drivers/ide/ide-dma.c	2002-11-08 10:05:12.000000000 +0100
@@ -926,7 +926,7 @@
 		request_region(base+16, hwif->cds->extra, hwif->cds->name);
 		hwif->dma_extra = hwif->cds->extra;
 	}
-	hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
+	hwif->dma_master = (hwif->channel && hwif->mate) ? hwif->mate->dma_base : base;
 	if (hwif->dma_base2) {
 		if (!request_region(hwif->dma_base2, ports, hwif->name))
 		{

Gregory Boyce


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269892AbUICW3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269892AbUICW3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269961AbUICW32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:29:28 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:7351 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269892AbUICW27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:28:59 -0400
Date: Fri, 3 Sep 2004 23:28:31 +0100
From: Dave Jones <davej@redhat.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hpt366 ptr use before NULL check.
Message-ID: <20040903222831.GA29492@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20040903211546.GY26419@redhat.com> <20040903215332.GA7812@redhat.com> <200409040017.08272.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409040017.08272.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 12:17:07AM +0200, Bartlomiej Zolnierkiewicz wrote:
 > 
 > bogus, hwif can't be NULL
 > please remove checks instead


As you wish.


Signed-off-by: Dave Jones <davej@redhat.com>

--- latest-FC2/drivers/ide/pci/hpt366.c~	2004-09-03 23:26:29.092342152 +0100
+++ latest-FC2/drivers/ide/pci/hpt366.c	2004-09-03 23:27:28.249348920 +0100
@@ -777,9 +777,6 @@
 	u8 reg59h = 0, reset	= (hwif->channel) ? 0x80 : 0x40;
 	u8 regXXh = 0, state_reg= (hwif->channel) ? 0x57 : 0x53;
 
-	if (!hwif)
-		return -EINVAL;
-
 //	hwif->bus_state = state;
 
 	pci_read_config_byte(dev, 0x59, &reg59h);
@@ -813,9 +810,6 @@
 	u8 tristate = 0, resetmask = 0, bus_reg = 0;
 	u16 tri_reg;
 
-	if (!hwif)
-		return -EINVAL;
-
 	hwif->bus_state = state;
 
 	if (hwif->channel) { 

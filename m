Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTHYKzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTHYKzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:55:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1798 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261712AbTHYKzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:55:41 -0400
Date: Mon, 25 Aug 2003 11:55:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mario Mikocevic <mario.mikocevic@htnet.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test4 repeatable
Message-ID: <20030825115538.C30952@flint.arm.linux.org.uk>
Mail-Followup-To: Mario Mikocevic <mario.mikocevic@htnet.hr>,
	linux-kernel@vger.kernel.org
References: <20030825091846.GA15017@danielle.hinet.hr> <20030825104035.B30952@flint.arm.linux.org.uk> <20030825102504.GC14801@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825102504.GC14801@danielle.hinet.hr>; from mario.mikocevic@htnet.hr on Mon, Aug 25, 2003 at 12:25:04PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 12:25:04PM +0200, Mario Mikocevic wrote:
> On 2003.08.25 11:40, Russell King wrote:
> > On Mon, Aug 25, 2003 at 11:18:46AM +0200, Mario Mikocevic wrote:
> > > IBM Thinkpad R40 with 2.6.0-test4, alsa compiled as module.
> > > If I plug in D-link DWL-650+ (_just_ a plug in a slot) and _then_
> > > modprobe snd-intel8x0 within seconds this oops barfs on me.
> > 
> > After asking akpm what an "invalid operand" on x86 means, he says its
> > a BUG() statement.  So, can you please supply both the ksymoops'd
> > *and* the raw undecoded kernel messages.  Apparantly ksymoops cuts off
> > the lines which indicate that it was a bug and where the BUG() statement
> > was.

Ok so it isn't a BUG().  The next thing I'd consider is whether it was
a corrupted pci driver list, but it doesn't look like it.

Ok, lets try to get some extra info from your kernel - please apply
the patch below.  This is likely to produce a fair amount of extra
messages at boot.  It should also produce another raft of messages
when you insert the cardbus card but before the module, and another
raft afterwards.

I'm only interested in the ones around the time when you insert the
cardbus card and the module.

--- linux/drivers/pci/pci-driver.c.old	Mon Aug 25 11:51:03 2003
+++ linux/drivers/pci/pci-driver.c	Mon Aug 25 11:52:59 2003
@@ -66,7 +66,8 @@
 {		   
 	int error = -ENODEV;
 	const struct pci_device_id *id;
-
+printk("pci_dev: %s driver: %p ", pci_name(pci_dev), drv);
+printk("name: %s table: %p probe: %p\n", drv->name, drv->id_table, drv->probe);
 	if (!drv->id_table)
 		return error;
 	id = pci_match_device(drv->id_table, pci_dev);


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


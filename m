Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVAMThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVAMThU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVAMTfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:35:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35300 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261208AbVAMQlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:41:49 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111173332.GA17077@muc.de>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
	 <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105626399.4664.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:35:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-11 at 17:33, Andi Kleen wrote:
> > User space does not expect to get dumped with -EBUSY randomly on PCI
> 
> I think it's a reasonable thing to do.  If you prefer you could fake a
> 0xffffffff read, that would look like busy or non existing hardware.
> But the errno would seem to be cleaner to me.

Either will break X.

> > static int pci_user_wait_access(struct pci_dev *pdev) {
> > 	wait_event(&pci_ucfg_wait, dev->block_ucfg_access == 0);
> > }
> 
> I don't like this very much. What happens when the device 
> doesn't get out of BIST for some reason? 

Then you need to switch to wait_event_timeout(). Its not terribly hard
8)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVAKPrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVAKPrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVAKPrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:47:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11988 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262801AbVAKPrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:47:24 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: brking@us.ibm.com
Cc: Andi Kleen <ak@muc.de>, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E3086D.90506@us.ibm.com>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
	 <20050110162950.GB14039@muc.de>  <41E3086D.90506@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105454259.15794.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 11 Jan 2005 14:37:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 22:57, Brian King wrote:
> > For this I would add a semaphore or a lock bit to pci_dev.
> > Probably a simple flag is good enough that is checked by sysfs/proc
> > and return EBUSY when set. 
> 
> How about something like this... (only compile tested at this point)


User space does not expect to get dumped with -EBUSY randomly on PCI
accesses. Not a viable option in that form _but_ making them sleep would
work - even with a simple global wait queue
for the pci_unblock_.. path

ie add the following (oh and uninlined probably for compatcness)

static int pci_user_wait_access(struct pci_dev *pdev) {
	wait_event(&pci_ucfg_wait, dev->block_ucfg_access == 0);
}




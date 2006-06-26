Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWFZOnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWFZOnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWFZOnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:43:11 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:16542 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1030273AbWFZOnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:43:09 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606261437.k5QEb8vr013461@wildsau.enemy.org>
Subject: Re: finding pci_dev from scsi_device
In-Reply-To: <1151332173.3185.46.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Date: Mon, 26 Jun 2006 16:37:08 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> isn't it better to do this in the ahci driver itself instead? it for
> sure will be orders of magnitude easier....

drivers/scsi/ahci.c:

// XXX added herp
static int ahci_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg) {
...

For some reason, I have to use an ioctl to reconfigure the controller.
This means that I don't have the "struct pci_dev *pdev" from ahci_init_one
and ahci_remove_one.

I could store a pointer to pci_dev by extending "struct ahci_host_priv",
but before doing this, I'm trying to figure out if there's a "correct"
way of finding a pci_dev from a scsi_device.

>From the scsi_device, I know I can get a "struct ata_port", from there
a "struct Scsi_Host", a "struct ata_host_set" and even a generic
"struct device *".

Now all that's missing is a pointer to "struct pci_dev". Is there a function
to enumerate all "struct device", in that case I could compare
"struct pci_dev -> dev", if the pointers match, I've found it.

kind regards,
h.rosmanith



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTFGJbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 05:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTFGJbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 05:31:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7684 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262883AbTFGJbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 05:31:07 -0400
Date: Sat, 7 Jun 2003 10:44:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
Message-ID: <20030607104434.B22665@flint.arm.linux.org.uk>
Mail-Followup-To: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
	manfred@colorfullife.com, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <16096.16492.286361.509747@napali.hpl.hp.com> <20030606.003230.15263591.davem@redhat.com> <200306062013.h56KDcLe026713@napali.hpl.hp.com> <20030606.234401.104035537.davem@redhat.com> <16097.37454.827982.278024@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16097.37454.827982.278024@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Sat, Jun 07, 2003 at 12:20:46AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 12:20:46AM -0700, David Mosberger wrote:
> ./include/asm-arm/pci.h:#define PCI_DMA_BUS_IS_PHYS     (0)

I suspect we probably set this incorrectly; we have some platforms where
there is merely an offset between the phys address and the bus address.
For these, I think we want to set this to 1.

Other platforms require the dma functions to allocate a new buffer
and copy the data to work around buggy "wont fix" errata (eg, new buffer
below 1MB) and for these I think we want to leave this at 0.

It is rather unfortunate that this got called "PCI_xxx" since it has
been used in a non pci-bus manner in (eg) the scsi layer.

Also note that I have platforms where the dma_mask is a real mask not
"a set of zeros followed by a set of ones from MSB to LSB."  I can
see this breaking the block layer if PCI_DMA_BUS_IS_PHYS is defined
to one. 8/

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbULAP7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbULAP7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULAP7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:59:47 -0500
Received: from motgate8.mot.com ([129.188.136.8]:12944 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261289AbULAP7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:59:39 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <01D8FD1F-43B2-11D9-9FBC-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: platform device / driver model ?
Date: Wed, 1 Dec 2004 09:59:39 -0600
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on moving the PPC 85xx port to use the new driver model.  
The 85xx family is a PowerPC SoC (core + various peripherals on a 
single chip).  An example of a chip would be the MPC8540.  The MPC8540 
has an e500 PPC core and uarts, ethernet, pci, etc.  For ethernet it 
has two Gig-E and one 10/100 interface.  The gig-e vs 10/100 interface 
use the same driver however, the 10/100 interface has some limited 
functionality.

In making the changes I've got two questions on how to handle things:

1. I was planning on having platform_data point at a structure which 
contained device flags and a board_data pointer.  The device flag would 
be used to pass on information to the driver to distinguish minor 
feature devices.  For example, between the gig-e interface would have 
the following flags set HAS_RMON | HAS_GIGABIT, where the 10/100 would 
not set either.  Additionally, there is some information which is more 
board specific.  For example, why ethernet PHY was used, does it 
support an external interrupt for status, etc.   This information would 
be in the board_data pointer.

struct foobar {
	u32	flags;
	void *board_data;
}

My question is where to put the definition of the structure or is there 
a better way to do what I'm doing that already exists in the driver 
model?  I'm concerned about putting it in an include/asm-ppc since its 
feasible that the same ethernet block could be used on a non-powerpc 
device and the driver would still be valid.  Actually, I think we have 
this case coming up with a USB block being on both an ARM and PPC based 
CPUs from Freescale.

2. Since board_data would be defined by the driver what is the best 
place to put its structure definition.  It seems rather evil to have 
arch/ppc/platforms/foo.c including a header from drivers/net/.

thanks

- Kumar


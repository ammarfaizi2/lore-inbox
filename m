Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbULGFDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbULGFDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 00:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbULGFDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 00:03:48 -0500
Received: from ftpbox.mot.com ([129.188.136.101]:16288 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S261755AbULGFDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 00:03:43 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Second Attempt: Driver model usage on embedded processors
Date: Mon, 6 Dec 2004 23:03:07 -0600
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at moving support for PowerPC System on a Chip devices to 
using the 2.6 driver model.  I think may issues may apply to any system 
on a chip device. I have a few issues, however one is holding up 
progress.  I think the best way to ask my question is with an example:

On a given chip we have an ethernet controller that is directly 
available to the CPU.  The ideas is that this device would be a 
platform device.  The issue is that this controller may have several 
minor variations on the same chip or between chip models.  We have 
written a single driver to handle these variants.  Variants may 
include, support for Gigabit, support for RMON, support for interrupt 
coalescing.  Additionally, the driver needs to be based some 
information that is board specific.  Such as which PHY, at what PHY id, 
does the PHY have an interrupt, etc.

The intent was that I would use the platform_data pointer to pass board 
specific information to the driver.  We would have board specific code 
which would fill in the information.  The question I have is how to 
handle the device variant information which is really static?

Possible solutions I've come up with:
1. use a struct resource for the flags that describe ethernet variants
- Add a new resource type
- steal a bus specific resource type
2. create a super structure that platform_data points to which contains 
the flags and a board_data pointer

The issue I've got with #2 is that some of these devices (and therefor 
drivers) will end up existing on various parts from Freescale that 
might have an ARM core or PPC core.  I'd prefer a solution that did not 
impose restrictions on how an arch does things.

I a few other questions about headers and were to put things, but 
that's secondary.

- kumar


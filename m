Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVFFXdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVFFXdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVFFXSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:18:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56790
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261720AbVFFXAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:00:13 -0400
Date: Mon, 06 Jun 2005 15:59:54 -0700 (PDT)
Message-Id: <20050606.155954.59466251.davem@davemloft.net>
To: gregkh@suse.de
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050606225548.GA11184@suse.de>
References: <20050603224551.GA10014@kroah.com>
	<20050605.124612.63111065.davem@davemloft.net>
	<20050606225548.GA11184@suse.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@suse.de>
Date: Mon, 6 Jun 2005 15:55:49 -0700

> Why would it matter?  The driver shouldn't care if the interrupts come
> in via the standard interrupt way, or through MSI, right?  And if it
> does, it could always use a function like the one I proposed to set up a
> different irq handler.

It matters because MSI totally changes the DMA vs. interrupt delivery
guarentees.

With MSI, you can be assured that any DMA sent from the device, before
the interrupt, has reached global visibility before the MSI arrives at
the cpu.  There is no such guarentee with pre-MSI interrupt delivery.

Drivers optimize this, so they have to know if MSI is being used or
not.

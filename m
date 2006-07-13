Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWGMMdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWGMMdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWGMMdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:33:38 -0400
Received: from lx-ltd.ru ([85.113.143.174]:10139 "EHLO iserver.lx.intercon.ru")
	by vger.kernel.org with ESMTP id S1751017AbWGMMdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:33:37 -0400
X-Comment-To: Arjan van de Ven
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugs in usb-skeleton.c??? :)
References: <m3odvtvj8w.fsf@lx-ltd.ru>
	<1152791917.3024.39.camel@laptopd505.fenrus.org>
From: Sergej Pupykin <ps@lx-ltd.ru>
Date: 13 Jul 2006 16:33:35 +0400
In-Reply-To: <1152791917.3024.39.camel@laptopd505.fenrus.org>
Message-ID: <m37j2helb4.fsf@lx-ltd.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> As I understand, USB subsystem uses urb->transfer_buffer directly with
 >> DMA. I see that usb-skeleton.c and (at least) bluez's hci_usb allocates it
 >> without GFP_DMA flag. (skeleton with GFP_KERNEL, bluez with GFP_ATOMIC)

 AvdV> I think GFP_DMA means something different than that you think it means.
 AvdV> GFP_DMA is a bad old hack that means "this is for ISA bus cards to DMA
 AvdV> to/from". Since there are no ISA bus USB controllers... the USB code
 AvdV> doesn't need to use GFP_DMA.

Does kmalloc always allocate pages that can be used in DMA?

I see pci_map_single gives address that incremented later without page
boundary checking. Are allocated pages sequented? (usb-ohci.c)


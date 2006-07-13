Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWGMNAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWGMNAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWGMNAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:00:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40101 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030191AbWGMNAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:00:52 -0400
Subject: Re: Bugs in usb-skeleton.c??? :)
From: Arjan van de Ven <arjan@infradead.org>
To: Sergej Pupykin <ps@lx-ltd.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m37j2helb4.fsf@lx-ltd.ru>
References: <m3odvtvj8w.fsf@lx-ltd.ru>
	 <1152791917.3024.39.camel@laptopd505.fenrus.org> <m37j2helb4.fsf@lx-ltd.ru>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 15:00:50 +0200
Message-Id: <1152795650.3024.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 16:33 +0400, Sergej Pupykin wrote:
>  >> As I understand, USB subsystem uses urb->transfer_buffer directly with
>  >> DMA. I see that usb-skeleton.c and (at least) bluez's hci_usb allocates it
>  >> without GFP_DMA flag. (skeleton with GFP_KERNEL, bluez with GFP_ATOMIC)
> 
>  AvdV> I think GFP_DMA means something different than that you think it means.
>  AvdV> GFP_DMA is a bad old hack that means "this is for ISA bus cards to DMA
>  AvdV> to/from". Since there are no ISA bus USB controllers... the USB code
>  AvdV> doesn't need to use GFP_DMA.
> 
> Does kmalloc always allocate pages that can be used in DMA?

normally yes. HOWEVER....
> 
> I see pci_map_single gives address that incremented later without page
> boundary checking. Are allocated pages sequented? (usb-ohci.c)

..it is nicer to use the DMA allocation API (which internally may fall
back to kmalloc etc), while kmalloc may work, it can be quite slow in
how it's made to work. So it's just nicer to just use the DMA memory
allocators... (see Documentation/DMA-API.txt file for a description of
this)

Greetings,
   Arjan van de Ven


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUFBK2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUFBK2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUFBK2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:28:19 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:37333 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261638AbUFBK1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:27:42 -0400
Date: Wed, 2 Jun 2004 03:30:27 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "Ihar 'Philips' Filipau" <ifilipau@giga-stream.de>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: e1000 question
Message-ID: <20040602103027.GA74881@gaz.sfgoth.com>
References: <40BD8E49.3070605@giga-stream.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BD8E49.3070605@giga-stream.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:
>    Functions e1000_clean_{t,r}x_irq are very similar: both of them are 
> checking descriptor flag updated by nic.
>    Host CPU, obviously, to perform this check, will cache descriptor.
>    If, say e1000_clean_rx_irq() will be called twice in short time 
> range, I expect that it can miss change of the flag, since old flag may 
> still sit in host CPU cache.

Please see Documentation/DMA-mapping.txt; especially the part starting
at "There are two types of DMA mappings..."  Ring buffers are allocated
as "consistent" DMA memory.

For most architectures this will mean that the cache hardware snoops the
PCI bus and automatically invalidates cache lines as they are written to.
For architectures that can't do that then Linux will mark those memory
regions uncacheable.

-Mitch

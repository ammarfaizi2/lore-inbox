Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTHSJYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTHSJYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:24:14 -0400
Received: from trained-monkey.org ([209.217.122.11]:48649 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S269191AbTHSJYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:24:11 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030817233705.0bea9736.davem@redhat.com>
	<m3r83jyw2k.fsf@defiant.pm.waw.pl>
	<20030818054341.2ef07799.davem@redhat.com>
	<m365kvufjx.fsf@defiant.pm.waw.pl>
	<20030818094955.3aa5c1c2.davem@redhat.com>
	<m3d6f2kern.fsf@defiant.pm.waw.pl>
	<20030818115052.41e62a90.davem@redhat.com>
	<m3n0e6mxuw.fsf@defiant.pm.waw.pl>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Aug 2003 05:24:11 -0400
In-Reply-To: <m3n0e6mxuw.fsf@defiant.pm.waw.pl>
Message-ID: <m3ptj2roec.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> Example:

Krzysztof> $ grep DMA_MASK sound/oss/emu10k1/main.c #define
Krzysztof> EMU10K1_DMA_MASK 0x1fffffff /* DMA buffer mask for
Krzysztof> pci_alloc_consist */ if (pci_set_dma_mask(pci_dev,
Krzysztof> EMU10K1_DMA_MASK)) {

Krzysztof> Do you see a problem here? It will work if and only if
Krzysztof> pci_alloc_consistent uses dma_mask rather than
Krzysztof> consistent_dma_mask.

Yes there is a problem, them emu10k driver was expecting the
pci_set_dma_mask call to affect pci_alloc_consistent, which was
unfortunately incorrect usage of the API.

Jes

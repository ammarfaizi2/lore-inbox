Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265980AbUBKRva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 12:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265984AbUBKRva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 12:51:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25578 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265980AbUBKRv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 12:51:28 -0500
Date: Wed, 11 Feb 2004 09:51:23 -0800
From: "David S. Miller" <davem@redhat.com>
To: dsaxena@plexity.net
Cc: lists@mdiehl.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-Id: <20040211095123.2cf7399d.davem@redhat.com>
In-Reply-To: <20040211163901.GA24446@plexity.net>
References: <20040211061753.GA22167@plexity.net>
	<Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
	<20040211163901.GA24446@plexity.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 09:39:01 -0700
Deepak Saxena <dsaxena@plexity.net> wrote:

> If pci_dma_sync_single is for FROM_DEVICE only, than the direction
> parameter should go away from it and the from
> pci_dma_sync_to_device_single().

This is wrong.  The direction parameter says what was done by the device/cpu
for the DMA, this is needed by the port to know how to perform the
pci_dma_sync_single et al. correctly.

For example, a port may have to do something different for FROM_DEVICE vs.
TO_DEVICE to properly execute the pci_dma_sync_single() request.

MIPS (and seemingly ARM) are probably the best platforms by which to draw up
the worst case scenerio for the implementation of these things :) and thus
the optimizations made possible by certain combinations of request+direction.

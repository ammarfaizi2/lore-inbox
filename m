Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUCOUgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbUCOUgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:36:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262634AbUCOUgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:36:51 -0500
Date: Mon, 15 Mar 2004 12:36:47 -0800
From: "David S. Miller" <davem@redhat.com>
To: Olaf Hering <olh@suse.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: consistent_sync_for_cpu() and friends on ppc32
Message-Id: <20040315123647.4ce943b7.davem@redhat.com>
In-Reply-To: <20040315201616.GA31268@suse.de>
References: <20040315201616.GA31268@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004 21:16:16 +0100
Olaf Hering <olh@suse.de> wrote:

> what is the fix for ppc32? This patch went into Linus tree:
> people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/dma_sync_for_device-cpu.patch
 ...
> include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':

Ben, can you work this out?  I can make it compile by just making the
_for_cpu and _for_device routines behave identically to what the
consisten_sync{,_page}() stuff does now.  But I'd much rather a ppc32
person implement it correctly and optimally.

In short, the _for_device routines should make sure cacheable data in
the cpu is fully visible to the DMA device, and _for_cpu should make
sure all device DMA is visible to the processor.

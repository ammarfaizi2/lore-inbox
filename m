Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130132AbQKSV7H>; Sun, 19 Nov 2000 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130572AbQKSV65>; Sun, 19 Nov 2000 16:58:57 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:26374 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130132AbQKSV6v>;
	Sun, 19 Nov 2000 16:58:51 -0500
To: dalecki@evision-ventures.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] megaraid driver update for 2.4.0-test10
In-Reply-To: <3A170A06.934405FC@evision-ventures.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 19 Nov 2000 22:28:44 +0100
In-Reply-To: dalecki's message of "Sun, 19 Nov 2000 00:00:23 +0100"
Message-ID: <d3zoivtzw3.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "dalecki" == dalecki  <dalecki@evision-ventures.com> writes:

A few questions after scanning through your patch, it's likely I
missed something but I am kind acurious.

dalecki> The attached patch does the following: 1. Merge the most
dalecki> current version (aka: 1.08) of the MegaRAID driver from AMI
dalecki> in to the most current kernel (2.4.0-test10 and friends).

Hmmm I don't get it why you changed the return type of the
readl/writel macros to return unsigned long rather than u32 - is there
a reason for this other than to get sign extension?

dalecki> 3. Fix the virt_to_phys mapping for scatter-gather transfers
dalecki> as well as some other minor tidups here and there.

What are you trying to achieve there? You run virt_to_phys() on a user
space address as far as I can read and stick it into something
labelled xferaddr? Normally you should never need the physical address
in a device driver unless you want to play with page table settings or
the like. If the address is to be handed to a DMA engine you should
never take the physical address, but rather use virt_to_bus() or even
better use the new 2.3+ PCI DMA API (pci_map_single()).

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

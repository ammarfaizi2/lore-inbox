Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVF0WRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVF0WRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVF0WRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:17:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261932AbVF0WR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:17:27 -0400
Date: Mon, 27 Jun 2005 15:19:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Horman <nhorman@redhat.com>
cc: linux-kernel@vger.kernel.org, greg@kroah.com, jeff.garzik@pobox.com,
       akpm@osdl.org
Subject: Re: [Patch] Janitorial cleanup of GET_INDEX macro in arch/i386/pci/fixup.c
In-Reply-To: <20050627140914.GD20880@hmsendeavour.rdu.redhat.com>
Message-ID: <Pine.LNX.4.58.0506271516530.19755@ppc970.osdl.org>
References: <20050627140914.GD20880@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Jun 2005, Neil Horman wrote:
>
> Patch to clean up the implementation of the GET_INDEX macro in the i386 pci
> fixup code so that it uses the PCI_DEVFN macro, rather than re-implements it.

This looks wrong:

> -#define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + ((b) & 7))
> +#define GET_INDEX(a, b) PCI_DEVFN((a - PCI_DEVICE_ID_INTEL_MCH_PA),b)

that first argument looks like it has parentheses at the wrong place, it 
should be

	(a) - PCI_DEVICE_ID_INTEL_MCH_PA

rather than

	(a - PCI_DEVICE_ID_INTEL_MCH_PA)

methinks.

Other than that... Greg?

		Linus

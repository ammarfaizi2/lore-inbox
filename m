Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVBSA1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVBSA1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVBSA0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:26:31 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:44435 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261589AbVBSAYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:24:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=sxq+Dy9aRgzJhbrOD5046vFqZQdqoVCOVVtxgcwOcK/QjOm/lc3WzawxKtZFSRNioksmgf4ng9V3MdBl+hUxOUKUJtPCuyOUHJUphHJtRRcDFljZtqpG41YLBL89IoeLMeP/l9d1ZaX0Cx2mAq+zGTUE0VmV2ovOOMxPAEwLeTw=
Message-ID: <9e473391050218162438cae108@mail.gmail.com>
Date: Fri, 18 Feb 2005 19:24:33 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] drivers/pci/: possible cleanups
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050218235419.GE4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050218235419.GE4337@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2005 00:54:19 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains the following possible cleanups:
> - pci-acpi.c: make OSC_UUID static
> - remove the following unused functions:
>   - pci-acpi.c: acpi_query_osc
>   - pci-acpi.c: pci_osc_support_set
>   - pci.c: pci_find_ext_capability
>   - rom.c: pci_map_rom_copy
>   - rom.c: pci_remove_rom
> - remove the following unneeded EXPORT_SYMBOL's:
>   - pci-acpi.c: pci_osc_support_set
>   - rom.c: pci_map_rom_copy
>   - rom.c: pci_remove_rom

pci_map_rom_copy and pci_remove_rom are there to support boards that
can't access their hardware and their ROM at the same time. These
boards are known to exist but nobody has updated a driver yet to use
the new routines. These should be left in place as the PCI spec
explicitly allows the non-simultaneous access case.

pci_remove_rom should probably be renamed to pci_remove_rom_copy.

-- 
Jon Smirl
jonsmirl@gmail.com

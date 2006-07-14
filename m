Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWGNNOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWGNNOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 09:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWGNNOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 09:14:15 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:47537 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030442AbWGNNOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 09:14:15 -0400
Message-ID: <44B79A13.4020905@gentoo.org>
Date: Fri, 14 Jul 2006 14:20:19 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Jeff Garzik <jeff@garzik.org>, greg@kroah.com, akpm@osdl.org, cw@f00f.org,
       harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net>	<44B77B1A.6060502@garzik.org>	<44B78294.1070308@gentoo.org>	<44B78538.6030909@garzik.org>	<44B78AFA.80806@gentoo.org> <20060714165100.6950813a.vsu@altlinux.ru>
In-Reply-To: <20060714165100.6950813a.vsu@altlinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> I still do not understand what will break in this case - won't the
> external device just ignore the value which the quirk will write into
> its PCI_INTERRUPT_LINE register?
> 
> Can someone point me at examples of breakage caused by the original
> quirk matching non-builtin devices?  The examples of breakage caused by
> missing devices are everywhere now :(

I know relatively little about PCI, so I'll leave this for someone else 
to answer. I'm just looking to find an acceptable solution which will 
allow these VIA SATA users to be able to boot again...

> Now this changelog is obviously wrong...

Yep, forgot to update/remove it after the original patch.

> This table is even more incomplete than the original.  I found these ISA
> bridge IDs from VIA in my copy of pci.ids:
> 
>         0586  VT82C586/A/B PCI-to-ISA [Apollo VP]
>         0596  VT82C596 ISA [Mobile South]
>         0686  VT82C686 [Apollo Super South]
>         3074  VT8233 PCI to ISA Bridge
>         3109  VT8233C PCI to ISA Bridge
>         3147  VT8233A ISA Bridge
>         3177  VT8235 ISA Bridge
>         3227  VT8237 ISA bridge [KT600/K8T800/K8T890 South]
>         3287  VT8251 PCI to ISA Bridge
>         3337  VT8237A PCI to ISA Bridge
>         8231  VT8231 [PCI-to-ISA Bridge]
> 
> The major problem with this approach is that this PCI ID list will
> inevitably get stale, and there will be no easy way to boot the kernel
> on a newer system.  And there is no sign that VIA turns away from their
> habit of using PCI_INTERRUPT_LINE for IRQ routing...
> 
> However, what about triggering the quirk on any ISA bridge from VIA:
> 
> 	{
> 		.vendor 	= PCI_VENDOR_ID_VIA,
> 		.device		= PCI_ANY_ID,
> 		.subvendor	= PCI_ANY_ID,
> 		.subdevice	= PCI_ANY_ID,
> 		.class		= PCI_CLASS_BRIDGE_ISA << 8,
> 		.class_mask	= 0xffff00,
> 	}

Sounds sensible, but has the disadvantage that we'd be running on all 
future VIA hardware, even if they fixed it. The original quirk code also 
has this issue, but it could be argued that the current ID list does not.

That said, I'm happy to write and test a new patch with your 
suggestions, if it would be acceptable to Greg/Jeff.

Daniel


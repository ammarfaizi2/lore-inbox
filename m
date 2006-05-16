Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWEPQRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWEPQRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWEPQRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:17:46 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7300 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751657AbWEPQRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:17:45 -0400
Message-ID: <4469FB26.5070605@garzik.org>
Date: Tue, 16 May 2006 12:17:42 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
References: <200605161559.k4GFx3Mi017163@hera.kernel.org>
In-Reply-To: <200605161559.k4GFx3Mi017163@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit 5491d0f3e206beb95eeb506510d62a1dab462df1
> tree 5c4aadcfb4a93535e2f6e0f5977e930ccacec0e9
> parent f0fdabf8bf187c9aafeb139a828c530ef45cf022
> author Andi Kleen <ak@suse.de> Mon, 15 May 2006 18:19:41 +0200
> committer Linus Torvalds <torvalds@g5.osdl.org> Tue, 16 May 2006 21:59:31 -0700
> 
> [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
> 
> This is needed to see all devices.
> 
> The system has multiple PCI segments and we don't handle that properly
> yet in PCI and ACPI. Short term before this is fixed blacklist it to
> pci=noacpi.
> 
> Acked-by: len.brown@intel.com
> Cc: gregkh@suse.de
> Signed-off-by: Andi Kleen <ak@suse.de>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  arch/i386/kernel/acpi/boot.c |    8 ++++++++
>  1 files changed, 8 insertions(+)
> 
> diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
> index 40e5aba..daee695 100644
> --- a/arch/i386/kernel/acpi/boot.c
> +++ b/arch/i386/kernel/acpi/boot.c
> @@ -1066,6 +1066,14 @@ static struct dmi_system_id __initdata a
>  		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
>  		     },
>  	 },
> +	{
> +	 .callback = disable_acpi_pci,
> +	 .ident = "HP xw9300",
> +	 .matches = {
> +		    DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		    DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),

Strong NAK.  Please revert.  This majorly screws my primary workstation, 
and many other users with this workstation.

At a minimum, you should test to see if the BIOS has activated PCI 
domain support first!

	Jeff



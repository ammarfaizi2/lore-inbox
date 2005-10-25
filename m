Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVJYUpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVJYUpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVJYUpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:45:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932366AbVJYUpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:45:13 -0400
Date: Tue, 25 Oct 2005 13:45:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Darren Salt <linux@youmustbejoking.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Call for PIIX4 chipset testers
In-Reply-To: <4DBF8B37C1%linux@youmustbejoking.demon.co.uk>
Message-ID: <Pine.LNX.4.64.0510251338420.10477@g5.osdl.org>
References: <4DBF8B37C1%linux@youmustbejoking.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Oct 2005, Darren Salt wrote:
>
>   $ dmesg | grep PIIX4
>   PCI quirk: region 5000-503f claimed by PIIX4 ACPI
>   PCI quirk: region 4000-401f claimed by PIIX4 SMB
>   PIIX4 devres C PIO at 0100-0107
>   PIIX4 devres I PIO at 00e0-00e3
>   PIIX4 devres J PIO at 00f9-00fc

Ok, great. None of those quirks are very interesting per se (they're all 
in the old legacy region), but that 0xf9-0xfc one is interesting if only 
because it points out that I should be more careful about the mask/base 
logic.

That quirk is actually set up in a very special way, where it ignores 
address line #1, and devres J actually covers two PIO ports: 0xf9 and 0xfb 
(but not the one between). Odd, but it's documented hardware behaviour.

So the 0xf9-0xfc thing is strictly not right, and I'll modify my code a 
bit (probably to mark 0xf8-0xfb instead, which will be what we'd want to 
do for anything in the non-legacy region).

> Machine is a Compaq Armada M700; /proc/ioports & lspci output are attached.

Thanks, that lspci output was what I needed to verify the mask details.

The printouts look good. I wish somebody had a PIIX with a MMIO quirk just 
to verify that I got that case right too, but it's pretty unlikely that is 
ever used in practice.

		Linus

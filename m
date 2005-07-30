Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263172AbVG3Ugu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbVG3Ugu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVG3Ugl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:36:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263157AbVG3Uey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:34:54 -0400
Date: Sat, 30 Jul 2005 13:34:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0507301331260.29650@g5.osdl.org>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Jul 2005, Hugh Dickins wrote:
>
> Please revert the yenta free_irq on suspend patch (below)
> which went into 2.6.13-rc4 after 2.6.13-rc3-git9.

Ok. Will do.

And the ACPI people had better stop doing this crazy thing in the first 
place. There's really no point at all to freeing and re-requesting the 
interrupts, and the IRQ controller should just re-initialize itself 
instead.

The excuse for not doing so was totally ludicrous in the first place, if I
recall correctly. Use GFP_ATOMIC in ACPI if you do things with interrupts
disabled, don't break a million drivers.

		Linus

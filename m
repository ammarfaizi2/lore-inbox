Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVGBWH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVGBWH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVGBWH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:07:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261301AbVGBWBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 18:01:53 -0400
Date: Sat, 2 Jul 2005 15:01:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>
Subject: Re: If ACPI doesn't find an irq listed, don't accept 0 as a valid
 PCI irq.
In-Reply-To: <1120340186.9275.52.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507021457540.8247@g5.osdl.org>
References: <200507021908.j62J8m4D009707@hera.kernel.org>
 <1120340186.9275.52.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Jul 2005, David Woodhouse wrote:
> 
> Zero _is_ a valid IRQ number.

Not for a "legacy irq" it ain't.

If the ACPI layer itself decides to use IRQ0, then that's fine, and that 
path hasn't changed at all. 

However, if ACPI doesn't find any irq, and ends up just using whatever irq 
the device had for some legacy reason, then irq 0 just means "nobody set 
an irq".

Besides, we'll actually be returning 0 _anyway_. The only thing my patch
fixes (and it _is_ a fix) is that we won't be stupidly thinking that we
actually have a valid irq, and that we should turn it level-sensitive.

		Linus

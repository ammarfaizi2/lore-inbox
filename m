Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSLIN2c>; Mon, 9 Dec 2002 08:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbSLIN2c>; Mon, 9 Dec 2002 08:28:32 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:15367 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265480AbSLIN2b>; Mon, 9 Dec 2002 08:28:31 -0500
Date: Mon, 9 Dec 2002 16:35:11 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
Message-ID: <20021209163511.A1637@jurassic.park.msu.ru>
References: <20021208125642.A22545@twiddle.net> <Pine.LNX.4.44.0212081747590.1209-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0212081747590.1209-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 08, 2002 at 05:54:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 05:54:16PM -0800, Linus Torvalds wrote:
> Writing it back is actively _bad_, since it will make it very hard to
> re-boot the machine without the BIOS re-enumarating the PCI bus and
> filling it in again (ie it would definitely screw up using things like
> kexec() on PC's, if the kernel we boot _from_ is an APIC kernel, but the
> kernel we boot _into_ is not).

True. This applies to alpha as well because of the way how modern consoles
encode IRQs routed through the ISA bridge (actual IRQ + 0xe0).

Probably we should eliminate pcibios_update_irq() call in
drivers/pci/setup-irq.c and see what happens. Nothing bad, I guess.

Ivan.

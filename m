Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTHUCf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 22:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTHUCf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 22:35:26 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:45959 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262363AbTHUCfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 22:35:19 -0400
Date: Wed, 20 Aug 2003 22:33:44 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test3-mm3 reserve IRQ for isapnp
Message-ID: <20030820223344.GA10163@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Wes Janzen <superchkn@sbcglobal.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <3F440387.5090902@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F440387.5090902@sbcglobal.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 06:25:59PM -0500, Wes Janzen wrote:
> So sad...  Ever since I started with kernel 2.5.69, the kernel has been
> properly reserving IRQ 5 for ISA, as set in my BIOS.

The reserve IRQ feature in your BIOS should not effect the linux kernel.
It is strictly internal to your BIOS.  Therefore if linux assigns
resources it probably won't reserve irq 5.  This problem may be the
result of a change in the way linux assigns resources.

>
> Unfortunately for me, it looks like 2.6.0-test3-mm3 is like 2.4.18 and

In what kernel version did you first see this problem?

> ignores my BIOS settings, so it locks up trying to ativate my SB16 on
> boot (since IRQ 5 is used for IDE).  Oddly it doesn't spit out any
> warnings, just locks up after "pnp: Device 00:01.03 activated".

I'd imagine this is the result of the resource conflict, presumably with
your ide controller.  More information would be needed.  I'd like to see
/proc/interrupts, dmesg, and lspci -vv (when the sb driver is not loaded).

Also, are you using acpi?  If so, try the kernel parameter pci=noacpi and
also try disabling acpi completely.

Thanks,
Adam

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUKSOAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUKSOAC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUKSN7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:59:13 -0500
Received: from canuck.infradead.org ([205.233.218.70]:2313 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261417AbUKSN6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:58:24 -0500
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041119120549.GD21483@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de>
	 <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com>
	 <20041119103418.GB30441@wotan.suse.de>
	 <1100863700.21273.374.camel@baythorne.infradead.org>
	 <20041119115539.GC21483@wotan.suse.de>
	 <1100865050.21273.376.camel@baythorne.infradead.org>
	 <20041119120549.GD21483@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1100872680.8191.7391.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 19 Nov 2004 13:58:00 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 13:05 +0100, Andi Kleen wrote:
> I don't know details about the driver, but it's not enabled on x86-64 
> because x86-64 doesn't have ISA set.

That looks bogus actually -- I think it should only depend on the
existence of parport_pc style hardware. CONFIG_ISA is definitely a
digression. But still, either way the example is wrong. It shouldn't be
limited to X86 and X86_64.

I still haven't found good examples of cases where X86 is used and we
would want to change that to X86 || X86_64. Could this be one?

config HW_RANDOM
        tristate "Intel/AMD/VIA HW Random Number Generator support"
        depends on (X86 || IA64) && PCI

...or this?

config FTAPE
        tristate "Ftape (QIC-80/Travan) support"
        depends on BROKEN_ON_SMP && (ALPHA || X86)

I also see some which already have it:

config NVRAM
        tristate "/dev/nvram support"
        depends on ATARI || X86 || X86_64 || ARM || GENERIC_NVRAM
config HANGCHECK_TIMER
        tristate "Hangcheck timer"
        depends on X86_64 || X86

And some which seem to be wrong because they want only X86 not X86_64:

config SONYPI
        tristate "Sony Vaio Programmable I/O Control Device support (EXPERIMENTAL)"
        depends on EXPERIMENTAL && X86 && PCI && INPUT && !64BIT
config MWAVE
        tristate "ACP Modem (Mwave) support"
        depends on X86
        select SERIAL_8250

Using X86 to include X86_64 is bizarre and inconsistent, and it's
already leading to errors in Kconfig. Let's fix it.



-- 
dwmw2


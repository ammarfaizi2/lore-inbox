Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVGBKkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVGBKkr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 06:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVGBKkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 06:40:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1553 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261152AbVGBKko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 06:40:44 -0400
Date: Sat, 2 Jul 2005 11:40:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc1-git2 Oops on rmmod serial_core
Message-ID: <20050702114034.B7790@flint.arm.linux.org.uk>
Mail-Followup-To: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>,
	linux-kernel@vger.kernel.org
References: <503fc0.e20f3b@family-bbs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <503fc0.e20f3b@family-bbs.org>; from Kenneth.Parrish@family-bbs.org on Sat, Jul 02, 2005 at 06:57:54AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 06:57:54AM +0000, Kenneth Parrish wrote:
> The serial support code newly allows selecting the max number of serial
> ports. This computer has one s-port so i typed '1'.
> 
>  config SERIAL_8250_NR_UARTS
>  int "Maximum number of 8250/16550 serial ports"
>  depends on SERIAL_8250
>  default "4"
>  help
>  Set this to the number of serial ports you want the driver
>  to support.  This includes any ports discovered via ACPI or
>  PCI enumeration and any ports that may be added at run-time
>  via hot-plug, or any ISA multi-port serial cards.
> 
> I found the value needs to be at least '4' or we oops at rmmod
> serial_core.  2.6.13-rc1-git2 kernels with values from one through four
> were tested.

It's actually worse than that.  If you set it to less than 4 on an x86
PC, it'll stamp over memory.  All is not lost though - it's fixed in:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=44454bcdb90532b372c74e3546043d8a3a468939

I'd advise people _not_ to run -git2.  If they do and they see any
oddities, please don't bother reporting them unless you can reproduce
them with a later version or with this set to at least '4'.  This
problem can cause oopses in other parts of the kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

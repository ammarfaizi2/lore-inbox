Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVGML2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVGML2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVGML2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:28:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19209 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262631AbVGML1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:27:15 -0400
Date: Wed, 13 Jul 2005 12:27:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Arjan van de Ven <arjan@infradead.org>, vacant2005@o2.pl,
       linux-kernel@vger.kernel.org
Subject: Re: system.map
Message-ID: <20050713122701.A6791@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Arjan van de Ven <arjan@infradead.org>, vacant2005@o2.pl,
	linux-kernel@vger.kernel.org
References: <200507121834.50084.vacant2005@o2.pl> <Pine.LNX.4.61.0507131220360.14635@yvahk01.tjqt.qr> <1121252168.3959.13.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0507131302550.14635@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0507131302550.14635@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Wed, Jul 13, 2005 at 01:04:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 01:04:38PM +0200, Jan Engelhardt wrote:
> >> >Jul 11 12:18:48 localhost kernel: Inspecting /boot/System.map
> >> >Jul 11 12:18:48 localhost kernel: Loaded 28063 symbols from /boot/System.map.
> >> >Jul 11 12:18:48 localhost kernel: Symbols match kernel version 2.6.12.
> >> >Jul 11 12:18:48 localhost kernel: No module symbols loaded - kernel modules 
> >> >notenabled.
> >
> >so whatever is spewing that is something else, but not the kernel.
> 
> These four messages are the first four ones that appear after the boot loader 
> set EIP to the kernel entry point. The first four printks, if you want so. And 
> apparently, the first four appearing in dmesg, obviously.

They have absolutely nothing to do with the kernel, nor printk.
They're to do with klogd, the process which reads kernel messages and
writes them via a socket to syslogd.

If klogd is started with out -x, it will want to read the System.map
file and do the broken lookup of things it thinks are addresses in
kernel messages.  This is not recommended practice.  For kernels with
kallsyms enabled, klogd should be started with -x.

After your kernel has booted, login and run dmesg.  You'll notice that
the first 4 lines are not as you expect.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

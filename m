Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTK3QAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTK3QAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:00:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40711 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264925AbTK3QAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:00:45 -0500
Date: Sun, 30 Nov 2003 16:00:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Message-ID: <20031130160042.A30125@flint.arm.linux.org.uk>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
References: <20031130071757.GA9835@node1.opengeometry.net> <20031130102351.GB10380@outpost.ds9a.nl> <20031130113656.GA28437@finwe.eu.org> <microsoft-free.87ekvpc0ms.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <microsoft-free.87ekvpc0ms.fsf@eicq.dnsalias.org>; from sryoungs@bigpond.net.au on Mon, Dec 01, 2003 at 01:54:51AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 01:54:51AM +1000, Steve Youngs wrote:
> |--==> "JK" == Jacek Kawa <jfk@zeus.polsl.gliwice.pl> writes:
> 
>   JK> bert hubert wrote:
>   >>> Does anyone have modem working in 2.6.0-test11?
>   >>> I have external modem connected to /dev/ttyS0 (COM1).  Kernel
>   >>> 2.6.0-test11 give me
> 
>   JK> It reminds me, that I had to add serial to the list of modules
>   JK> loading at start to get back access to /dev/ttyS* 
>   JK> (while upgrading from -test9 to -test10). 
> 
> Jacek,
> 
> I _think_ this patch will bring back auto-loading of the serial module
> for you.  Please let me know how it goes.  (Bert, this won't fix your
> problem if you have the serial driver compiled directly into the
> kernel, but it might if you have it as a module.)
> 
> --- linux-2.6.0-test11/drivers/serial/serial_core.c	2003-11-27 12:12:22.000000000 +1000
> +++ linux-2.6.0-test11-sy/drivers/serial/serial_core.c	2003-12-01 01:38:40.000000000 +1000
> @@ -2420,3 +2420,4 @@
>  
>  MODULE_DESCRIPTION("Serial driver core");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS_CHARDEV(drv->major, drv->minor);
> 

This is wrong.  serial_core should /never/ depend on a major/minor number
because it doesn't know what (group of) major/minor(s) it is going to be.

The only modules which know are the hardware drivers themselves, like
8250.c.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

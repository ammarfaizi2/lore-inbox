Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTLAHbj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTLAHbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:31:38 -0500
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:8576 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S262186AbTLAHbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:31:25 -0500
Date: Mon, 1 Dec 2003 08:28:00 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Message-ID: <20031201072800.GA2026@finwe.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031130071757.GA9835@node1.opengeometry.net> <20031130102351.GB10380@outpost.ds9a.nl> <20031130113656.GA28437@finwe.eu.org> <microsoft-free.87ekvpc0ms.fsf@eicq.dnsalias.org> <20031130222222.GA11809@finwe.eu.org> <microsoft-free.87vfp1nuxh.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <microsoft-free.87vfp1nuxh.fsf@eicq.dnsalias.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Youngs wrote:

>   >>I _think_ this patch will bring back auto-loading of the serial module
>   >>for you.  Please let me know how it goes. 
> 
>   JK> Well: patched, installed new serial_core.ko, then depmod -a, and
>   JK> try to access ttySwhatever.
> 
> As Russell said, the patch was wrong, revert it.  Sorry about that, my
> bad. 

Nothing bad happened :)

> I'm pretty sure that the problem has its roots in...

> --- a/fs/char_dev.c	Sun Nov 23 17:33:38 2003
> +++ b/fs/char_dev.c	Sun Nov 23 17:33:38 2003
> @@ -434,7 +434,7 @@
>  
>  static struct kobject *base_probe(dev_t dev, int *part, void *data)
>  {
> -	request_module("char-major-%d", MAJOR(dev));
> +	request_module("char-major-%d-%d", MAJOR(dev), MINOR(dev));
>  	return NULL;
>  }
> ...from Rusty, which went into 2.6.0-test10.

> Does this work any better?

> --- linux-2.6.0-test11/drivers/serial/8250.c	2003-11-27 11:03:42.000000000 +1000
> +++ linux-2.6.0-test11-sy/drivers/serial/8250.c	2003-12-01 11:40:44.000000000 +1000
[...]
> @@ -2195,3 +2196,4 @@
>  MODULE_PARM(force_rsa, "1-" __MODULE_STRING(PORT_RSA_MAX) "i");
>  MODULE_PARM_DESC(force_rsa, "Force I/O ports for RSA");
>  #endif
> +MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);

1. Yup, with first patch revertet everything works as before
2. With both patch applied I don't have to manually load
   any module (8250 and serial_core are autoloaded), but
   my pseudomodule serial isn't loaded anymore.

Thanks!

bye

-- 
Jacek Kawa  **SPAM - Stowarzyszenie Polskich Artystów Muzyków**

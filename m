Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUDTWx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUDTWx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbUDTWub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:50:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:17084 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264373AbUDTWtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 18:49:46 -0400
Subject: Re: [PATCH] Kconfig dependancy update for drivers/misc/ibmasm
From: Max Asbock <masbock@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tony Breeds <tony@bakeyournoodle.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040420143418.08962d0b.akpm@osdl.org>
References: <20040420210110.GD3445@bakeyournoodle.com>
	 <20040420143418.08962d0b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1082501343.6129.180.camel@DYN318100BLD.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Apr 2004 15:49:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 14:34, Andrew Morton wrote:
> Tony Breeds <tony@bakeyournoodle.com> wrote:
> 
> Seems sane to me, but I'm not sure why this wasn't done originally.  ie, this:
> 
> +#ifdef CONFIG_SERIAL_8250
>  extern void ibmasm_register_uart(struct service_processor *sp);
>  extern void ibmasm_unregister_uart(struct service_processor *sp);
> +#else
> +#define ibmasm_register_uart(sp)	do { } while(0)
> +#define ibmasm_unregister_uart(sp)	do { } while(0)
> +#endif
> 
> becomes unnecessary with your patch.
> 
> Max, any preferences?
> 

The above allows the driver to be built without serial line support. It
still functions that way. uart support is only part of the driver's
functions. Therefore it makes sense to not make the whole driver depend
on SERIAL_8250 and instead only configure away the uart support when
SERIAL_8250 is not defined.

regards,
max


> 
> > ################################################################################
> > --- 2.6.4.clean/drivers/misc/Kconfig	2004-03-11 17:57:23.000000000 +1100
> > +++ 2.6.4.noconfig/drivers/misc/Kconfig	2004-03-30 09:32:07.000000000 +1000
> > @@ -6,7 +6,7 @@
> >  
> >  config IBM_ASM
> >  	tristate "Device driver for IBM RSA service processor"
> > -	depends on X86
> > +	depends on X86 && SERIAL_8250
> >  	default n
> >  	---help---
> >  	  This option enables device driver support for in-band access to the



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264542AbRGGBJD>; Fri, 6 Jul 2001 21:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbRGGBIy>; Fri, 6 Jul 2001 21:08:54 -0400
Received: from mail.mesatop.com ([208.164.122.9]:9488 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S264542AbRGGBIi>;
	Fri, 6 Jul 2001 21:08:38 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Tom Diehl <tdiehl@pil.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.6-ac1 will not build, 2.4.6 ok
Date: Fri, 6 Jul 2001 19:00:51 -0600
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107061825280.13734-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0107061825280.13734-100000@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <01070619005100.01166@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 July 2001 16:35, Tom Diehl wrote:
> Hi all,
> This is my first bug report so please go easy on me if I screw it up.
> The kernel 2.4.6-ac1
> The build machine AMD k6-2-350 with 128Megs of memory
> I get the following errors when I try to build ac1. It builds ok when
> just building 2.4.6 with the same config file run through make old_config,
> so I guess this is some kind of problem with ac1.

I posted a patch for this a few hours after 2.4.6-ac1 became available, but
there have been problems with lkml archive servers in the interim, so here
is my patch again.  If you look in drivers/parport/parport_pc.c, you'll see that
the new code is bracketed by:

#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
	new stuff for 2.4.6-ac1
#endif

Steven


--- linux-2.4.6-ac1/drivers/parport/parport_pc.c.original       Wed Jul  4 15:22:28 2001
+++ linux/drivers/parport/parport_pc.c  Wed Jul  4 15:26:03 2001
@@ -2828,12 +2828,14 @@
        detect_and_report_smsc ();
 #endif
 
+#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
        dev=NULL;
        while ((dev=pnpbios_find_device("PNP0400",dev)))
                count+=init_pnp040x(dev);
        dev=NULL;
         while ((dev=pnpbios_find_device("PNP0401",dev)))
                 count+=init_pnp040x(dev);
+#endif
 
        /* Onboard SuperIO chipsets that show themselves on the PCI bus. */
        count += parport_pc_init_superio (autoirq, autodma);

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270740AbTG0LDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270741AbTG0LDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:03:54 -0400
Received: from lidskialf.net ([62.3.233.115]:41670 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270740AbTG0LDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:03:52 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Rahul Karnik <rahul@genebrew.com>,
       Marcelo Penna Guerra <eu@marcelopenna.org>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sun, 27 Jul 2003 12:19:05 +0100
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307262326.49638.eu@marcelopenna.org> <3F236A4A.2090302@genebrew.com>
In-Reply-To: <3F236A4A.2090302@genebrew.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271219.05840.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 06:59, Rahul Karnik wrote:
> Marcelo Penna Guerra wrote:
> > Hi,
> >
> >>From nvnet.c:
> >
> >    /*
> >      * Mac address is loaded at boot time into h/w reg, but it's loaded
> > backwards
> >      * we get the address, save it, and reverse it. The saved value is
> > loaded * back into address at close time.
> >      */
> >
> > PRINTK(DEBUG_INIT, "nvnet_init - get mac address\n");
> >     priv->hwapi->pfnGetNodeAddress(priv->hwapi->pADCX, priv-
> >
> >>original_mac_addr);
>
> Well, I wanted to reload the module with debug on, so I tried:
>
> # modprobe -r nvnet
> Segmentation fault
>
> #lsmod
>
> At this point lsmod just hung.
>
> Tried shutting down the computer, and it was stuck during shutdown.
> Seems like the refcounting is not really working, or perhaps there are
> too many cycles happening. What happens if you do the following with a
> module:
>
> try_module_get
> MOD_INC_USE_COUNT
> MOD_DEC_USE_COUNT
> module_put
>
> > But I don't think the only thing missing is the MAC address. You could
> > try to manually set it in the source itself and see if anything works.
>
> I'll just add it in BIOS and try with AMD8111. No desire to futz around
> with the nvnet source, where half of what is going on is a complete
> black box (priv->hwapi, "priv" is definitely *private*).
>
> Thanks,
> Rahul
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


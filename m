Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVBTMXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVBTMXx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 07:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVBTMXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 07:23:53 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:61872 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261822AbVBTMXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 07:23:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:organization:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ABMasBnKDp093nXnZEy4//dsKmI7Js9B5Qa3aDM1O5euoQRL2cIl2td599G1dn7rpqMnrfctgu7DM9JuROkxpmOHAma2Nx8Ns0ZREo9TV+7LNo/2TWq38u13CDBZ9kiaedUoggnXkXcRvIZnMNqszgRFo3PTJ7RXvC6LvxrELOg=
From: Vicente Feito <vicente.feito@gmail.com>
To: Martin Drohmann <m_droh01@uni-muenster.de>
Subject: Re: Why does printk helps PCMCIA card to initialise?
Date: Sun, 20 Feb 2005 09:25:18 +0000
User-Agent: KMail/1.7.1
References: <42187819.5050808@uni-muenster.de>
In-Reply-To: <42187819.5050808@uni-muenster.de>
Organization: none
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502200925.19176.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Sunday 20 February 2005 11:44 am, you wrote:
>  
> diff -u -U 7 /linux-2.6.11-rc4.changed/drivers/pcmcia/rsrc_nonstatic.c 
> ../linux-2.6.11-rc4/drivers/pcmcia/rsrc_nonstatic.c
> --- /linux-2.6.11-rc4.changed/drivers/pcmcia/rsrc_nonstatic.c     
> 2005-02-20 11:37:39.000000000 +0100
> +++ ../linux-2.6.11-rc4/drivers/pcmcia/rsrc_nonstatic.c     2005-02-20 
> 02:16:48.000000000 +0100
> @@ -623,15 +623,14 @@
>         down(&rsrc_sem);
>  #ifdef CONFIG_PCI
>         if (s->cb_dev) {
>                 ret = pci_bus_alloc_resource(s->cb_dev->bus, res, num, 1,
>                                              min, 0, pcmcia_align, &data);
>         } else
>  #endif
> -        printk("This line will never be printed, but it helps!!!");
>                 ret = allocate_resource(&ioport_resource, res, num, min, 
What you're doing is forcing the execution of allocate_resource (&ioport... );
Cause adding the printk you're adding it's changing this:
else 
 ret = allocate_resource(...);
up(...);

by this:

else
 printk(...);
/*This is not executing inside the else clause no more,
 *so doesn't matter if s->cb_dev it's true or not, you're going with this*/
ret = allocate_resource(...); 
up(...);

You're changing the block inside the else clause.
It's not about upsetting the sem afaik.
I could be wrong though, and that'll be a terrible tragedy.
Of course this is as long as CONFIG_PCI it's evaluating true, is it?

Vicente.

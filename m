Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263853AbTDHB6r (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 21:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbTDHB6r (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 21:58:47 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:43587
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263853AbTDHB6p (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 21:58:45 -0400
Date: Mon, 7 Apr 2003 22:05:37 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] xircom_cb release memory on failure
In-Reply-To: <3E92064C.9080306@pobox.com>
Message-ID: <Pine.LNX.4.50.0304072205010.21025-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304061635500.2268-100000@montezuma.mastecende.com>
 <3E92064C.9080306@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Jeff Garzik wrote:

> regression: no longer calls leave() as intended
> 
> 
> >  
> >  	/* disable all powermanagement */
> >  	pci_write_config_dword(pdev, PCI_POWERMGMT, 0x0000);
> > @@ -250,30 +254,27 @@ static int __devinit xircom_probe(struct
> >  	   is available. 
> >  	 */
> >  	private = kmalloc(sizeof(*private),GFP_KERNEL);
> > -	memset(private, 0, sizeof(struct xircom_private));
> > +	if (private == NULL)
> > +		goto out_region;
> > +
> > +	memset(private, 0, sizeof(*private));
> 
> see davej's patches -- not needed.  get alloc_etherdev() to allocate and 
> free dev->priv, and eliminate this memset altogether.  That in turn 
> simplifies what you are trying to do here.

Hi Jeff,
	Thanks i'll fix up my mistakes and resend.

	Zwane
-- 
function.linuxpower.ca

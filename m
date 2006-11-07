Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754116AbWKGIb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbWKGIb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbWKGIb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:31:59 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:2994 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754116AbWKGIb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:31:58 -0500
Message-ID: <45504477.90902@garzik.org>
Date: Tue, 07 Nov 2006 03:31:51 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       Wilco Beekhuizen <wilcobeekhuizen@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com> <1162817254.5460.4.camel@localhost.localdomain> <1162847625.10086.36.camel@localhost.localdomain> <20061107012519.GC25719@redhat.com>
In-Reply-To: <20061107012519.GC25719@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Nov 06, 2006 at 09:13:45PM +0000, Alan Cox wrote:
> 
>  > +static const struct pci_device_id via_vlink_fixup_tbl[] = {
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233_0), 17},
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233A), 17 },
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233C_0), 17 },
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8235), 16 },
>  > +	/* May not be needed for the 8237 */
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237), 15 },
>  > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237A), 15 },
>  >  	{ 0, },
> 
> This got me wondering what PCI_VDEVICE was, so I went looking.
> It's a libata'ism it seems with the comment..
> 
> /* move to PCI layer? */
> 
> Which sounds like a good idea to me.  But until this is moved,
> does quirks.c actually compile with this patch? I don't see
> an include of linux/libata.h there.
> 
> When it gets moved to the PCI layer, I wonder if it'd be worth
> doing the same thing to the second argument, so that we'd be
> able to do..
> 
> 	{ PCI_VDEVICE(VIA, VIA_8233_0), 17},
> 
> Or maybe even..
> 
> 	{ PCI_VDEVICE(VIA, 8233_0), 17},

Won't work, libata passes hex constants as the second argument...  which 
is the policy I'm encouraging for all places where the PCI_DEVICE_ID_xxx 
is only used in a single place.

	Jeff




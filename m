Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753849AbWKGBZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbWKGBZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 20:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbWKGBZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 20:25:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:186 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753849AbWKGBZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 20:25:37 -0500
Date: Mon, 6 Nov 2006 20:25:19 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       Wilco Beekhuizen <wilcobeekhuizen@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
Message-ID: <20061107012519.GC25719@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
	Wilco Beekhuizen <wilcobeekhuizen@gmail.com>,
	linux-kernel@vger.kernel.org
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com> <1162817254.5460.4.camel@localhost.localdomain> <1162847625.10086.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162847625.10086.36.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 09:13:45PM +0000, Alan Cox wrote:

 > +static const struct pci_device_id via_vlink_fixup_tbl[] = {
 > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233_0), 17},
 > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233A), 17 },
 > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233C_0), 17 },
 > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8235), 16 },
 > +	/* May not be needed for the 8237 */
 > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237), 15 },
 > +	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237A), 15 },
 >  	{ 0, },

This got me wondering what PCI_VDEVICE was, so I went looking.
It's a libata'ism it seems with the comment..

/* move to PCI layer? */

Which sounds like a good idea to me.  But until this is moved,
does quirks.c actually compile with this patch? I don't see
an include of linux/libata.h there.

When it gets moved to the PCI layer, I wonder if it'd be worth
doing the same thing to the second argument, so that we'd be
able to do..

	{ PCI_VDEVICE(VIA, VIA_8233_0), 17},

Or maybe even..

	{ PCI_VDEVICE(VIA, 8233_0), 17},

?

	Dave

-- 
http://www.codemonkey.org.uk

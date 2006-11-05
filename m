Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965872AbWKEMrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965872AbWKEMrh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 07:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965873AbWKEMrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 07:47:37 -0500
Received: from outbound-res.frontbridge.com ([63.161.60.49]:28781 "EHLO
	outbound2-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S965872AbWKEMrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 07:47:36 -0500
X-BigFish: V
Subject: Re: [PATCH 2/2] Workaround for SB600 SATA ODD issue
From: Conke Hu <conke.hu@amd.com>
Reply-To: conke.hu@amd.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: Luugi Marsan <luugi.marsan@amd.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1162661809.3160.53.camel@laptopd505.fenrus.org>
References: <20061103190004.9ED8DCBD48@localhost.localdomain>
	 <1162661809.3160.53.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: AMD
Date: Sun, 05 Nov 2006 20:45:14 +0800
Message-Id: <1162730714.8525.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6) 
X-OriginalArrivalTime: 05 Nov 2006 12:47:27.0123 (UTC) FILETIME=[8C5D9E30:01C700D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-04 at 18:36 +0100, Arjan van de Ven wrote:
> On Fri, 2006-11-03 at 14:00 -0500, Luugi Marsan wrote:
> > From: conke.hu@amd.com
> > 
> > There was an ASIC bug in the SB600 SATA controller of low revision (<=13) and CD burning may hang (only SATA ODD has this issue, and SATA HDD works well). The patch provides a workaround for this issue.
> > 
> > Signed-off-by:  Luugi Marsan <luugi.marsan@amd.com>
> > 
> > --- linux-2.6.19-rc4-git5/drivers/ata/ahci.c.orig       2006-11-04 03:56:22.000000000 +0800
> > +++ linux-2.6.19-rc4-git5/drivers/ata/ahci.c    2006-11-04 04:20:36.000000000 +0800
> > @@ -189,6 +189,7 @@ struct ahci_host_priv {
> >         unsigned long           flags;
> >         u32                     cap;    /* cache of HOST_CAP register */
> >         u32                     port_map; /* cache of HOST_PORTS_IMPL reg */
> > +       u8                      rev;    /* PCI Revision ID */
> >  };
> >  
> 
> why put this into the ahci struct rather than in the pci device struct?
> In the place you use it you already have the pci device struct already..
> and it's really a pci device property so putting it in that struct makes
> a whole lot of sense conceptually anyway...
> 
> 

Hi Arjan,
    Yes, I also thought it's more reasonable to add "u8 rev;" to pci_dev
than to ahci_host_priv, but that will effect source code in large scope,
so I added it here :(
    Maybe I should resend a patch both for pci_dev and SB600 SATA at the
same time.


Best regards,
Conke Hu


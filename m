Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbVCXUFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbVCXUFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVCXUFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:05:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:62915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S264290AbVCXUFd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:05:33 -0500
Date: Thu, 24 Mar 2005 12:05:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org, airlied@gmail.com
Subject: Re: 2.6.12-rc1-mm2
Message-Id: <20050324120504.32ee0656.akpm@osdl.org>
In-Reply-To: <200503241631.30681.s.rivoir@gts.it>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<200503241540.33012.s.rivoir@gts.it>
	<4242DA5A.4020904@ens-lyon.org>
	<200503241631.30681.s.rivoir@gts.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Alle 16:18, giovedì 24 marzo 2005, Brice Goglin ha scritto:
> > Stefano Rivoir a écrit :
> > > Alle 13:41, giovedì 24 marzo 2005, Andrew Morton ha scritto:
> > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/
> > >>2. 6.12-rc1-mm2/
> > >>
> > >>
> > >>- Some fixes for the recent DRM problems.
> > >
> > > Hi Andrew,
> > >
> > > While I was OK with DRM up to 2.6.12-rc1-mm1, now I get this at startup,
> > > and Xorg fails to enable DRI (attached, lspci and .config):
> 
> > --- linux-mm/include/linux/agp_backend.h.old    2005-03-24
> > 16:17:25.000000000 +0100
> > +++ linux-mm/include/linux/agp_backend.h        2005-03-24
> > 16:10:25.000000000 +0100
> > @@ -100,6 +100,7 @@
> >   extern int agp_bind_memory(struct agp_memory *, off_t);
> >   extern int agp_unbind_memory(struct agp_memory *);
> >   extern void agp_enable(struct agp_bridge_data *, u32);
> > +extern struct agp_bridge_data * (*agp_find_bridge)(struct pci_dev *);
> >   extern struct agp_bridge_data *agp_backend_acquire(struct pci_dev *);
> >   extern void agp_backend_release(struct agp_bridge_data *);
> 
> Right, that fixed it for me.
> 

There were contradictory patches in flight and I stuck the latest drm tree
into rc1-mm2 at the last minute, alas.  You should revert
agp-make-some-code-static.patch.

But I assume that fixing the compile warnings does not fix the oopses which
Stefano and Brice are seeing?


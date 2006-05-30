Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWE3MWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWE3MWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWE3MWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:22:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7102 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932267AbWE3MWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:22:37 -0400
Date: Tue, 30 May 2006 14:21:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] atyfb_base compile fix for CONFIG_PCI=n
In-Reply-To: <20060525040717.GA30317@kroah.com>
Message-ID: <Pine.LNX.4.64.0605301408290.32445@scrub.home>
References: <20060525002742.723577000@linux-m68k.org> <20060525003420.147932000@linux-m68k.org>
 <20060524183327.601f0a43.akpm@osdl.org> <20060525040717.GA30317@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 May 2006, Greg KH wrote:

> > >  Index: linux-2.6-mm/drivers/video/aty/atyfb_base.c
> > >  ===================================================================
> > >  --- linux-2.6-mm.orig/drivers/video/aty/atyfb_base.c
> > >  +++ linux-2.6-mm/drivers/video/aty/atyfb_base.c
> > >  @@ -3861,7 +3861,9 @@ static int __init atyfb_init(void)
> > >       atyfb_setup(option);
> > >   #endif
> > >   
> > >  +#ifdef CONFIG_PCI
> > >       pci_register_driver(&atyfb_driver);
> > >  +#endif
> > >   #ifdef CONFIG_ATARI
> > >       atyfb_atari_probe();
> > >   #endif
> > >  @@ -3870,7 +3872,9 @@ static int __init atyfb_init(void)
> > >   
> > >   static void __exit atyfb_exit(void)
> > >   {
> > >  +#ifdef CONFIG_PCI
> > >   	pci_unregister_driver(&atyfb_driver);
> > >  +#endif
> > >   }
> > 
> > bah.  If pci_register_driver() was a macro we wouldn't need to do this all
> > over the place.
> 
> Yes, this can be fixed easily in the pci.h header file, all other pci
> functions are stubbed out properly if CONFIG_PCI is not enabled.  These
> should be too.

I'm not a big fan of such dummy macros, as these macros should properly 
look like:

#define pci_register_driver(x)	({ (void)(x); 0; })

otherwise you risk warnings about defined but unused variables.

The other alternative is to remove the #ifdef around atyfb_driver, recent 
gcc (>= 4.0) can remove the unused structure.

bye, Roman

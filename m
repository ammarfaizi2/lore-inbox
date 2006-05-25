Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWEYE3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWEYE3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWEYE3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:29:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964991AbWEYE3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:29:41 -0400
Date: Wed, 24 May 2006 21:28:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] atyfb_base compile fix for CONFIG_PCI=n
Message-Id: <20060524212857.6ba0690a.akpm@osdl.org>
In-Reply-To: <20060525040717.GA30317@kroah.com>
References: <20060525002742.723577000@linux-m68k.org>
	<20060525003420.147932000@linux-m68k.org>
	<20060524183327.601f0a43.akpm@osdl.org>
	<20060525040717.GA30317@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Wed, May 24, 2006 at 06:33:27PM -0700, Andrew Morton wrote:
> > zippel@linux-m68k.org wrote:
> > >
> > >  The atyfb_driver structure is only available if CONFIG_PCI is set.
> > > 
> > >  Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> > > 
> > >  ---
> > > 
> > >   drivers/video/aty/atyfb_base.c |    4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
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
> 

Well pci_register_driver() and pci_unregister_driver() do have stubs.  But
they're static-inlines, hence they reference their argument, hence the
above ifdefs.

But if the pci_register_driver() and pci_unregister_driver() stubs were
macros which do not reference their argument, the above ifdefs aren't
needed.


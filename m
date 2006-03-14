Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWCNV7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWCNV7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWCNV7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:59:34 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:19605
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932532AbWCNV7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:59:33 -0500
Date: Tue, 14 Mar 2006 13:59:22 -0800
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, maule@sgi.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060314215922.GA12257@suse.de>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314134535.72eb7243.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 01:45:35PM -0800, Andrew Morton wrote:
> "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com> wrote:
> >
> > Declare msi_register() in msi.h.
> > 
> > The patch is especially necessary for ia64 on which most of files
> > emit compiler warnings like below:
> >   include2/asm/msi.h: In function `ia64_msi_init':
> >   include2/asm/msi.h:23: warning: implicit declaration of function `msi_register'
> >   In file included from include2/asm/machvec.h:408,
> >                  from include2/asm/io.h:70,
> >                  from include2/asm/smp.h:20,
> >                  from /build/rc6/source/include/linux/smp.h:22,
> 
> I wonder why I didn't get that.  Need a better ia64 config I guess.
> 
> > Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> > 
> > --- linux-2.6.16-rc6-mm1.orig/include/asm-ia64/msi.h	2006-03-14 13:54:11.000000000 -0500
> > +++ linux-2.6.16-rc6-mm1/include/asm-ia64/msi.h	2006-03-14 14:05:26.000000000 -0500
> > @@ -15,6 +15,7 @@ static inline void set_intr_gate (int nr
> >  #define MSI_TARGET_CPU_SHIFT	4
> >  
> >  extern struct msi_ops msi_apic_ops;
> > +extern int msi_register(struct msi_ops *);
> >  
> >  /* default ia64 msi init routine */
> >  static inline int ia64_msi_init(void)
> 
> The offending patch is gregkh-pci-msi-vector-targeting-abstractions.patch.
> 
> That patch already adds a declaration for msi_register(), in
> drivers/pci/pci.h.  We don't want to add a duplicated declaration like
> this.
> 
> One option might be to create inclued/linux/msi.h, put this declaration in
> there then include <asm/msi.h>.  Possibly some other declarations should be
> moved into linux/msi.h as well.

Ugh.  What is the file that is causing the problem?  What is "include2"
in your directory path above?

Whatever .c file has it, should just include the internal pci.h file
that already has this prototype, like Andrew says...

thanks,

greg k-h

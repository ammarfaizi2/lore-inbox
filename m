Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWFOEiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWFOEiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 00:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWFOEiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 00:38:20 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62879 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751198AbWFOEiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 00:38:19 -0400
Date: Thu, 15 Jun 2006 00:28:06 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060615042806.GC8587@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <11501587082203-git-send-email-greg@kroah.com> <11501587122736-git-send-email-greg@kroah.com> <11501587153872-git-send-email-greg@kroah.com> <11501587193060-git-send-email-greg@kroah.com> <11501587223213-git-send-email-greg@kroah.com> <11501587273612-git-send-email-greg@kroah.com> <11501587303683-git-send-email-greg@kroah.com> <11501587343689-git-send-email-greg@kroah.com> <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be> <20060614233507.GA23629@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614233507.GA23629@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 04:35:07PM -0700, Greg KH wrote:
> On Wed, Jun 14, 2006 at 02:20:06PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 12 Jun 2006, Greg KH wrote:
> > > From: Greg Kroah-Hartman <gregkh@suse.de>
> > > 
> > > Introduce the Kconfig entry and actually switch to a 64bit value, if
> > > wanted, for resource_size_t.
> > 
> > > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > > index 805b81f..22dcaa5 100644
> > > --- a/arch/m68k/Kconfig
> > > +++ b/arch/m68k/Kconfig
> > > @@ -368,6 +368,13 @@ config 060_WRITETHROUGH
> > >  
> > >  source "mm/Kconfig"
> > >  
> > > +config RESOURCES_32BIT
> > > +	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
> > > +	depends on EXPERIMENTAL
> > > +	help
> > > +	  By default resources are 64 bit. This option allows memory and IO
> > > +	  resources to be 32 bit to optimize code size.
> > > +
> > >  endmenu
> > 
> > Why is the default 64 bit? Because 32 bit became experimental?
> 
> That's a really good question.  Vivek, why did you change it to be this
> way?  In thinking about it some more, this should be a 64bit option
> instead.
> 

I thought 64bit is more inclusive. Works both for 32bit and 64bit BARs.
Also exports memory more than 4G through /proc/iomem without selecting
an additional option in config file. The flip side is that it introduces
little memory overhead. I thought most of the users should be ok with this
increased memory usage and those who are particular, they can choose
RESOURCES_32BIT.

Thanks
Vivek

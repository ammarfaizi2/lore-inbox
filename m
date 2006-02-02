Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWBBQRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWBBQRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWBBQRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:17:08 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:43999 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S932101AbWBBQRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:17:06 -0500
Subject: Re: [PATCH] EDAC printk() cleanup
From: doug thompson <dthompson@linuxnetworx.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>,
       Gunther Mayer <gunther.mayer@gmx.net>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602011916.29281.dsp@llnl.gov>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
	 <200601301653.15984.dsp@llnl.gov> <m3zmldjd31.fsf@maxwell.lnxi.com>
	 <200602011916.29281.dsp@llnl.gov>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 09:16:53 -0700
Message-Id: <1138897013.23854.34.camel@logos.linuxnetworx.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 19:16 -0800, Dave Peterson wrote:
> On Monday 30 January 2006 19:22, Eric W. Biederman wrote:
> > One piece missing from this conversation is the issue that we need errors
> > in a uniform format.  That is why edac_mc has helper functions.
> >
> > However there will always be errors that don't fit any particular model.
> > Could we add a edac_printk(dev, );  That is similar to dev_printk but
> > prints out an EDAC header and the device on which the error was found?
> > Letting the rest of the string be user specified.
> >
> > For actual control that interface may be to blunt, but at least for people
> > looking in the logs it allows all of the errors to be detected and
> > harvested.
> 
> Ok, the patch below (which applies to the 2.6.16-rc1-git4 kernel) is
> an initial attempt at implementing this sort of thing.  Here is some
> sample output (produced by loading the edac_mc and e7xxx_edac
> moules):
> 
>     EDAC MC: /tftpboot/dsp/printk/linux/drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb  1 2006
>     EDAC DEBUG: /tftpboot/dsp/printk/linux/drivers/edac/edac_mc.c: edac_sysfs_memctrl_setup()
>     EDAC DEBUG: Registered '.../edac/mc' kobject
>     EDAC DEBUG: /tftpboot/dsp/printk/linux/drivers/edac/edac_mc.c: edac_sysfs_pci_setup()
>     EDAC DEBUG: Registered '.../edac/pci' kobject
>     EDAC DEBUG: /tftpboot/dsp/printk/linux/drivers/edac/e7xxx_edac.c: e7xxx_init_one()
>     EDAC DEBUG: /tftpboot/dsp/printk/linux/drivers/edac/e7xxx_edac.c: e7xxx_probe1(): mci
>     EDAC e7xxx: tolm = 40000, remapbase = ffc000, remaplimit = 0
>     EDAC DEBUG: /tftpboot/dsp/printk/linux/drivers/edac/edac_mc.c: edac_mc_add_mc()
>     EDAC DEBUG: /tftpboot/dsp/printk/linux/drivers/edac/edac_mc.c: edac_create_sysfs_mci_device() idx=0
>     EDAC DEBUG: /tftpboot/dsp/printk/linux/drivers/edac/edac_mc.c: edac_create_csrow_object()
>     EDAC DEBUG: Registered CSROW0
>     EDAC MC0: Giving out device to e7xxx_edac E7500: PCI 0000:00:00.0
> 


Yes, yes, yes

that is exactly what I had in mind. The old stuff bothered me something
bad, but I couldn't put my finger on exactly how to fix it yet - didn't
have the time.

It gives subsystem info (EDAC), modules therein, a bit of context then
event descriptions.

thanks dave and eric and good work

doug t



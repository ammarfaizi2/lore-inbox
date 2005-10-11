Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVJKXEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVJKXEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJKXEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:04:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:20677 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932076AbVJKXEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:04:12 -0400
Date: Tue, 11 Oct 2005 18:04:09 -0500
To: Greg KH <greg@kroah.com>
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 20/22] PCI Error Recovery: e100 network device driver
Message-ID: <20051011230409.GS29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com> <20051006235729.GU29826@austin.ibm.com> <20051011001056.GA16634@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011001056.GA16634@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 05:10:56PM -0700, Greg KH was heard to remark:
> On Thu, Oct 06, 2005 at 06:57:29PM -0500, linas wrote:
> > +config E100_EEH_RECOVERY
> > +	bool "Enable PCI bus error recovery"
> > +	depends on E100 && PPC_PSERIES
> > +   help
> > +      If you say Y here, the driver will be able to recover from
> > +      PCI bus errors on many PowerPC platforms. IBM pSeries users
> > +      should answer Y.
> 
> Why make a config option for this at all?  Who would turn it off?

I wanted to have this turned off for anyone who didn't have 
hardware capable of supporting this, and didn't really think 
about how to hide this from the menu.  I guess its best to
just plain hide this, keep the menus from getting cluttered.

> > @@ -2661,6 +2731,9 @@
> >  	.resume =       e100_resume,
> >  #endif
> >  	.shutdown =	e100_shutdown,
> > +#ifdef CONFIG_E100_EEH_RECOVERY
> > +	.err_handler = &e100_err_handler,
> > +#endif /* CONFIG_E100_EEH_RECOVERY */
> 
> No, don't put #ifdefs in the middle of a structure, remember we made
> err_handler always present in the .h file for a reason...

OK.

I'll send revised patches patches tommorrw, hiding the config, and 
removing the ifdef.

--linas

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752469AbWCGB55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbWCGB55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWCGB55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:57:57 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:33411
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752468AbWCGB5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:57:55 -0500
Date: Mon, 6 Mar 2006 17:57:35 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Al Viro <viro@ftp.linux.org.uk>, Dave Peterson <dsp@llnl.gov>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060307015735.GB22239@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <20060306213203.GJ27946@ftp.linux.org.uk> <20060306215344.GB16825@kroah.com> <200603062046.00906.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603062046.00906.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 08:45:59PM -0500, Dmitry Torokhov wrote:
> On Monday 06 March 2006 16:53, Greg KH wrote:
> > On Mon, Mar 06, 2006 at 09:32:03PM +0000, Al Viro wrote:
> > > On Mon, Mar 06, 2006 at 01:01:37PM -0800, Dave Peterson wrote:
> > > > Regarding the above problem with the kobject reference count, this
> > > > was recently fixed in the -mm tree (see edac-kobject-sysfs-fixes.patch
> > > > in 2.6.16-rc5-mm2).  The fix I implemented was to add a call to
> > > > complete() in edac_memctrl_master_release() and then have the module
> > > > cleanup code wait for the completion.  I think there were a few other
> > > > instances of this type of problem that I also fixed in the
> > > > above-mentioned patch.
> > > 
> > > This is not a fix, this is a goddamn deadlock.
> > > 	rmmod your_turd </sys/spew/from/your_turd
> > > and there you go.  rmmod can _NOT_ wait for sysfs references to go away.
> > 
> > To be fair, the only part of the kernel that supports the above process,
> > is the network stack.  And they implemented a special kind of lock to
> > handle just this kind of thing.
> > 
> 
> Not so:
> 
> [root@core ~]# rmmod psmouse < /sys/bus/serio/devices/serio0/rate
> ERROR: Module psmouse is in use
> [root@core ~]# rmmod psmouse
> [root@core ~]# modprobe psmouse
> [root@core ~]# 
> 
> It would be nice if more subsystem could handle this, preferably without
> "Waiting for blah to become free" messages (as in W1).

See my previous apology about this :)

Anyway, the network stack does have a special lock for unloading modules
while they are still "in use", but as long as Al was referring to your
above sequence, I have no disagreement.

thanks,

greg k-h

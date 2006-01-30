Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWA3VEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWA3VEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWA3VEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:04:42 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:22158 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S964991AbWA3VEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:04:42 -0500
Subject: Re: noisy edac
From: doug thompson <dthompson@linuxnetworx.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: Doug Thompson <norsk5@yahoo.com>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@redhat.com>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200601301158.09438.dsp@llnl.gov>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
	 <200601301158.09438.dsp@llnl.gov>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 14:04:21 -0700
Message-Id: <1138655061.8251.74.camel@logos.linuxnetworx.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 11:58 -0800, Dave Peterson wrote:
> On Monday 30 January 2006 10:59, Doug Thompson wrote:
> > that driver should be refactored to only output NON-FATALs with debug
> > turned on.
> 
> I would prefer a sysfs option or something similar that allows the user
> to determine what action to take on these errors.  I think the debug
> option should only pertain to messages whose purpose is for debugging
> the EDAC code itself, as opposed to hardware errors detected by EDAC.

Something like an ERROR report verbose level?  0 to 7 like?

0 being quiet, 7 being very verbose? or the reverse. 

/sys/drivers/system/edac/mc/error_report_verbosity   ????

This tackles the immediate issue, but there is a systemic issue we have
to face sometime.

One problem that this e752x_edac module exhibits, which is manifest on
all of the drivers to one degree, is the output of driver specific error
messages directly, since there is not an abstracted error interface
(yet) in the EDAC core.  The messages are or can be very specific to the
MC being driven.  In time, we can (should) add a better MC error
interface to the core and then map errors from specific MC errors to the
new CORE error interface. Similiar to how SCSI and SATA have higher
level abstract errors which the transport drivers map errors to.

This e752x_edac module just plainly outputs to printk() with
KERN_WARNING w/o any other output control.

Looks like the old "how do we report errors" pattern, with its first
implementation now looking old.

doug t



> 
> > Copying to edac/bluesmoke mailing list
> >
> > doug t
> >
> > --- Dave Jones <davej@redhat.com> wrote:
> > > On Sun, Jan 29, 2006 at 04:52:06PM -0500, Alan Cox wrote:
> > >  > On Thu, Jan 26, 2006 at 08:41:05PM -0500, Dave Jones wrote:
> > >  > > e752x_edac is very noisy on my PCIE system..
> > >  > > my dmesg is filled with these...
> > >  > >
> > >  > > [91671.488379] Non-Fatal Error PCI Express B
> > >  > > [91671.492468] Non-Fatal Error PCI Express B
> > >  > > [91901.100576] Non-Fatal Error PCI Express B
> > >  > > [91901.104675] Non-Fatal Error PCI Express B
> > >  >
> > >  > Pre-production system or final release ?
> > >
> > > Currently shipping Dell Precision 470.
> > >
> > > 		Dave
> 



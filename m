Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWBRBEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWBRBEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWBRA5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:44 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:51165
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751814AbWBRA5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:23 -0500
Date: Fri, 17 Feb 2006 16:57:13 -0800
From: Greg KH <gregkh@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, Paul Bristow <paul@paulbristow.net>,
       mpm@selenic.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060218005713.GA11197@suse.de>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060218000921.GA15894@suse.de> <200602171648.38003.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602171648.38003.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:48:37PM -0800, David Brownell wrote:
> On Friday 17 February 2006 4:09 pm, Greg KH wrote:
> > On Fri, Feb 17, 2006 at 11:47:02PM +0100, Sam Ravnborg wrote:
> 
> > > WARNING: drivers/usb/gadget/g_ether.o - Section mismatch: reference to .init.text from .data between 'eth_driver' (at offset 0x10) and 'stringtab'
> > > WARNING: drivers/usb/gadget/g_file_storage.o - ... etc ...
> >
> > David, these all look like they are due to the calls in the
> > drivers/usb/gadget/epautoconf.c file from functions within the gadget
> > drivers.  It looks like it's all safe, but can you verify that the bind
> > callback is finished before module_init() exits?
> 
> If they just usb_gadget_register_driver(), that's how it's defined to
> work yes.  (Though a spec lawyer might want more explicit language ...)
> 
> 
> > And if so, we should mark the bind functions __init also, to prevent
> > this from being flagged in the future.
> 
> And the unbind functions __exit/__exit_p()?  Smaller runtime footprints
> are good.  I don't like leaving the driver->init() method invalid, which
> is I think why I didn't do that before, but saving space is the right
> thing to do.

Ok, care to create a patch for these?

> > > WARNING: drivers/usb/host/isp116x-hcd.o - Section mismatch: reference to .init.text from .data between '' (at offset 0x0) and 'isp116x_hc_driver'
> > 
> > This looks like the isp116x_remove function just needs to get the looney
> > __init_or_module marking of of it.  Again, David, do you agree?
> 
> Right; that marking is for infrastructure, not drivers.

Ok, I'll take care of this, thanks for verifying it.

greg k-h

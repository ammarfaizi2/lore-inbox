Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWAaAce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWAaAce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWAaAce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:32:34 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:31942 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1030243AbWAaAce
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:32:34 -0500
Subject: Re: noisy edac
From: doug thompson <dthompson@linuxnetworx.com>
To: Gunther Mayer <gunther.mayer@gmx.net>
Cc: Dave Peterson <dsp@llnl.gov>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43DEA922.3030602@gmx.net>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
	 <200601301424.16884.dsp@llnl.gov> <43DEA4CA.8070700@gmx.net>
	 <200601301552.09955.dsp@llnl.gov>  <43DEA922.3030602@gmx.net>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 17:32:29 -0700
Message-Id: <1138667549.8251.90.camel@logos.linuxnetworx.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 01:02 +0100, Gunther Mayer wrote:
> Dave Peterson wrote:
> 
> >On Monday 30 January 2006 15:44, Gunther Mayer wrote:
> >  
> >
> >>>For each individual type of error that is specific to a particular
> >>>low-level chipset driver (e752x, amd76x, etc.) there could be an entry
> >>>in the appropriate part of the sysfs hierarchy under the given chipset
> >>>driver.  This entry could have several settings that the user may choose
> >>>      
> >>>
> >>>from such as { ignore, syslog, panic }.  For the implementation, there
> >>    
> >>
> >>>could be a generic piece of code in the core EDAC module that a chipset
> >>>driver calls into.  The generic code would do the dirty work of creating
> >>>the sysfs entries (and destroying them when the chipset module is
> >>>unloading).  How does this sound?
> >>>      
> >>>
> >>Over-Engineered.
> >>    
> >>
> >
> >Do you have an alternate suggestion?
> >  
> >
> Just printk() the exact driver specific low-level error, even if non-fatal.
> 
> Single non-fatal errors just show your system recovers correctly.
> 
> Multiple (e.g. noisy) non-fatal are either an indication of a serious 
> problem
>   (e.g. after how many corrected ECC errors on the same address in which
>     time interval will you replace your dimm? How many S-ATA CRC-errors
>      will indicate marginal bad cabling? )
> or it shows the problem needs to be root analyzed. But don't disable the
> messages as this will only hide the real problem.
> 
> Concerning Non-Fatal PCI Express errors, the error cause registers need
> to be printed in case of error, too (see Intel Chipset Specifications)

EDAC currently presents a common interface for harvesting the number of
CEs (and other data) that occur AND maps to a DIMM label, which can be
populated to a mobo silk screen label.  This is via the sysfs interface.

Currently each of the MC drivers some of their output error messages in
their own pattern of output, while also funnelling common info to the
core module.  We don't want to lose that device specific information,
but it would be a better pattern to funnel that device specific output
to the EDAC Core module for presentation in a more uniforum manner,
through the new sysfs interface, such as:

/sys/drivers/system/edac/mc/mc_driver_error_report

or some such.

The EDAC stack is like a SCSI stack:  A core module and a lower level
instance driver.

We want to move some of the information that is currently being dumped
via printk() to the sysfs interface. Some not all.

The message that is being printed now that caused this post, just prints
some MC specific information, but not quite enough to be of real use.
It is extra noise, which needs to be examined in depth, to form a clean
error stack.

New MC drivers are in the works. New MC chipsets are coming down the
line and I don't want to have each driver output its OWN output that
proves more difficult to "harvest" over time, because each driver writer
does it his way.

EDAC is not perfect enough yet, but with time and more refactoring it
will approach there.

thanks

doug t

> -
> Gunther
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> bluesmoke-devel mailing list
> bluesmoke-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluesmoke-devel


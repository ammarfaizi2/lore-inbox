Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWA3WYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWA3WYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWA3WYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:24:32 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:56281 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S965003AbWA3WYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:24:31 -0500
From: Dave Peterson <dsp@llnl.gov>
To: doug thompson <dthompson@linuxnetworx.com>
Subject: Re: noisy edac
Date: Mon, 30 Jan 2006 14:24:16 -0800
User-Agent: KMail/1.5.3
Cc: Doug Thompson <norsk5@yahoo.com>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@redhat.com>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com> <200601301158.09438.dsp@llnl.gov> <1138655061.8251.74.camel@logos.linuxnetworx.com>
In-Reply-To: <1138655061.8251.74.camel@logos.linuxnetworx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301424.16884.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 13:04, doug thompson wrote:
> Something like an ERROR report verbose level?  0 to 7 like?
>
> 0 being quiet, 7 being very verbose? or the reverse.
>
> /sys/drivers/system/edac/mc/error_report_verbosity   ????
>
> This tackles the immediate issue, but there is a systemic issue we have
> to face sometime.
>
> One problem that this e752x_edac module exhibits, which is manifest on
> all of the drivers to one degree, is the output of driver specific error
> messages directly, since there is not an abstracted error interface
> (yet) in the EDAC core.  The messages are or can be very specific to the
> MC being driven.  In time, we can (should) add a better MC error
> interface to the core and then map errors from specific MC errors to the
> new CORE error interface. Similiar to how SCSI and SATA have higher
> level abstract errors which the transport drivers map errors to.
>
> This e752x_edac module just plainly outputs to printk() with
> KERN_WARNING w/o any other output control.
>
> Looks like the old "how do we report errors" pattern, with its first
> implementation now looking old.

For each individual type of error that is specific to a particular
low-level chipset driver (e752x, amd76x, etc.) there could be an entry
in the appropriate part of the sysfs hierarchy under the given chipset
driver.  This entry could have several settings that the user may choose
from such as { ignore, syslog, panic }.  For the implementation, there
could be a generic piece of code in the core EDAC module that a chipset
driver calls into.  The generic code would do the dirty work of creating
the sysfs entries (and destroying them when the chipset module is
unloading).  How does this sound?

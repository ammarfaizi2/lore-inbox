Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265820AbUFXVHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUFXVHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbUFXVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:06:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:15267 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265693AbUFXVDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:03:22 -0400
Date: Thu, 24 Jun 2004 13:59:37 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jeremy Katz <jeremy.katz@gmail.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       katzj@redhat.com
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Message-ID: <20040624205936.GA2009@kroah.com>
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com> <20040618151753.GA21596@infradead.org> <cb5afee1040620125272ab9f06@mail.gmail.com> <20040621060435.GA28384@kroah.com> <cb5afee10406210914451dc6@mail.gmail.com> <cb5afee10406231415293e90c0@mail.gmail.com> <20040623220303.GD6548@kroah.com> <40DA2272.8050106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DA2272.8050106@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 08:38:10PM -0400, Jeff Garzik wrote:
> >But what you can use is the MODULE_DEVICE_TABLE() information in the
> >modules to try to help you out here.  That details a mapping of what
> >kind of devices that specific driver supports.
> 
> No, it details what devices a driver supports, not what _type_ of 
> devices the driver supports.

Yes, you are correct. 

> >>Note: this should not mean that we then go and remove currently
> >>existing stuff in /proc.  Deprecate it and then it can go away in time
> >>as people switch.  Having to have a flag day is very painful.  It's
> >>far easier to deprecate in one stable series with a new interface
> >>available and then start removing the old ones as things start to
> >>switch over.  If it really is an improvement, then getting people to
> >>change won't be difficult.
> >
> >
> >I agree, I don't think that many things have disappeared from /proc just
> >yet, right?  You should just have more information than what you
> >previously did, right?  Or did scsi drop their /proc support fully?
> 
> Concrete example:  modprobe sx8.  Now, what block devices did it detect?

Could we determine this in 2.4?

Anyway, how about this assuming sx8 is a pci driver:
	- look in /sys/bus/pci/drivers/sx8/
	- for every device listed in that directory do:
		- `tree | grep block` or however you want to search the
		  tree for the block symlink, find is probably nicer
		  here.
		- that gives you the base block device, then go into the
		  /sys/block/FOUND_BLOCK_DEVICE to find the individual
		  partitions if needed.

Or work backwards if you want to:
	- tally up every /sys/block/*/device symlink, and see if they
	  point to a device owned by the sx8 driver.

Does that work for you?

thanks,

greg k-h

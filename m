Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275449AbRJFSTf>; Sat, 6 Oct 2001 14:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275448AbRJFSTP>; Sat, 6 Oct 2001 14:19:15 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:9359 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275449AbRJFSTH>; Sat, 6 Oct 2001 14:19:07 -0400
Date: Sat, 6 Oct 2001 14:19:37 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110061819.f96IJbg04607@devserv.devel.redhat.com>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <mailman.1002371041.9232.linux-kernel2news@redhat.com>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain> <d3n136tc48.fsf@lxplus014.cern.ch> <15294.47999.501719.858693@cargo.ozlabs.ibm.com> <20011006.013819.17864926.davem@redhat.com> <mailman.1002371041.9232.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I can not even count on one hand how many people I've helped
> > converting, who wanted a bus_to_virt() and when I showed them
> > how to do it with information the device provided already they
> > said "oh wow, I never would have thought of that".  That process
> > won't happen as often with the suggested feature.

> I look at all the hash-table stuff in the usb-ohci driver and I think
> to myself about all the complexity that is there (and I haven't
> managed to convince myself yet that it is actually SMP-safe) and all
> the time wasted doing that stuff, when on probably 95% of the
> machines that use the usb-ohci driver, the hashing stuff is totally
> unnecessary.  I am talking about powermacs, which don't have an iommu,
> and where the reverse mapping is as simple as adding a constant.

That's one kinky driver, no wonder you were traumatized by looking
at it. I think you must not project the shock and horror of usb-ohci
onto other drivers. Gerard already defended the Symbios SCSI.

There may be some approaches to deal with the problem. One is
to leave hash in and clean up the rest. It would probably
break a number of devices and take a time to straighten out.
Another possibility is to limit the number of URBs that are
posted in any given time to the hardware.

> That was my second argument, which you didn't reply to - that doing
> the reverse mapping is very simple on some platforms, and so the right
> place to do reverse mapping is in the platform-aware code, not in the
> drivers.  On other platforms the reverse mapping is more complex, but
> the complexity is bounded by the complexity that is already there in
> drivers like the usb-ohci driver.

No, it's not bounded. Outside implementation has to be much more
complex to accomodate slightly different requirements of different
drivers.

And remember, you can put it in, but cannot pull it out.

-- Pete

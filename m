Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbTEQGtl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 02:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTEQGtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 02:49:41 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:41123 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261261AbTEQGtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 02:49:40 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: request_firmware() hotplug interface, third round.
Date: Sat, 17 May 2003 09:02:58 +0200
User-Agent: KMail/1.5.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ranty@debian.org,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
References: <1053101342.5589.5.camel@dhcp22.swansea.linux.org.uk> <200305170013.49808.oliver@neukum.org> <20030517045008.GD13827@zax>
In-Reply-To: <20030517045008.GD13827@zax>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305170902.58835.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 17. Mai 2003 06:50 schrieb David Gibson:
> On Sat, May 17, 2003 at 12:13:49AM +0200, Oliver Neukum wrote:
> > Am Freitag, 16. Mai 2003 18:09 schrieb Alan Cox:
> > > On Gwe, 2003-05-16 at 09:07, Oliver Neukum wrote:
> > > > So, if I understand you correctly, RAM is only saved if a device
> > > > is hotpluggable and needs firmware only upon intial connection.
> > > > Which, if you do suspend to disk correctly, is no device.
> > >
> > > Thats just because the interface is a little warped not the theory.
> > > On a resume you need to reload firmware and you already handle
> > > rediscovery on USB bus for example because the devices can change
> >
> > Right. But the order of resumption is fixed by hardware needs.
> > So during resumption you cannot use block devices and therefore
> > not start a hotplug script. Or did I miss something?
>
> For devices that aren't essentialy to get userspace running
> (e.g. network on a laptop running from local disk), the firmware
> request doesn't have to happen during the hairy part of resumption.

Not true for network cards. Somebody might be running NFS
over it. The problem is that you cannot tell (or rather shouldn't - it's
a layering violation).

Anything that is used for paging needs to be back to life before
you can think about resurrecting user space.
Also you need to bring keyboards back to life early to make
sysreq work.

Secondly, you need a way to get essential devices to work in
all cases. If you implement it, why not use it?

> The device could just mark itself as unusable at suspend time, then at
> resume it schedule_work()s something to reload the firmware and
> complete reinitialization.  Shortly after userspace is back in action,
> the device will come back to life.

Is supposed to. You cannot put blind trust into that. You need to use
a pretty arbitrary timeout to deal with this.

I fail to see technical improvements here.

	Regards
		Oliver


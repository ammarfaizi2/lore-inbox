Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268672AbTBZHWO>; Wed, 26 Feb 2003 02:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268673AbTBZHWO>; Wed, 26 Feb 2003 02:22:14 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:60087 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268672AbTBZHWN>; Wed, 26 Feb 2003 02:22:13 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Oliver Neukum <oliver@neukum.name>, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB speedtouch: better proc info
Date: Wed, 26 Feb 2003 08:31:57 +0100
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       chas williams <chas@locutus.cmf.nrl.navy.mil>
References: <200302241058.52073.baldrick@wanadoo.fr> <200302250922.35971.baldrick@wanadoo.fr> <200302252154.44628.oliver@neukum.name>
In-Reply-To: <200302252154.44628.oliver@neukum.name>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302260831.58094.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tuesday 25 February 2003 21:54, Oliver Neukum wrote:
> > Hi Oliver, thanks for your comments.  While I agree with you in
> > principle, I disagree in practice.  The driver exports the following
> > information in /proc/net/atm/speedtch:
> >
> > (1) name and location of the USB device
> > (2) MAC address (serial number)
> > (3) AAL5 transmission statistics
> > (4) Line status
> > (5) Modem status
> >
> > (1) is needed in order to work out which modem corresponds to
> > which ATM device.  This should be dealt with using sysfs, however
> > the ATM layer has not yet been ported to sysfs.  Until it is, this
> > seems like the best way to export this information.
>
> For the time being I agree.
>
> > (2) and (3) are redundant - they are published by the ATM layer
> > in other proc files.  I thought about removing them, but decided
> > against it because (a) it can be convenient having everything in
> > one proc file, and (b) it is backwards compatible with the 2.4
> > out-of-kernel driver.  They could go.
>
> As long as you have a proc file at all, you may as well print them, IMHO.
>
> > You suggested (in a private mail) using netif_carrier_on/off to
> > export (4).  The ATM layer already has a method for reporting this,
> > and I use it: set the ATM_PHY_SIG_FOUND/LOST bits in
> > atm_dev->signal.  The problem is that the ATM layer doesn't do
> > anything with this info (like export it to user space).  So I think
> > it is fair enough to export it in the proc file while waiting for the
> > ATM layer to be fixed.
>
> Yes, but I think that you should notify the network layer too.
> I see no reason any network driver shouldn't report this directly.
> There's nothing specific to ATM in losing signal.
> It's purely physical thing low level drivers should deal with.

I can't notify the network layer because there is no net_device I can
get hold of.

> > As for (5), this could be exported using sysfs.  Since it is a
> > USB matter, I guess I could do this now.  So this could also go.
>
> Yes.

Shall I ask Greg to apply the patch?

All the best,

Duncan.

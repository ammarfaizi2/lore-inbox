Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTLDBDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTLDBDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:03:13 -0500
Received: from ns1.skjellin.no ([80.239.42.66]:10700 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262789AbTLDBDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:03:04 -0500
Subject: Re: Serial ATA (SATA) for Linux status report
From: Andre Tomt <lkml@tomt.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <3FCE737C.1080105@pobox.com>
References: <20031203204445.GA26987@gtf.org>
	 <1070494030.15415.111.camel@slurv.pasop.tomt.net>
	 <3FCE737C.1080105@pobox.com>
Content-Type: text/plain
Message-Id: <1070499770.15415.158.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Dec 2003 02:02:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-04 at 00:36, Jeff Garzik wrote:
> Andre Tomt wrote:
> > One question - with "including hotplug", does that mean some set hotplug
> > standard? Reason I'm asking is, we have a few servers from SuperMicro,
> > with a ICH5R S-ATA controller that claims it's supporting hotplug, but
> > hotplug is not in your ICH5-summary.
> 
> Alas, there is no hotplug support in the ICH5 or ICH5-R SATA hardware.
> 
> One could argue there is "coldplug" support in that hardware -- disable 
> the entire interface, including any active devices, then re-enable and 
> re-scan -- but it's a bit of a hack.  If there's enough demand, I could 
> write some code for that.  It would involve something like
> 
> 	# /sbin/sata off
> 	{ plug in or remove a device }
> 	# /sbin/sata on
> 
> You really, really, really don't want to actually unplug a SATA drive 
> while it's active, on ICH5 hardware.

Hmm. There is a backplane involved, that might change things a little.

Quoting the manual:
"A Serial ATA controller is incorporated into the 875P chipset to
provide a two-port Serial ATA subsystem, which is RAID 0 and RAID 1
supported. The Serial ATA drives are hot-swappable units. Note: The
operating system you use must have RAID support to enable the hot-swap
capability and RAID function of the Serial ATA drives."

"The Serial ATA drives plug into a backplane that provides power, drive
ID and bus termination. A RAID controller can be used with the backplane
to provide data security. The operating system you use must have RAID
support to enable the hot-swap capability of the Serial ATA drives."

The wording here is a little confusing, but hot-swap seems to work quite
well with intels windows fakeraid-drivers, at least. One just pushes the
"i'm going to pull you out now"-button on the tray, and pull the drive
tray out. Maybe it triggers an event to the fakeraid-driver, wich then
powers down the bus? black backplane-magic?

Anyways, REAL S-ATA hardware RAID controllers are pretty cheap over here
nowadays..

[trimmed off linux-scsi]


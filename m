Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTCEGOV>; Wed, 5 Mar 2003 01:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTCEGOU>; Wed, 5 Mar 2003 01:14:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10501 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263215AbTCEGOU>;
	Wed, 5 Mar 2003 01:14:20 -0500
Date: Tue, 4 Mar 2003 22:15:20 -0800
From: Greg KH <greg@kroah.com>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org,
       "Mathiasen, Torben" <Torben.Mathiasen@hp.com>,
       "Ni, Michael" <Michael.Ni@hp.com>
Subject: Re: PCI hotplug question.
Message-ID: <20030305061520.GA26727@kroah.com>
References: <45B36A38D959B44CB032DA427A6E106404513370@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B36A38D959B44CB032DA427A6E106404513370@cceexc18.americas.cpqcorp.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 05:10:16PM -0600, Cameron, Steve wrote:
> 
> So, the question is this.  For HBA drivers, block storage drivers in
> particular, are there plans to make hot-unplugging behave similarly to
> rmmod (checking that nobody has the device open before kicking
> the driver out and so on) or, is it the driver's duty to defend 
> against incoming i/o's to devices which may be yanked out from
> underneath it whenever somebody presses the pushbutton?

I can't find my copy of the PCI Hotplug spec right now (and it's not
free for download anymore...), but I think that once a user presses the
latch button, the OS _has_ to power down that slot within a reasonable
amount of time.  So there's no way that a driver could return an error
to the remove() callback and have a chance to still be around in a
moment or so.  And some systems (ACPI controlled PCI Hotplug), we don't
have a choice, as the BIOS is about to do the powerdown anyway, and we
can't stop it.

So no, we can't rely on the same module count type mechanism that rmmod
can use, so the driver has to do everything it possibly can to shutdown
that device, and clean up after itself when remove() is called.

I'll try to find my copy of the spec to verify this, but it might take a
while to dig it up.  Anyone else with access to it right now?

thanks,

greg k-h

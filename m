Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbUDQIHg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbUDQIHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:07:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36366 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263729AbUDQIH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:07:27 -0400
Date: Sat, 17 Apr 2004 09:07:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>,
       Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040417090712.B11481@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>,
	Maneesh Soni <maneesh@in.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com> <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk> <40807466.1020701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40807466.1020701@pobox.com>; from jgarzik@pobox.com on Fri, Apr 16, 2004 at 08:03:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 08:03:50PM -0400, Jeff Garzik wrote:
> Ideally one would think that userland can deduce relationships by 
> looking at the attribute information sysfs already provides -- and if 
> not, it's just one more bit of info to export via sysfs.

They can?  So, does userspace need to know the PCI IDs associated
with each driver so it can match the devices?  Without the symlinks
in /sys/bus/foo/devices, how do we know which devices are PCI devices
and which aren't?  etc...

Sure you can say "well, this device seems to have a this that and the
other attribute, which appears to match what we think a PCI device
should have" but then you're assuming that group of attributes only
appears for PCI devices.

What about other bus types?  Do I really need to teach userspace about
the relationships between all the various bus types we have on ARM and
how to work out what these relationships are by guessing?

Please.  The symlinks are necessary and they are the sole source of
the relationship information.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269604AbUJLKqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269604AbUJLKqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269611AbUJLKqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:46:39 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:19103 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269604AbUJLKqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:46:32 -0400
Date: Tue, 12 Oct 2004 12:46:32 +0200
From: bert hubert <ahu@ds9a.nl>
To: Oliver Neukum <oliver@neukum.org>
Cc: James Bruce <bruce@andrew.cmu.edu>, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [2.6.9-rc4] USB && mass-storage && disconnect broken semantics
Message-ID: <20041012104632.GA32663@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Oliver Neukum <oliver@neukum.org>,
	James Bruce <bruce@andrew.cmu.edu>, Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <20041011120701.GA824@outpost.ds9a.nl> <416B9436.3010902@andrew.cmu.edu> <200410121224.44910.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410121224.44910.oliver@neukum.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 12:24:44PM +0200, Oliver Neukum wrote:

> Devices break. You have to cope with devices going away suddenly.
> You are not required to ensure data integrity in all cases, but the system
> must not suffer. To allow that you must be able to get rid of the mounts
> even if users do not cooperate. 

Well, in retrospect, the kernel appears to offer the following semantics,
perhaps unintentionally:

	When a device goes away for any reason, but there are mounts that
	refer to it, the device nominally stays around and an umount will
	always succeed, removing the vestiges of the device with it.

This would in fact allow something in userspace listening to hotplug events
to umount on a disconnect event from USB. Except that I'm not sure if the
semantics above are guaranteed - they may just be an accident.

Things get more complicated if we have logical volumes or raid partitions
which ultimately depend on a device that is removed. In this case, userspace
should be aware of all dependencies in order to know which mountpoints to
umount. This might even include loopback mounts.

The kernel knows the dependencies implicitly and might be in a better
position to know what is invalidated by a disconnect, and which devices
disappear because of dependencies on it.

I'm hoping either Greg or Al will chime in - it appears as if part of the
infrastructure is there, but not quite developed.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

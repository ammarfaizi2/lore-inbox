Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUBKBg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUBKBgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:36:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:11987 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263880AbUBKBgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:36:08 -0500
Date: Tue, 10 Feb 2004 17:35:51 -0800
From: Greg KH <greg@kroah.com>
To: Christophe Saout <christophe@saout.de>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ATARAID userspace configuration tool
Message-ID: <20040211013551.GB2153@kroah.com>
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk> <1076425115.23946.18.camel@leto.cs.pocnet.net> <40292246.2030902@backtobasicsmgmt.com> <1076440714.27328.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076440714.27328.8.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 08:18:34PM +0100, Christophe Saout wrote:
> 
> udev maintains a database of already created devices. And sysfs is some
> sort of database of really existing devices. The "telling udev to not
> create the device and instead create it ourself" is bad. We should be
> able to tell udev that it should register and create another device
> instead. Perhaps udev should know about compound devices.
> 
> I'm not sure but if udev knows about compound devices things get a bit
> more complicated. A raid 1 setup would continue to work if one of the
> devices is unplugged, a raid 0 setup fails to work if one device is
> missing. Probably the device should be deleted only when both hard disks
> are removed. Also it should be created if only one hard disk gets
> plugged in. But on bootup if some script tells udev that one hard disk
> is there and some seconds later that the second is also there the tool
> shouldn't assume the raid has failed after seeing the first event.
> 
> Should we Cc an udev developer for an opinion?

udev can either ignore compound devices with a rule that matches the
dm-* block devices, or it can do something about them.

I really don't think udev in and of itself needs to know anything
special about these kinds of devices, as it will be glad to kick off
other programs for you if you want it to.

thanks,

greg k-h

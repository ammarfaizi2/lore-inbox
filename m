Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVFVPEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVFVPEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVFVPCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:02:45 -0400
Received: from gw.alcove.fr ([81.80.245.157]:22716 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261407AbVFVO60 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:58:26 -0400
Subject: Re: [linux-usb-devel] usb sysfs intf files no longer created when
	probe fails
From: Stelian Pop <stelian@popies.net>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1119449231.4594.14.camel@localhost.localdomain>
References: <1119448257.4587.2.camel@localhost.localdomain>
	 <1119449231.4594.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Wed, 22 Jun 2005 16:56:30 +0200
Message-Id: <1119452190.4794.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 juin 2005 à 16:07 +0200, Stelian Pop a écrit :
> Le mercredi 22 juin 2005 à 15:50 +0200, Stelian Pop a écrit :
> 
> > I use the 'atp' input driver from http://popies.net/atp/ to drive this
> > touchpad. When removing the driver I also get an oops, possibly related
> > to the previous failure to create the sysfs file:

Ok, there are two separate problems here:

1. The sysfs intf entry is not created, and this causes the oops later
when trying to remove the entry, etc.

   I've tracked this problem back to this patch: 
	[PATCH] driver core: fix error handling in bus_add_device
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ca2b94ba12f3c36fd3d6ed9d38b3798d4dad0d8b

   Once the patch above is reverted, I have no more oops, my driver can
be loaded/unloaded just fine, and the /sys/devices/.../ is present.

   However, I'm not really sure if the problem comes from the above
patch or from my driver which should manually call
usb_create_sysfs_intf_files() or something equivalent.

2. There is still a problem with the early loading of the driver. If
loaded at boot, it won't work. If I rmmod/insmod it later it does.

Stelian.
-- 
Stelian Pop <stelian@popies.net>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269769AbUINVSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269769AbUINVSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269165AbUINVP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:15:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:55489 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269667AbUINSmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:42:38 -0400
Date: Tue, 14 Sep 2004 11:42:06 -0700
From: Greg KH <greg@kroah.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: linux-kernel@vger.kernel.org, Tigran Aivazian <tigran@veritas.com>
Subject: Re: udev is too slow creating devices
Message-ID: <20040914184206.GA20651@kroah.com>
References: <41473972.8010104@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41473972.8010104@debian.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:33:22PM +0200, Giacomo A. Catenazzi wrote:
> Hello people!
> 
> When I load a module (with modprobe) the relative device is too
> slowly created with udev, so modprobe return before the device
> is really created. Because of this my init.d script will
> fail with modular microcode + udev
> 
> test case:
> 
> udev + modular microcode:
> $ modprobe -r microcode
> $ modprobe microcode ; microcode_ctl -u
> => microcode_ctl does NOT find the device
> 
> $ modprobe -r microcode
> $ modprobe microcode ; sleep 3; microcode_ctl -u
> => microcode_ctl FIND the device
> 
> [without udev it is OK, so I assume no errors
> in modprobe]
> 
> Is it a bug of udev?

No, it's just the way it now works.

> Else what workaround I can use? (sleep is to slow for
> an already to sloow system initialitation)

Run microcode_ctl from a script in /etc/dev.d/microcode/  See the file:
  http://kernel.org/pub/linux/utils/kernel/hotplug/RFC-dev.d

for more information on now /etc/dev.d works.

thanks,

greg k-h

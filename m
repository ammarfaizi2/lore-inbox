Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUIOXqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUIOXqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUIOW1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:27:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:62667 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267669AbUIOW0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:26:51 -0400
Date: Wed, 15 Sep 2004 15:25:57 -0700
From: Greg KH <greg@kroah.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, "Marco d'Itri" <md@Linux.IT>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040915222557.GE26591@kroah.com>
References: <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <20040914232011.GG3365@dualathlon.random> <20040915161541.GD21971@kroah.com> <20040915192134.GA4197@dualathlon.random> <4148BD97.1080504@nortelnetworks.com> <20040915221523.GG15426@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915221523.GG15426@dualathlon.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 12:15:23AM +0200, Andrea Arcangeli wrote:
> 
> But the microcode driver has nothing to do with hotplug or usb, and
> waiting for the device creation in the insmod syscall is sure natural
> and doable.  Now if we don't want to create a little bit of API in udev
> to let insmod provide a sync behaviour and force people into the dev.d
> scripts and file locking in /var/run that it's one issue (you can aruge
> about higher perf), but there is a whole large class of devices that are
> not hot-pluggable and where the discovery is definitely synchronous,
> even common pci is fully sync in its discovery when you call
> pci_find_device/get_device.

That will be soon going away with my multi-threaded device discovery
work.  And I run pci hotplug boxes (and so do all of the PCMCIA/CardBus
users), so don't discard PCI from being a async bus type :)

Async is now the norm, and drivers like the microcode module are the
exception.

thanks,

greg k-h

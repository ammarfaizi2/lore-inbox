Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUIXIXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUIXIXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUIXIXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:23:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:19684 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268581AbUIXIXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:23:48 -0400
Subject: Re: suspend/resume support for driver requires an external firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: "Zhu, Yi" <yi.zhu@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0409240029110.32015-100000@monsoon.he.net>
References: <Pine.LNX.4.44.0409241405540.12384-100000@mazda.sh.intel.com>
	 <Pine.LNX.4.50.0409240029110.32015-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1096014170.30196.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 18:22:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We talked about this in Ottawa a few months ago, and I think this is the
> right approach. Note though, that I think it needs to be more complete:
> 
> - There needs to be restore_state() to be symmetic.
> - There needs to be the proper failure recovery
>   If save_state() or suspend() fails, every device that has had their
>   state saved needs to be restored.
> - It needs to be called for all power management requests.
> - The PCI implementation should call pci_save_state() in it, instead of in
>   ->suspend().
> 
> It would be great if you could add these things. Otherwise, I'll add it to
> my TODO list..

Additionally, for devices like the above that need either to rely on
userland for firmware download or to allocate large amounts of memory
for firmware backup/restore, I think we need to revive the pre-suspend
and post-resume notifiers ... Of course, if a device that needs userland
to reload a firmware is on the swap patch, then we have a chicken & egg
problem, but there is no easy solution for that one, unless the driver
uses the pre-suspend callback to pre-load the firmware that it will need
for resume

Ben.


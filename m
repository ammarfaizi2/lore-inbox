Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbVJGRAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbVJGRAR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbVJGRAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:00:17 -0400
Received: from [81.2.110.250] ([81.2.110.250]:22658 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030507AbVJGRAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:00:16 -0400
Subject: Re: [RFClue] pci_get_device, new driver model
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43469FB8.50303@beezmo.com>
References: <43469FB8.50303@beezmo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Oct 2005 18:28:31 +0100
Message-Id: <1128706111.18867.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-10-07 at 09:18 -0700, William D Waddington wrote:
> If I convert to pci_get_device, it looks like subsequent calls in the
> loop "put" the previously "gotten" device.  I need the pci_dev struct
> to persist for later use (DMA, etc).  Do I take an additional bump to
> the ref count for each board found before looping, and "put" each when
> the driver is unloaded?

If you are saving the pci device point then yes you should. If you are
using pci_module_init() and the hotplug interface instead then it may
not be neccessary.

> If I just give in to the new driver model how/when do I associate
> instance/minor numbers with boards found?  Is it ever possible for
> ordinary PCI boards to be (logically) removed and re-added w/out
> removing the driver?  If so, how to maintain association between
> a particular board and minor number?

Its up to you how you implement this. One requirement I suspect would be
that the boards have unique serial numbers. Most drivers do not retain
state if someone unplugs a board, moves it and plugs it back in. Instead
they report the old device as "gone" and let user space sort it out


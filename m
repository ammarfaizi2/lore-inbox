Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265884AbUFWBSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbUFWBSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 21:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUFWBSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 21:18:41 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:5258 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265884AbUFWBSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 21:18:40 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: long <tlnguyen@snoqualmie.dp.intel.com>, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com>
	<52n02vkuy6.fsf@topspin.com> <40D8CE3F.4010306@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 18:18:13 -0700
In-Reply-To: <40D8CE3F.4010306@pobox.com> (Jeff Garzik's message of "Tue, 22
 Jun 2004 20:26:39 -0400")
Message-ID: <528yefkr6y.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Jun 2004 01:18:13.0419 (UTC) FILETIME=[F45167B0:01C458BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> hmmmmmmm.

    Jeff> Unless it's already inside the lock somehow...  it
    Jeff> definitely needs to take the lock, one way or another.

At least most (in not all) of the code paths are not inside the lock.
For example pci_enable_msi() is called from a device driver, and it
directly does

	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
		2, &control);

as well as calling lots of other functions that do similar stuff.

In fact I don't see how any of the stuff in msi.c could be protected
by pci_lock, since pci_lock is static to access.c and only used inside
the pci_bus_read_config_xxx and pci_bus_write_config_xxx functions
defined there.

 - Roland



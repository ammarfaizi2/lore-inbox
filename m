Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVCDHw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVCDHw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVCDHw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:52:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34536 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262599AbVCDHw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:52:57 -0500
Date: Thu, 3 Mar 2005 23:52:52 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Duncan Sands <baldrick@free.fr>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: USB 2.4.30: fix modem_run
Message-ID: <20050303235252.6b0dc51b@localhost.localdomain>
In-Reply-To: <1108116980.7400.0.camel@localhost.localdomain>
References: <20050210161144.708cb96f@localhost.localdomain>
	<1108116980.7400.0.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.0.1cvs20.1 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2005 11:16:20 +0100 Duncan Sands <baldrick@free.fr>
wrote:

> On Thu, 2005-02-10 at 16:11 -0800, Pete Zaitcev wrote:
> > I entered a patch which adds "exclusive_access" lock into 2.4.29,
> > to fix devices which cannot handle simultaneous accesses. This
> > caused a regression with European ADSL modems. An ioctl
> > USBDEVFS_REAPURB allows a process to enter the kernel and wait for
> > USB I/O to finish. Naturally, this should not take
> > exclusive_access, or nothing will ever finish.
> 
> How does this compare with the locking in 2.6 kernels?

In 2.6, there is no locking whatsoever. Instead, rules for queueing are
relaxed for all HCs. If the device chokes when it receives a control
together with a data exchange (on a bulk endpoint, usually), kernel
does not interfere. Users (libusb & drivers) are supposed to know when
not to do it. Obviously, it's not the case of usb-storage. To help that,
descriptor strings are cached in latest Greg's trees, since a week ago
or so. This way at least "cat /proc/bus/usb/devices" won't interfere.

-- Pete

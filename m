Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUJORmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUJORmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUJORmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:42:06 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:8779 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268218AbUJORgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:36:54 -0400
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
	: oops...]
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.44L0.0410151318580.1052-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0410151318580.1052-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1097861761.2820.18.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 15 Oct 2004 12:36:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 12:21, Alan Stern wrote:

> As I understand it, the description field is just a human-readable string
> that indicates what sort of device the hcd is.  It doesn't need to be
> unique.  In fact, the kerneldoc for request_irq() (without the updates)
> says that the dev_id value must be unique but says nothing about the
> devname.

In the SyncLink drivers I've always passed a devname
that is unique to each device instance, using the
form printf(devname, "%s%d", basename, instance_num).
Ethernet device instances also seem to do this.

I see that the generic serial 8250 driver uses
a constant name, as does aic7xxx.

Unique device names are useful for identifying
which device instance is on a particular interrupt
(/proc/interrupts), but other drivers beside uhci_hcd
use a constant name so I guess that is legal :-)

Either way, the generic IRQ code should deal with
duplicates without generating an oops.

-- 
Paul Fulghum
paulkf@microgate.com


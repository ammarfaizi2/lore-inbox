Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265606AbTFRXTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbTFRXTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:19:40 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:37116 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265606AbTFRXTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:19:38 -0400
Date: Wed, 18 Jun 2003 16:32:37 -0700
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking - take 2
Message-ID: <20030618163237.A21050@figure1.int.wirex.com>
References: <20030618212921.GA1807@kroah.com> <20030618153324.A20212@figure1.int.wirex.com> <20030618224609.GB2215@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030618224609.GB2215@kroah.com>; from greg@kroah.com on Wed, Jun 18, 2003 at 03:46:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> Hm, I think we should probably just check in pci_get_device() to verify
> that ->next is really valid.  If it isn't just return NULL, as we have
> no idea what the next device would possibly be.  The worse thing that
> would happen is the proc file would be a bit shorter than expected.  If
> read again, it would be correct, with the previously referenced device
> now gone.

I'm not sure testing a valid ->next makes sense.  It could be non-NULL,
but poison, or if it was using list_del_init, it would be stuck in loop.

> I don't want to try to hold a lock over start/next/stop as that would
> just be asking for trouble :)

Heh, I agree, it doesn't feel quite right to acquire lock and release
lock in separate functions, but in the case of start/show/next/stop this
seems to be the design.  Alternative here seems to be keeping thing on
list with get and deleting from with put on last ref, but that didn't
look so simple.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

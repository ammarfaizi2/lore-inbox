Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUBUB6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUBUB6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:58:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:14539 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbUBUB6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:58:46 -0500
Date: Fri, 20 Feb 2004 17:58:41 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: John Levin <levin@gamebox.net>, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: 2.6.2-rc3 messages  BUG
Message-ID: <20040220175841.G22989@build.pdx.osdl.net>
References: <20040221075308.161992c7.levin@gamebox.net> <20040220174616.30d73718.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040220174616.30d73718.akpm@osdl.org>; from akpm@osdl.org on Fri, Feb 20, 2004 at 05:46:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> > [root@mdk9 root]# lsmod
> > Module                  Size  Used by
> > uhci_hcd               31752  0
> > cdc_acm                10784  3
> > usbcore               111828  4 uhci_hcd,cdc_acm
> > [root@mdk9 root]# rmmod uhci_hcd
> > [root@mdk9 root]# insmod
> > /lib/modules/2.6.3-rc2/kernel/drivers/usb/host/uhci-hcd.ko
> 
> You missed out an important piece of info.  The kernel should have printed
> out "kmem_cache_create: duplicate cache <name>" before going BUG.
> 
> What was "<name>"?  uhci_urb_priv?
> 
> I suggest you go into drivers/usb/host/uhci-hcd.c:uhci_hcd_cleanup() and
> replace
> 
> 	warn("not all urb_priv's were freed!");
> 
> with
> 
> 	BUG();
> 
> because failure to destroy that slab cache is fatal, and it points at a bug
> in this driver.

True, I mentioned this to Greg earlier.  But in this case that BUG() is
only going to show the rmmod attempt, right?  Problem is that rmmod
works when the driver is in use, and this only happens after
suspend/resume.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

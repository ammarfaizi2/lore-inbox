Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422706AbWGNSho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbWGNSho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWGNSho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:37:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36880 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1422710AbWGNShn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:37:43 -0400
Date: Fri, 14 Jul 2006 14:37:41 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Aleksey Gorelov <dared1st@yahoo.com>
cc: Andrew Morton <akpm@osdl.org>, <david-b@pacbell.net>, <gregkh@suse.de>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier
 in case of failure in ehci hcd
In-Reply-To: <20060714164637.79842.qmail@web81212.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.44L0.0607141430040.7820-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006, Aleksey Gorelov wrote:

> > This patch causes hangs at reboot/shutdown/suspend time.  See
> > http://www.zip.com.au/~akpm/linux/patches/stuff/dsc03597.jpg
> > 
> Oops, I did not test it with suspend/resume stuff, sorry. The problem is that ehci_run is called
> from resume without its counterpart ehci_stop in suspend, so notifier ends up registered twice.
> 
> David, Alan,
> 
> Do you think it is Ok to unregister reboot notifier in ehci_run before registering one to make
> sure there is no 'double registering' of notifier, or is it better to move register/unregister
> reboot notifier from ehci_run/ehci_stop completely to some other place ?

Dave has a better idea than I do about where a good spot might be for 
registering the notifier.

However, it is always possible to avoid "double registering" by keeping a
private flag that you set when the notifier is registered.  Then you can
simply skip registering if the flag is already set.

Alan Stern


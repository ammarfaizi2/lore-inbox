Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965304AbVIPPKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbVIPPKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbVIPPKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:10:09 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:62643 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932663AbVIPPKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:10:08 -0400
Date: Fri, 16 Sep 2005 11:10:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jan Dittmer <jdittmer@ppp0.net>
cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.6.14-rc1 load average calculation broken?
In-Reply-To: <432AA269.3070207@ppp0.net>
Message-ID: <Pine.LNX.4.44L0.0509161104420.4972-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Jan Dittmer wrote:

> Okay, it happened again. Turns out to be the usb-storage kernel threads:
> 
> root      3308  0.0  0.0      0     0 ?        D    08:40   0:00 [usb-storage]
> root      4671  0.0  0.0      0     0 ?        D    08:40   0:00 [usb-storage]
> 
> I've an USB card reader in my monitor which turns off, when the monitor goes
> to standby/is shut off. I think I can reproduce it that way, but I'm currently
> not physically near the machine to check.
> 
> Any debug info that can help? Last known good kernel was 2.6.13-git6.
> I don't update that machine that much. ;-)
> 
> Current kernel is 2.6.14-rc1-git1.

Can you post a stack dump for those two threads?  Normally they are idle,
in an interruptible wait, so they shouldn't be in D state.  Since they
are, maybe there's some sort of error recovery attempt going on.  Like
hald doing its periodic checking of hotpluggable storage devices while
your monitor is off.

Alan Stern


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270522AbTGNEiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 00:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270524AbTGNEiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 00:38:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:15341 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270522AbTGNEiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 00:38:09 -0400
Date: Sun, 13 Jul 2003 21:53:04 -0700
From: Greg KH <greg@kroah.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       torvalds@osdl.org
Subject: Re: [PATCH] /proc/bus/pci* changes
Message-ID: <20030714045304.GB19392@kroah.com>
References: <1058154708.747.1391.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058154708.747.1391.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 11:51:48PM -0400, Albert Cahalan wrote:
> The existing /proc/bus/pci/*/* files are a
> hack involving ioctl and out-of-bounds mmap.
> The following patch starts a transition to
> something sane while keeping compatibility.
> 
> Typical user-space drivers for polled devices
> should be easy to port to the new interface.
> The X server will need some per-arch enhancements
> to handle write-combining (non-x86 lack MTRRs)
> and the use of multiple VGA-style devices.
> 
> In the new interface, pci/00/00.0 is a symbolic
> link to a ../../pci*/bus0/dev0/fn0/config-space
> file, where the '*' is typically 0. (PCI domain)
> Simple and direct per-resource mmap() is provided,
> via pci0/bus0/dev0/fn0/bar0 and so on.

Why put all of these extra directories in /proc?  We talked about this
before...

What are you trying to "transition to"?  What do you want to see this
look like when you are finished?  And are you prepared to patch all of
the userspace programs that currently rely on the existing interface
(like XFree86 for one)?

Also, I don't think you are handling the pci domain space in your patch,
or am I just missing it?

And your patch was linewrapped :)

thanks,

greg k-h

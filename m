Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUDESXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 14:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUDESXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 14:23:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:26289 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263095AbUDESXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 14:23:21 -0400
Date: Mon, 5 Apr 2004 11:23:04 -0700
From: Greg KH <greg@kroah.com>
To: wdebruij@dds.nl
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [ANNOUNCE] various linux kernel devtools : device handling/memory mapping/profiling/etc.
Message-ID: <20040405182304.GA8008@kroah.com>
References: <1081186402.407198620a28b@webmail.dds.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081186402.407198620a28b@webmail.dds.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 07:33:22PM +0200, wdebruij@dds.nl wrote:
> - a generic device file interface, which abstracts away kernelversion 
> differences, devfs/mknod/udev differences and memory addressing differences. 

I don't see anything in there that will work properly for udev.  Am I
just missing the code somewhere?  Remember, for udev to work, you have
to create stuff in sysfs, which I don't see this code doing.

> - a generic pci initialization interface. Could perhaps be merged with the 
> existing PCI subsytem. I needed it for implementing a PCI driver (more below)

Ick, you are using pci_find_device() which is racy, depreciated, and
does not play nice with the rest of the kernel.  Yes, it's the lowest
common denominater accross 2.2, 2.4, and 2.6, but please don't sink to
that level if you don't have to.  For 2.6 it's just not acceptable.

I agree that at times the current kernel driver api learning curve is a
bit steep.  But people are working to reduce that curve where they can,
and it's one of my main priorities for 2.7.  Any help and suggestions
that you might have in that area are greatly appreciated.

thanks,

greg k-h

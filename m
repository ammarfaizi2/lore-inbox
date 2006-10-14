Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752080AbWJNFMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbWJNFMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbWJNFMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:12:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:42458 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752078AbWJNFMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:12:21 -0400
Date: Fri, 13 Oct 2006 22:11:44 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: drivers/base/sys.c bug found
Message-ID: <20061014051144.GA17315@suse.de>
References: <45239D1F.7060102@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45239D1F.7060102@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 07:38:07AM -0400, Jeff Garzik wrote:
> sysdev_driver::add is defined to return an error (as it should), but 
> that error code is never checked.

Ick, good catch.

I hate those sysdev devices...

Hm, in sysdev_driver_register() we don't want to return any error there,
as it doesn't make sense to.

Shaohua, sysdev devices should not stop the notificiation if a single
add() function returns an error, right?  All of the individual drivers
want to be notified of the device.

Bleah...did I mention I don't like these things...

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUDXDYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUDXDYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 23:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUDXDYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 23:24:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:7073 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261884AbUDXDYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 23:24:18 -0400
Date: Fri, 23 Apr 2004 17:30:13 -0700
From: Greg KH <greg@kroah.com>
To: "E. Oltmanns" <oltmanns@uni-bonn.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops during usb usage (2.6.5)
Message-ID: <20040424003013.GA13631@kroah.com>
References: <20040423205617.GA1798@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423205617.GA1798@local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 10:56:17PM +0200, E. Oltmanns wrote:
> Hello everyone,
> 
> Summary:
> Kernel Oops caused by multiple access requests to a single scanner
> through libusb.
> 
> Detailed description:
> The following script leads to an kernel oops on my System:
> #!/bin/bash
> scanimage > test &
> scanimage -h
> 
> This is because scanimage -h tries to append a list of availlable
> scanners to the help output and thus interferes with the first
> scanimage process which is initializing the scanner at the same
> moment.

Heh, then don't do that :)

Accesses by two different processes of the same device through usbfs is
big trouble.  Don't do that.

That being said, I have some usbfs locking patches that might help a bit
here that will probably show up in the next -mm release if you want to
see if that helps you out or not.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVCLIFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVCLIFG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 03:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVCLIFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 03:05:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:6107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261717AbVCLIFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 03:05:01 -0500
Date: Fri, 11 Mar 2005 23:20:56 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050312072056.GB11236@kroah.com>
References: <200503120010.j2C0AS4Q020291@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503120010.j2C0AS4Q020291@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 04:10:28PM -0800, long wrote:
> 
> -	Report the errors to user.

This is done through the syslog, right?  Is that acceptable?

It looks like you are logging a lot of stuff, all without a kernel log
level, which is going to really mess up syslog parsers.

Have you thought about just providing userspace with access to the error
message, in binary form, from a sysfs file, and causing a kevent to wake
userspace up to know to read from the file?  That way all of the parsing
of the error log can be done in userspace, and there is no formatting of
the messages from within the kernel.

thanks,

greg k-h

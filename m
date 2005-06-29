Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVF2Su5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVF2Su5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVF2StV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:49:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:35488 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262419AbVF2Sqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:46:46 -0400
Date: Wed, 29 Jun 2005 11:46:22 -0700
From: Greg KH <greg@kroah.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_remove_file and disconnect
Message-ID: <20050629184621.GA28447@kroah.com>
References: <42C2D354.6060607@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C2D354.6060607@free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 06:59:00PM +0200, matthieu castet wrote:
> Hi,
> 
> I have a question about sysfs interface.
> 
> If you open a sysfs file created by a module, then remove it (rmmoding 
> the module that create this sysfs file), then try to read the opened 
> file, you often get strange result (segdefault or oppps).

What file did you do this for?  The module count should be incremented
if you do this, to prevent the module from being unloaded.

> I attach a small program to test it : open your sysfs file with it 
> `wait_read /sysfs/file', rmmod the module, and press enter.
> 
> I was wondering if it is to user of sysfs to prevent that (with mutex, 
> ...) or it is a sysfs bug ?

Driver bug, odds are they don't set the module owner for the attribute
properly.

> If it is the first case, I fear that lot's of modules are broken.

Remember, only root can unload modules, so it really isn't _that_ big of
a deal (I can do a lot more damage as root than just oopsing the
kernel...)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUACF7l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 00:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUACF7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 00:59:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:6082 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262686AbUACF7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 00:59:40 -0500
Date: Fri, 2 Jan 2004 21:58:47 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040103055847.GC5306@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401012333.04930.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 11:33:04PM +0300, Andrey Borzenkov wrote:
> udev names are created when kernel detects corr. device. Unfortunately for 
> removable media kernel rescans for partitions only when I try to access 
> device. Meaning - because kernel does not know partition table it did not 
> send hotplug event so udev did not create device nodes. But without device 
> nodes I have no way to access device in Unix :(
> 
> specifically I have now my Jaz and I have no (reasonable) way to access 
> partition 4 assuming device nodes are managed by udev.
> 
> devfs solved this problem by
> 
> - always exporting at least handle to the whole disk (sda as example)

Doesn't the kernel always create the main block device for this device?
If so, udev will catch that.  If not, there's no way udev will work for
this kind of device, sorry.  You could make a script that just creates
the device node in /tmp, runs dd on it, and then cleans it all up to
force partition scanning.

thanks,

greg k-h

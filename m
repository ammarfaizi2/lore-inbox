Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268227AbUHKVaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268227AbUHKVaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbUHKVaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:30:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:61073 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268227AbUHKVac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:30:32 -0400
Date: Wed, 11 Aug 2004 14:22:24 -0700
From: Greg KH <greg@kroah.com>
To: John Riggs <jriggs@altiris.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices
Message-ID: <20040811212224.GG21894@kroah.com>
References: <9B96255DE3B181429D06C6ADB0B37470232B12@sandman.altiris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B96255DE3B181429D06C6ADB0B37470232B12@sandman.altiris.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 12:14:09PM -0600, John Riggs wrote:
> The problem appears to be coming from the following series of calls:
> 
> returns EEXIST
> create_dir
> sysfs_create_dir
> create_dir
> kobject_add
> class_device_add
> class_device_register  
> pci_alloc_child_bus
> 
> This causes pci_bus* child->class_dev.kobj.dentry to be NULL, which is
> passed into class_device_create_file eventually becoming a NULL POINTER
> in the function sysfs_add_file. (The NULL variable in sysfs_add_file is
> now called dir.)
> 
> I don't have much of an understanding of the kernel, but it appears to
> me that a PCI device is getting created twice. Does anybody have any
> pointers as to what might be going on, or can point me in the right
> direction to look?

Yes, that sounds like what is happening.  Can you build a modular kernel
and load the drivers you need one by one until the error happens?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263916AbUDFRDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUDFRDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:03:50 -0400
Received: from ida.rowland.org ([192.131.102.52]:20740 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263916AbUDFRDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:03:49 -0400
Date: Tue, 6 Apr 2004 13:03:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
In-Reply-To: <20040406101320.GB1270@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0404061257230.6345-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2004, Maneesh Soni wrote:

> Yes, it came from check_perm(). I think I found the reason for that. The
> attribute group subdirectory's dentry also has a pointer to the same kobject
> as the corresponding directory's dentry. The kobject directory dentry was
> taken care of but the attribute group subdirectory was still pointing to the
> kobject. And that badness message was coming while opening a file under 
> attribute subdir. 
> 
> I am using dentry->d_flags and a new flag value DCACHE_SYSFS_CONNECTED to 
> indicate that the dentry is connected to a vaild kobject. I could run my
> stress test of insmod/rmmod for more than 3 hours without any badness message.
> 
> I am copying to the maintainers also and hope to get their comments for
> this patch.
> 
> Thanks
> Maneesh

I like your patch a lot.  It suggests an additional possibility.  Maybe 
your DCACHE_SYSFS_CONNECTED flag could be used to indicate that an 
attribute is registered.  That way, after the file is unregistered (even 
if the kobject still exists) reads and writes of the attribute would 
return an error.  This isn't really necessary since opening an attribute 
takes a reference to the module owning the attribute, but it is 
conceptually attractive.

Alan Stern



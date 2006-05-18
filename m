Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWERRVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWERRVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 13:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWERRVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 13:21:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41443 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751374AbWERRVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 13:21:22 -0400
Date: Thu, 18 May 2006 10:19:17 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobject_add failed for vcs1 with -EEXIST, don't try to register things with the same name in the same directory.
Message-ID: <20060518171917.GB30887@kroah.com>
References: <200605180909.55747.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605180909.55747.baldrick@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 09:09:55AM +0200, Duncan Sands wrote:
> Got this when shutting down with 2.6.17-rc4-git2:
> 
> kobject_add failed for vcs1 with -EEXIST, don't try to register things with the same name in the same directory.
>  <c01b071c> kobject_add+0x11d/0x13a   <c01f252a> class_device_add+0x8c/0x269
>  <c01f278b> class_device_create+0x74/0x94   <c01e4060> vcs_make_devfs+0x22/0x4d
>  <c01e7776> con_open+0x6f/0x7c   <c01df238> tty_open+0x175/0x29f
>  <c0144069> chrdev_open+0xe7/0xfd   <c0143f82> chrdev_open+0x0/0xfd
>  <c013d0d5> __dentry_open+0xb6/0x185   <c013d208> nameidata_to_filp+0x19/0x28
>  <c013d242> do_filp_open+0x2b/0x31   <c013d319> do_sys_open+0x3c/0xae
>  <c013d3b8> sys_open+0x16/0x18   <c01023cf> sysenter_past_esp+0x54/0x75
> 
> Any idea what it's about?

A bug in the console layer?  Why would we be re-registering a new
console on shutdown time?  Some init-level change issue?

thanks,

greg k-h

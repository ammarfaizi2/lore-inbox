Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVHBRd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVHBRd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVHBRd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:33:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:22687 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261668AbVHBRdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:33:25 -0400
Date: Tue, 2 Aug 2005 10:33:02 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Keith Owens <kaos@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show
Message-ID: <20050802173302.GB1799@kroah.com>
References: <20050801120321.230349c5.akpm@osdl.org> <26771.1122951950@ocs3.ocs.com.au> <20050802080422.GA32556@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050802080422.GA32556@in.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 01:34:22PM +0530, Maneesh Soni wrote:
> Looks like the attribute structure is allocated dynamically and
> is freed before the sysfs_release() is called?
> 
> Basically it could be like this..
> 
> file (/sys/class/vc/vcs16/dev) is still open and the corresponding
> attribute structure is already gone. open files will the keep the
> corresponding dentry and in-turn sysfs_dirent alive.
> 
> sysfs_open_file() does call kobject_get() and it expects the
> kobject to be around while the sysfs files for kobject's corresponding
> attributes are open.
> 
> Greg, could there be cases where the kobject is alive but
> attributes are freed? In those cases we will need some
> way to keep attrbiutes alive while kobject is around.

Well, we need to remove the attributes before we free the kobject,
right?  It looks like we are racing here, I'll dig into this and see if
I can find anything...

thanks,

greg k-h

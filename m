Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTKTSnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTKTSnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:43:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262352AbTKTSnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:43:23 -0500
Date: Thu, 20 Nov 2003 18:43:22 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH] sysfs_remove_dir Vs dcache_readdir race fix
Message-ID: <20031120184322.GE24159@parcelfarce.linux.theplanet.co.uk>
References: <20031120054707.GA1724@in.ibm.com> <20031120054957.GD24159@parcelfarce.linux.theplanet.co.uk> <20031120055655.GB1724@in.ibm.com> <20031120102525.GD1367@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120102525.GD1367@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 03:55:25PM +0530, Maneesh Soni wrote:
> Actually race is not directly between dcache_readdir and sysfs_remove_dir but
> it is like this
> 
> cpu 0						cpu 1
> dcache_dir_open()
> --> adds the cursor dentry
> 
> 					sysfs_remove_dir()
> 					--> list_del_init cursor dentry
> 
> dcache_readdir()
> --> loops forever on inititalized cursor dentry.

Yes.  Thanks for spotting...

> Though all these operations happen under parent's i_sem, but it is dropped 
> between ->open() and ->readdir() as both are different calls. 
> 
> I think people will also agree that there is no need for sysfs_remove_dir() 
> to modify d_subdirs list.

Agreed.

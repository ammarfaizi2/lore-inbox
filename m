Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbULQXaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbULQXaf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbULQXaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:30:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:34473 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262226AbULQXa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:30:29 -0500
Date: Fri, 17 Dec 2004 15:27:52 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Adam J. Richter" <adam@yggdrasil.com>,
       maneesh@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Delete sysfs_dirent.s_count, saving ~100kB on my system
Message-ID: <20041217232752.GA24023@kroah.com>
References: <200412011856.iB1IuAc21682@adam.yggdrasil.com> <20041201130703.79a3f3b5.akpm@osdl.org> <20041201155159.N14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201155159.N14339@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 03:51:59PM -0800, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > That's all well and good, but sysfs_new_dirent() should be using a
> > standalone slab cache for allocating sysfs_dirent instances.  That way, we
> > use 36 bytes for each one rather than 64.
> 
> Reasonable, here's a patch (lightly tested).  Without, size-64 looks
> like so:
> 
> size-64             4064   4108     76   52    1 : tunables   32   16 8 : slabdata     79     79      0 : globalstat    4263   4079    79    0 0    0   84    0 : cpustat  15986    337  12286      3
> 
> And with:
> 
> size-64             1196   1196     76   52    1 : tunables   32   16 8 : slabdata     23     23      0 : globalstat    1297   1196    23    0 0    0   84    0 : cpustat  12418    108  11349      1
> sysfs_dir_cache     2862   2916     48   81    1 : tunables   32   16 8 : slabdata     36     36      0 : globalstat    2931   2874    36    0 0    0  113    0 : cpustat   2756    216    110      0
> 
> 
> Allocate sysfs_dirent structures from their own slab.

Nice, thanks for doing this.

Applied,

greg k-h

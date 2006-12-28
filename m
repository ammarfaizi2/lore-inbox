Return-Path: <linux-kernel-owner+w=401wt.eu-S932982AbWL1K3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbWL1K3d (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933010AbWL1K3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:29:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47305 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932982AbWL1K3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:29:32 -0500
Date: Thu, 28 Dec 2006 02:29:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drop page cache of a single file
Message-Id: <20061228022926.4287ca33.akpm@osdl.org>
In-Reply-To: <367290328.14058@ustc.edu.cn>
References: <1167275845.15989.153.camel@ymzhang>
	<20061227194959.0ebce0e4.akpm@osdl.org>
	<367290328.14058@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 15:19:04 +0800
Fengguang Wu <fengguang.wu@gmail.com> wrote:

> On Wed, Dec 27, 2006 at 07:49:59PM -0800, Andrew Morton wrote:
> > On Thu, 28 Dec 2006 11:17:25 +0800
> > "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> > 
> > > Currently, by /proc/sys/vm/drop_caches, applications could drop pagecache,
> > > slab(dentries and inodes), or both, but applications couldn't choose to
> > > just drop the page cache of one file. An user of VOD (Video-On-Demand)
> > > needs this capability to have more detailed control on page cache release.
> > 
> > The posix_fadvise() system call should be used for this.  Probably in
> > combination with sys_sync_file_range().
> 
> Yanmin: I've been using the fadvise tool from
> http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
> 
> It's a nice tool:
> 
> % fadvise 
> Usage: fadvise filename offset length advice [loops]
>       advice: normal sequential willneed noreuse dontneed asyncwrite writewait
> % fadvise /var/sparse 0 0x7fffffff dontneed
> 

I was a bit reluctant to point at that because it has nasty hacks to make
it mostly-work on old glibc's which don't implement posix_fadvise().

Hopefully if you're running a recent distro, you have glibc support for
fadvise() and it's possible to write a portable version of that app which
doesn't need to know about per-arch syscall numbers.

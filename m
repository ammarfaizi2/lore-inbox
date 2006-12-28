Return-Path: <linux-kernel-owner+w=401wt.eu-S1752703AbWL1KpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbWL1KpU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbWL1KpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:45:20 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2260 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbWL1KpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:45:18 -0500
Date: Thu, 28 Dec 2006 10:45:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Fengguang Wu <fengguang.wu@gmail.com>,
       "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drop page cache of a single file
Message-ID: <20061228104508.GA20596@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Fengguang Wu <fengguang.wu@gmail.com>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1167275845.15989.153.camel@ymzhang> <20061227194959.0ebce0e4.akpm@osdl.org> <367290328.14058@ustc.edu.cn> <20061228022926.4287ca33.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228022926.4287ca33.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:29:26AM -0800, Andrew Morton wrote:
> On Thu, 28 Dec 2006 15:19:04 +0800
> Fengguang Wu <fengguang.wu@gmail.com> wrote:
> > Yanmin: I've been using the fadvise tool from
> > http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
> > 
> > It's a nice tool:
> > 
> > % fadvise 
> > Usage: fadvise filename offset length advice [loops]
> >       advice: normal sequential willneed noreuse dontneed asyncwrite writewait
> > % fadvise /var/sparse 0 0x7fffffff dontneed
> > 
> 
> I was a bit reluctant to point at that because it has nasty hacks to make
> it mostly-work on old glibc's which don't implement posix_fadvise().
> 
> Hopefully if you're running a recent distro, you have glibc support for
> fadvise() and it's possible to write a portable version of that app which
> doesn't need to know about per-arch syscall numbers.

And note that if it gets implemented on ARM on pre-fadvise() glibc,
the syscall argument order is rather non-standard: fd, action, start,
size rather than fd, start, size, action - since otherwise we run out
of registers with EABI.

The kernel community needs to get a grip with the implementation of
new syscalls - we need a process where architecture maintainers get
to review the arguments _prior_ to them being accepted into the kernel.
That way we can avoid silly architecture specific syscall changes like
this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

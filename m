Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbTIKHcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbTIKHcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:32:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21395 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266233AbTIKHck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:32:40 -0400
Date: Thu, 11 Sep 2003 08:32:39 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Local DoS on single_open?
Message-ID: <20030911073239.GU454@parcelfarce.linux.theplanet.co.uk>
References: <20030911045507.GQ454@parcelfarce.linux.theplanet.co.uk> <5311.1063265214@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5311.1063265214@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 05:26:54PM +1000, Keith Owens wrote:
> On Thu, 11 Sep 2003 05:55:07 +0100, 
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> >On Thu, Sep 11, 2003 at 02:42:13PM +1000, Keith Owens wrote:
> >> single_open() requires the kernel to kmalloc a buffer which lives until
> >> the userspace caller closes the file.  What prevents a malicious user
> >> opening the same /proc entry multiple times, allocating lots of kmalloc
> >> space and causing a local DoS?
> >
> >Size of that buffer is limited.  IOW, it's not different from opening
> >e.g. a shitload of pipes or sockets.
> 
> In some cases, the buffer size is set to hold _all_ of the output for
> that particular /proc file and will be much larger than the data
> reserved for files and sockets.  It is a difference in scale.
> 
> fs/proc/proc_misc.c		stat_open
> fs/proc/proc_misc.c		interrupts_open
> kernel/dma.c			proc_dma_open
> 
> All those functions will kmalloc a reasonably sized buffer then let the
> user control the lifetime of that buffer.  Looks like a recipe for a
> local DoS to me.

struct file: 256 bytes due to cacheline alignment
struct dentry: 128 bytes, IIRC
struct inode: either 256 bytes or 512 bytes.
struct socket and struct sock: bugger if I remember, but it's not small.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUDEOFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUDEOFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:05:10 -0400
Received: from pop.gmx.net ([213.165.64.20]:19619 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262556AbUDEOFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:05:04 -0400
X-Authenticated: #12437197
Date: Mon, 5 Apr 2004 16:05:29 +0200
From: Dan Aloni <da-x@colinux.org>
To: Christoph Hellwig <hch@infradead.org>,
       Cooperative Linux Development 
	<colinux-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: coLinux benchmarks
Message-ID: <20040405140529.GA5863@callisto.yi.org>
References: <20040405131520.GA4395@callisto.yi.org> <20040405143056.A5621@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405143056.A5621@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 02:30:56PM +0100, Christoph Hellwig wrote:
> > The VM shows better results than the host. What gives? Perhaps
> > it is because of the combination of the host and guest's buffer 
> > cache? I'd like to know about more percise benchmarking methods 
> > for VMs.
> 
> How are the virtual disks for the VM implemented?  If you're doing
> direct I/O these numbers are indeed strange.  If not OTOH that's
> expected because even synchronous I/O in the guest is actually
> async which makes it a lot faster.

The virtual block device driver in coLinux, named cobd, is synchronous 
with the host OS highest level read()/write() functions, which 
means e.g. for a READ block I/O request in the guest, 
filp->f_op->read() is called on an open 'struct file' in the host. 
If the call blocks, the entire guest VM blocks on it. 

So, according to this, any type of I/O in the guest means synchronous 
I/O in the host unless the data is already in the guest's buffer cache.

It's not really the implementation I am planning to stick to, but 
it sure was very easy to implement. 

BTW, the block device on the host side can be a file or any 
device that exposes read()/write() interfaces to userspace. In 
this benchmarking case it is a 3GB file that hosts an image of 
an ext3 filesystem.

-- 
Dan Aloni
da-x@colinux.org

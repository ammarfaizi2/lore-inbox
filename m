Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSJ1TvC>; Mon, 28 Oct 2002 14:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSJ1TvC>; Mon, 28 Oct 2002 14:51:02 -0500
Received: from bozo.vmware.com ([65.113.40.131]:38409 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261555AbSJ1TvB>; Mon, 28 Oct 2002 14:51:01 -0500
Date: Mon, 28 Oct 2002 11:58:31 -0800
From: chrisl@vmware.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021028195831.GC1564@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024183327.GS3354@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Thu, Oct 24, 2002 at 08:33:27PM +0200, Andrea Arcangeli wrote:
> > 
> > That is exactly the case for vmware ram file. VMware only use it to share
> > memory. Those are the virtual machine's memory. We don't want to write
> > it back to disk and we don't care what is left on the file system because
> > when vmware exit, we will throw the guest ram data away just like a real
> > machine power off ram will lost. We are not talking about machine using
> > flash ram :-). 
> > 
> > It is kswapd try to flush the data and it should take response to handle
> > the error. If it fail, one thing it should do is keep the page dirty
> > if write back fail. At least not corrupt memory like that.
> > 
> > If we can deliver the error to user program that would be a plus.
> > But this need to be fix frist.
> 
> as said this cannot be fixed easily in kernel, or it would be trivial to
> lockup a machine by filling the fs changing the i_size of a file and by
> marking all ram in the machine dirty in the hole, the vm must be allowed
> to discard those pages and invaliding those posted writes. At least
> until a true solution will be available you should change vmware to
> preallocate the file, then it will work fine because you will catch the
> ENOSPC error during the preallocation. If you work on shmfs that will be
> very quick indeed.

I still think throwing process's page away if write fail is bad.
If kernel drop the data, that process is not able to run correctly
anyway. Why not keep the page here and let oom killer to pick up the
process to kill. In this way, we at least have some process able to run
correctly instead of every process which hit the out of disk space has
some bad data.

Cheers

Chris




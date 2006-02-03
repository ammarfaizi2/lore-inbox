Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWBCJ0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWBCJ0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWBCJ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:26:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932195AbWBCJ0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:26:47 -0500
Date: Fri, 3 Feb 2006 01:26:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: axboe@suse.de, AChittenden@bluearc.com, davej@redhat.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed
 process 16498 (java).
Message-Id: <20060203012607.0a9d6730.akpm@osdl.org>
In-Reply-To: <1138958409.3828.9.camel@imp.csi.cam.ac.uk>
References: <89E85E0168AD994693B574C80EDB9C2703556694@uk-email.terastack.bluearc.com>
	<20060127142146.GN4311@suse.de>
	<1138372797.22112.44.camel@imp.csi.cam.ac.uk>
	<1138958409.3828.9.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> Hi,
> 
> On Fri, 2006-01-27 at 14:39 +0000, Anton Altaparmakov wrote:
> > A colleague has a server (which does backups) that is incapable of doing
> > a backup due to the backup process being killed due to OOM after
> > anywhere between 30s and a few minutes of running...  And the backup
> > process is just a simple program that does the equivalent of "dd with
> > one source but two destinations" where the source is an lvm/dm snapshot
> > and the two destinations are two different tape drives attached via
> > scsi.  That is pretty critical, admittedly only to us and that system...
> 
> We found a workaround for the OOM problems on above server yesterday.  
> 
> Add a 1MiB swap file:
> 
> dd if=/dev/zero of=/var/swapfile bs=1024 count=1024
> mkswap /var/swapfile
> swapon /var/swapfile
> 
> Run backup script and no problems!
> 
> Note: This is a suse SLES9 system and the problem is not present on
> kernel kernel-smp-2.6.5-7.193.i586.rpm and all earlier kernels and it is
> present on kernel-smp-2.6.5-7.201.i586.rpm and all later kernels
> including the latest kernel (2.6.5-7.244).
> 
> Seems like a definite VM bug...  Interestingly on the .244 kernel the
> OOM conditions print out a lot of debug information to dmesg about the
> memory use in the system and AFAICS none of the memory is exhausted!  So
> it seems the system goes OOM without it actually being OOM because it
> detects that "free swap == 0" or something along those lines...

It does sound like that.  Does it still happen if there's 1MB of swap
online and it's all full?

> Or do we nowadays require swap to be present?

Shouldn't be the case.

> The machine has 6GiB RAM so swap was turned off on it.  (In our
> experience if a machine with a lot of concurrent connections starts
> swapping the system goes down the drain (it becomes too slow) so swap is
> not something we want on servers with 40000+ users...)

1MB of swap isn't likely to cause a lot of swapping.   

> If the above is not enough information to find/fix the problem please
> let me know what more you would like to know...

It'd be nice to see the oom-killer output.

I don't recall a problem like this.  I wonder if there are any suse changes
which might have triggered it.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264841AbTFLOz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 10:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264842AbTFLOz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 10:55:26 -0400
Received: from mail.zmailer.org ([62.240.94.4]:28377 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S264841AbTFLOzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 10:55:25 -0400
Date: Thu, 12 Jun 2003 18:09:09 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dave Jones <davej@codemonkey.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD ..
Message-ID: <20030612150909.GI28900@mea-ext.zmailer.org>
References: <20030612111437.GE28900@mea-ext.zmailer.org> <20030612151704.A2588@pclin040.win.tue.nl> <20030612145814.GB14795@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612145814.GB14795@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 03:58:14PM +0100, Dave Jones wrote:
>  >               Transfer sizes, and the alignment  of  user  buffer
>  >               and  file offset must all be multiples of the logi-
>  >               cal block size of the file system.
> 
> Just to confirm something that I wrote in the post-halloween-2.5 doc,
> that doesn't tally with this..
> 
> - The size and alignment of O_DIRECT file IO requests now matches that
>   of the device, not the filesystem.  Typically this means that
>   you can perform O_DIRECT IO with 512-byte granularity rather than 4k.
> 
> Is this a case of the man pages not following 2.5 yet, or is this
> incorrect ?

I think of three things:
   - 2.4 defines rules in most confusing manner
   - 2.5 continues that
   - We need more complete IRIX's O_DIRECT API:

from open(2):
     O_DIRECT
         If set, all reads and writes on the resulting file descriptor will
         be performed directly to or from the user program buffer, provided
         appropriate size and alignment restrictions are met.  Refer to the
         F_SETFL and F_DIOINFO commands in the fcntl(2) manual entry for
         information about how to determine the alignment constraints.
         O_DIRECT is a Silicon Graphics extension and is only supported on
         local EFS and XFS file systems, and remote BDS file systems.


from fcntl(2):
     F_SETFL   Set file status flags to the third argument, ....

            Flags not understood for a particular descriptor are silently
            ignored except for FDIRECT. FDIRECT will return EINVAL if used
            on other than an EFS, XFS or BDS file system file.

     F_DIOINFO Get information required to perform direct I/O on the specified
            fildes.  Direct I/O is performed directly to and from a user's
            data buffer. Since the kernels buffer cache is no longer
            between the two, the user's data buffer must conform to the
            same type of constraints as required for accessing a raw disk
            partition.  The third argument, arg, points to a data type
            struct dioattr which is defined in the <fcntl.h> header file
            and contains the following members: d_mem is the memory
            alignment requirement of the user's data buffer. d_miniosz
            specifies block size, minimum I/O request size, and I/O
            alignment.  Ths size of all I/O requests must be a multiple of
            this amount and the value of the seek pointer at the time of
            the I/O request must also be an integer multiple of this
            amount.  d_maxiosz is the maximum I/O request size which can be
            performed on the fildes.  If an I/O request does not meet these
            constraints, the read(2) or write(2) will return with EINVAL.
            All I/O requests are kept consistent with any data brought into
            the cache with an access through a non-direct I/O file
            descriptor.  See also F_SETFL above and open(2).

> 		Dave

/Matti Aarnio

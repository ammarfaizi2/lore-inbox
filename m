Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSGYHEa>; Thu, 25 Jul 2002 03:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSGYHEa>; Thu, 25 Jul 2002 03:04:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12809 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318355AbSGYHE3>; Thu, 25 Jul 2002 03:04:29 -0400
Message-ID: <3D3FA3B2.9090200@zytor.com>
Date: Thu, 25 Jul 2002 00:07:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
References: <aho5ql$9ja$1@cesium.transmeta.com> <20020725065109.GO574@clusterfs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> I had thought on this briefly in the past, and my take would be for these
> ABI definition files to live directly in /usr/include/linux for user space
> (just as glibc puts its own sanitized copy of the kernel headers there)
> and the appropriate ABI headers are included as needed from the kernel.
> 

Given no legacy, I would agree with this, but I think it would imply bad 
legacy both on the kernel and the libc (it's not just glibc, either) side.

> The kernel side would be something like <linux/scsi.h> includes
> <linux/abi/scsi.h> or whatever, but in the future this can be included
> directly as needed throughout the kernel.  The existing kernel
> <linux/*.h> headers would also have extra kernel-specific data in them.
> 
> The same could be done with the user-space headers, but I think that
> is missing the point that the linux/abi/*.h headers should define _all_
> of the abi, so we may as well just use that directly.

Except now the paths are gratuitously different between kernel 
programming and non-kernel programming, and we create a much harder 
migration problem.  I'd rather leave the linux/* namespace to the 
user-space libc to do whatever backwards compatibility cruft they may 
consider necessary, for example, <linux/io.h> might #include <sys/io.h> 
since some user space apps bogusly included the former name.  Leaving 
that namespace available for backwards compatibility hacks avoids those 
kinds of problems.

> Essentially "all" this would mean is that we take the existing headers,
> remove everything which is inside #ifdef __KERNEL__ (and all of the
> other kernel-specific non-abi headers that are included) and we are
> done.  The kernel header now holds only things that were inside the
> #ifdef __KERNEL__ (or should have been), and #include <linux/abi/foo.h>.

Exactly.

	-hpa



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUGXFbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUGXFbf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUGXFbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:31:35 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:55178 "EHLO
	kryten.internal.splhi.com") by vger.kernel.org with ESMTP
	id S268294AbUGXFbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:31:33 -0400
Subject: Re: clearing filesystem cache for I/O benchmarks
From: Tim Wright <timw@splhi.com>
To: Benjamin Rutt <rutt.4+news@osu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87vfgeuyf5.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1090647090.8775.19.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 23 Jul 2004 22:31:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look at the code in hdparm tool that handles the '-f' option.

Basically calling ioctl(fd, BLKFLSBUF, o) where fd is a file descriptor
opened on the block device on which your filesystem resides should be
enough to clear the cache.

Regards,

Tim

On Fri, 2004-07-23 at 15:54, Benjamin Rutt wrote:
> How can I purge all of the kernel's filesystem caches, so I can trust
> that my I/O (read) requests I'm trying to benchmark bypass the kernel
> filesystem cache?
> 
> Unfortunately, I cannot:
> 
> 1) reboot the system
> 
> 2) re-mount the filesystem where the reads are occuring
> 
> So I propose that I am left with the following options:
> 
> 3) Reading through a file sufficiently larger than the RAM installed
>    on the system?  e.g. read through a 10GB file on a machine with 8GB
>    of RAM
> 
> 4) Since I can create the files fresh every time, I would write() them
>    out using O_DIRECT flag to open(), then the immediately following
>    read of that file would be guaranteed to avoid pulling it from
>    cache.
> 
> So, can someone evaluate whether how whether options 3 and 4 would
> work, or offer other suggestons?  And I wouldn't object if the issue
> of clearing disk and controller cache entered into the discussion (I'm
> thinking #3 would do a better job at clearing disk/controller caches).
> 
> In case it is relevant, here are the two relevant kernel versions I'm
> using, both under the distribution "Red Hat Enterprise Linux AS
> release 3 (Taroon)":
> 
>     Linux xio11 2.6.6 #2 SMP Wed Jun 9 10:37:24 EDT 2004 i686 i686 i386 GNU/Linux
>     
>     Linux xio06 2.4.21-9.ELhugemem #1 SMP Tue Apr 27 13:52:32 EDT 2004 i686 i686 i386 GNU/Linux
>     
> Thank you,
-- 
Tim Wright <timw@splhi.com>
Splhi

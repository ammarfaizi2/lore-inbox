Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263834AbRFHFQC>; Fri, 8 Jun 2001 01:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263836AbRFHFPl>; Fri, 8 Jun 2001 01:15:41 -0400
Received: from [203.117.131.2] ([203.117.131.2]:33776 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S263834AbRFHFPh>; Fri, 8 Jun 2001 01:15:37 -0400
Message-ID: <3B205F61.A5820A37@metaparadigm.com>
Date: Fri, 08 Jun 2001 13:15:13 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
        xgajda@fi.muni.cz, kron@fi.muni.cz
Subject: Re: CacheFS
In-Reply-To: <200106072223.f57MNxh414151@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Jan Kasprzak writes:
> 
> >                             Another goal is to use the Linux filesystem
> > as a backing store (as opposed to the block device or single large file
> > used by CODA).
> ...
> > - kernel module, implementing the filesystem of the type "cachefs"
> >       and a character device /dev/cachefs
> > - user-space daemon, which would communicate with the kernel
> >       over /dev/cachefs and which would manage the backing store
> >       in a given directory.
> >
> >       Every file on the front filesystem (NFS or so) volume will be cached
> > in two local files by cachefsd: The first one would contain the (parts of)
> ...
> > * Should the cachefsd be in user space (as it is in the prototype
> > implementation) or should it be moved to the kernel space? The
> > former allows probably better configuration (maybe a deeper
> > directory structure in the backing store), but the later is
> > faster as it avoids copying data between the user and kernel spaces.
> 
> I think that, if speed is your goal, you should have the kernel
> code use swap space for the cache. Look at what tmpfs does, but
> running over top of tmpfs leaves you with the overhead of running
> two filesystems and a daemon. It is better to be direct.

So how would you get persistent caching across reboots which is one of
the major advantages of a cachefs type filesystem. I guess you could tar
the cache on startup and shutdown although would be a little slow :).

I think 'speed' here means faster than NFS or other network filesystems
- you obviously have the overhead of network traffic for cache-coherency
but can avoid a lot of data transfer (even after a reboot).

~mc

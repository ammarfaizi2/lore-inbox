Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263476AbRFGWY0>; Thu, 7 Jun 2001 18:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263496AbRFGWYP>; Thu, 7 Jun 2001 18:24:15 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:13317 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263476AbRFGWYC>;
	Thu, 7 Jun 2001 18:24:02 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106072223.f57MNxh414151@saturn.cs.uml.edu>
Subject: Re: CacheFS
To: kas@informatics.muni.cz (Jan Kasprzak)
Date: Thu, 7 Jun 2001 18:23:59 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, xgajda@fi.muni.cz, kron@fi.muni.cz
In-Reply-To: <20010607133750.I1193@informatics.muni.cz> from "Jan Kasprzak" at Jun 07, 2001 01:37:50 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak writes:

>                             Another goal is to use the Linux filesystem
> as a backing store (as opposed to the block device or single large file
> used by CODA).
...
> - kernel module, implementing the filesystem of the type "cachefs"
> 	and a character device /dev/cachefs
> - user-space daemon, which would communicate with the kernel
>       over /dev/cachefs and which would manage the backing store
>       in a given directory.
>
> 	Every file on the front filesystem (NFS or so) volume will be cached
> in two local files by cachefsd: The first one would contain the (parts of)
...
> * Should the cachefsd be in user space (as it is in the prototype
> implementation) or should it be moved to the kernel space? The
> former allows probably better configuration (maybe a deeper
> directory structure in the backing store), but the later is
> faster as it avoids copying data between the user and kernel spaces.

I think that, if speed is your goal, you should have the kernel
code use swap space for the cache. Look at what tmpfs does, but
running over top of tmpfs leaves you with the overhead of running
two filesystems and a daemon. It is better to be direct.

Maybe this shouldn't even be a filesystem. You could have a general
way to flag a filesystem as being significantly slower than swap.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311451AbSCNAhQ>; Wed, 13 Mar 2002 19:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311456AbSCNAhG>; Wed, 13 Mar 2002 19:37:06 -0500
Received: from 12-224-223-87.client.attbi.com ([12.224.223.87]:31753 "EHLO
	labrador.dhs.org") by vger.kernel.org with ESMTP id <S311451AbSCNAgz>;
	Wed, 13 Mar 2002 19:36:55 -0500
Date: Wed, 13 Mar 2002 16:46:00 -0800 (PST)
From: David Oleszkiewicz <davido@labrador.dhs.org>
To: <linux-kernel@vger.kernel.org>
cc: <ekline@ekline.com>
Subject: Re: [module/patch] optional /proc/patches ??
Message-ID: <20020313162620.D82267-100000@labrador.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I played around with this a while ago and ended up writing some code
which i might be able to find if you'd like.  I took a different
approach:

Have a script wrap around the patch command to just generate a log file
of the patches that wre applied.  (eg linux/patchlog.txt)
Then on kernel build, when we build the whole include/config hierarchy
you can have a script or program take that log and create a header file
out of it.  The header file creates a data structure similar to your
struct patch_list_elem patchlist[].  That way, when you are patching the
kernel you aren't dynamically patching some data structure file somewhere.
I found using th md5 checksum of the file to be useful.  Your module code
can then take that header file and export it's information via /proc.
I found this useful for a little while, but realized that setting the
EXTRAVERSION variable in the main Makefile was good enough for me.  This
could be more useful in an enterprise environment though, when service
people sweep in to debunk a kernel they can easily see what patches were
applied, even if the kernel source was hidden by a sneaky sys admin who
wants to get his money's worth on his service contract by making things
difficult. :>.

> All,
>
> I was wondering whether something like a /proc/patches might be useful.
> This could help list patches applied to a kernel such that "uname -a" and "cat
> /proc/patches" provides some good information about the kernel,
> especially stock kernels from distributions. I was able to work up a quick module
> available at the link below. NOTE: I couldn't solve how to add entries
> fo a patchlist structure using regular context diffs, but ed diffs work
> just great. More information in the README attached. I'd very much appreciate
> any feedback on whether this is useful and how it should actually be
> implemented, if at all. Please note that my only access to lkml traffic is via Kernel
> Traffic so I would appreciate being Cc'ed.
>
> Thanks all,
>
> -Erik (humble linux aficionado)
>
> [patchlist module]
> http://ekline.com/linux/patchlist-0.0.1.tar.gz




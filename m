Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSJZHrM>; Sat, 26 Oct 2002 03:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSJZHrM>; Sat, 26 Oct 2002 03:47:12 -0400
Received: from ns.suse.de ([213.95.15.193]:46086 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261914AbSJZHrL>;
	Sat, 26 Oct 2002 03:47:11 -0400
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Oct 2002 09:53:26 +0200
In-Reply-To: Rob Landley's message of "26 Oct 2002 04:01:47 +0200"
Message-ID: <p7365vptz49.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:

I have some patches to offer better than second resolution for stat.
That is needed for parallel make on MP systems, because otherwise it
cannot detect changes that need less than a second to execute. With CPUs
being as fast as they are and getting even faster currently it is becomming 
a bigger problem. You don't hit it that easily with gcc because it's 
getting faster slower than cpus are getting faster so it's usually slower
than a second, but some people use make rules with other compilers or other 
commands.

I see it in the same category as "necessary changes" similar to 32bit dev_t. 

Linux already has several filesystems in tree that support ns or better than s 
resolution in their underlying formats (XFS,JFS,NFSv3,VFAT)

Patches available on request or older versions from 
ftp://ftp.firstfloor.org/pub/ak/v2.5/nsec*
They don't actually add ns resolution, but jiffies resolution, which
is 1ms on 2.5 and should be good enough for now. It reuses reserved fields
in struct stat and doesn't need any user interface changes.

It requires editing of a lot of file systems in a straight forward way,
so should be better done before the stable series starts.

There are some minor compatbility issues with fs that only support 
second timestamps like ext2/ext3, see nsec.notes in the ftp directory
or past threads on that on the list.

-Andi

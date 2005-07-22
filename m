Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVGVHTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVGVHTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 03:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVGVHTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 03:19:41 -0400
Received: from [194.90.79.130] ([194.90.79.130]:14601 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261787AbVGVHTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 03:19:40 -0400
Message-ID: <42E09DC1.90602@argo.co.il>
Date: Fri, 22 Jul 2005 10:18:25 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: fastboot, diskstat
References: <20050722034135.GA21201@outpost.ds9a.nl> <20050722144710.47e0cbd6.akpm@osdl.org>
In-Reply-To: <20050722144710.47e0cbd6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2005 07:19:39.0356 (UTC) FILETIME=[B8E649C0:01C58E8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>The above data is enough for performing a crude preload:
>
>a) Boot the machine
>
>b) Boost the disk queue size, set the VFS readahead to zero, open
>   /dev/hda1 and all the regular files, hose reads at the disk via
>   fadvise().  Restore VFS readahead and queue size, continue with boot.
>  
>
opening all these files will require synchronous reads of their 
directories and inodes, so you might need to split b) into first opening 
and reading /dev/hda1, then opening and reading the regular files.

>And I suspect that the whole thing will be of marginal benefit.  Although
>things might be better now that files are laid out with the Orlov allocator
>(make sure that the distro was installed with a 2.6 kernel!  The file
>layout will be quite different if the installer used a 2.4 ext3).
>
>Of course the next step is to rewrite files so that they are more
>favourably laid out on disk.  Tricky.  Or dump all pagecache to some temp
>file in a nice linear slurp and preload that, copying it all to the
>appropriate per-inode pagecaches and taking care of files which have been
>modified.  Trickier ;)
>  
>
another possibility: use a device mapper module under /dev/hda1 that 
records I/O patterns, then relocates blocks to fit that pattern, so that 
the normal boot sequence ends up issuing sequential disk writes.

parallelized initscripts will probably defeat this, though.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


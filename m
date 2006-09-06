Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbWIFXEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWIFXEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWIFXE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:04:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2776 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965210AbWIFXEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:04:01 -0400
Date: Thu, 7 Sep 2006 09:02:38 +1000
From: David Chinner <dgc@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: Wrong free space reported for XFS filesystem
Message-ID: <20060906230238.GJ5737019@melbourne.sgi.com>
References: <9a8748490609060154ye8730b0n16e23524010a35e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490609060154ye8730b0n16e23524010a35e4@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 10:54:34AM +0200, Jesper Juhl wrote:
> For your information;
> 
> I've been running a bunch of benchmarks on a 250GB XFS filesystem.
> After the benchmarks had run for a few hours and almost filled up the
> fs, I removed all the files and did a "df -h" with interresting
> results :
> 
> /dev/mapper/Data1-test
>                     250G  -64Z  251G 101% /mnt/test
> 
> "df -k"  reported this :
> 
> /dev/mapper/Data1-test
>                     262144000 -73786976294838202960 262147504 101% /mnt/test
....
> The filesystem is mounted like this :
> 
> /dev/mapper/Data1-test on /mnt/test type xfs
> (rw,noatime,ihashsize=64433,logdev=/dev/Log1/test_log,usrquota)

So the in-core accounting has underflowed by a small amount but the
on disk accounting is correct.

We've had a few reports of this that I know of over the past couple of years,
but we've never managed to find a reproducable test case for it.

Can you describe what benchmark you were runnin, wht kernel you were
using and whether any of the tests hit  an ENOSPC condition?

Also, in future can you cc xfs@oss.sgi.com on XFS bug reports?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

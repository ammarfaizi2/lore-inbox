Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271793AbRICUHJ>; Mon, 3 Sep 2001 16:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271795AbRICUG7>; Mon, 3 Sep 2001 16:06:59 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:60602 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271793AbRICUGp>; Mon, 3 Sep 2001 16:06:45 -0400
Date: Mon, 3 Sep 2001 14:07:03 -0600
Message-Id: <200109032007.f83K73H27504@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: <pmhahn@titan.lahn.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuid/msr + devfs
In-Reply-To: <Pine.LNX.4.33.0108121020050.1068-100000@titan.lahn.de>
In-Reply-To: <Pine.LNX.4.33.0108121020050.1068-100000@titan.lahn.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Matthias Hahn writes:
> Hello Richard, LKML!
> 
> Back in 2000 Philip Langdale posted a patch to make
> arch/i386/kernel/{cpuid,msr}.c devfs aware. Richard Gooch had some
> comments for him but I never saw an "improved" patch.
> 
> I tried to clean it up a little bit and it look's better, but here are the
> things I don't like myself:
> - Do we need to keep cpu_devfs_handle or should we re-find it on
>   unregister?

Better to have a central place which creates per-CPU directories,
which you can call into and grab a directory for a CPU.

> - There is no devfs_unregister_series.

Correct. I'm not sure that we really want one, either.

> - Shouldn't we register_chrdev() "cpu/%d/cpuid"?

You could if you want.

> - "cpu/%d" directoried are never removed on unregister.

Such directories should only be removed when a CPU is removed. And to
support that, you need the CPU hotplug patch.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

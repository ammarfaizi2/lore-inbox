Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRCWTjB>; Fri, 23 Mar 2001 14:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131378AbRCWTiv>; Fri, 23 Mar 2001 14:38:51 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:21513 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131375AbRCWTic>; Fri, 23 Mar 2001 14:38:32 -0500
Date: Fri, 23 Mar 2001 19:37:46 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Amit D Chaudhary <amit@muppetlabs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: RAMFS, CRAMFS and JFFS2(was Re: /linuxrc query)
In-Reply-To: <3ABB8F57.3000800@muppetlabs.com>
Message-ID: <Pine.LNX.4.30.0103231853280.2898-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Amit D Chaudhary wrote:

> Hi David,
> 
> I did consider CRAMFS and JFFS2 when it was announced on the mtd list. 
> Conserving flash over system ram is more relevant. Our reasons are below:
> 
> RAMFS v/s CRAMFS
> 1. RAMFS is just more stable in terms of less complexity, less bugs reported 
> over the time, etc.
> 2. RAMFS is a fairly robust filesystem and all features required as far as I can 
> tell.

I'm not aware of any bugs being found in cramfs recently - unless you 
wanted to use it on Alpha (or anything else where PAGE_SIZE != the 
hard-coded 4096 in mkcramfs.c).

I wouldn't avoid it for those reasons - although if you're _really_ short 
of flash space, the same argument applies as for JFFS2 - a single 
compression stream (tar.gz) will be smaller than compressing individual 
pages like JFFS2 and cramfs do.


> I might be wrong and hence would welcome any suggestions.

Given your stated constraints - you're very short of flash and don't care
too much about the RAM you use, you've may have made the same choice I
would have done.

Bearing in mind that you have to take into account the overhead of the 
initrd which does the untarring - what's the total size of the initrd + 
tarball on the flash, and what size would the corresponding cramfs be?

If you could fit your root filesystem into a cramfs on the flash, I'd do
that instead and use ramfs for the parts which need to be writeable.


-- 
dwmw2




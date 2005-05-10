Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVEJIlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVEJIlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVEJIlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:41:03 -0400
Received: from koto.vergenet.net ([210.128.90.7]:64670 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S261583AbVEJIkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:40:52 -0400
Date: Tue, 10 May 2005 17:09:07 +0900
From: Horms <horms@debian.org>
To: Carlos Rodrigues <carlos.efr@mail.telepac.pt>, 308072@bugs.debian.org
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: statfs returns wrong values for 250Gb FAT fs
Message-ID: <20050510080907.GR1998@verge.net.au>
References: <E1DUT2T-0000fm-Nx@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DUT2T-0000fm-Nx@localhost.localdomain>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 06:24:29PM +0100, Carlos Rodrigues wrote:
> Package: kernel-image-2.6.8-2-386
> Version: 2.6.8-13
> Severity: important
> 
> 
> I have a 250Gb external USB 2.0 hard-drive formatted with FAT32 and "df"
> always reports 64Kb of used space on it, although it contains a couple of
> gigabytes.
> 
> At first I thought the problem might be in "df" itself, but the following
> test code proves the statfs function is to blame. The values returned are
> incorrect.
> 
> However, it does report correct values for another FAT32 partition I have
> (70Gb).
> 
> 
> ----------- statfs.c -----------
> 
> #include <sys/vfs.h>
> 
> 
> int main(int argc, char *argv[])
> {
>     struct statfs stats;
>     long used;
>     int kib;
> 
>     if (argc < 2) {
>         printf("USAGE: %s <mountpoint>\n", argv[0]);
>       
>         return 1;
>     }
> 
>     statfs(argv[1], &stats);
>     used = stats.f_blocks - stats.f_bfree;
>   
>     printf("f_bsize = %ld blocks\nf_blocks = %ld blocks\nf_bfree = %ld blocks\nused = %ld blocks\n",
>            stats.f_bsize, stats.f_blocks, stats.f_bfree, used);
> 
>     kib = stats.f_bsize / 1024;
>     printf("total = %ld KiB\nfree = %ld KiB\nused = %ld KiB\n",
>            kib * stats.f_blocks,
>            kib * stats.f_bfree,
>            kib * used);
> 
>     return 0;
> }
> 
> ----------- eof - statfs.c -----------

Carlos,

this looks like it could be an issue with the fat file system
handling a somewhat large filesystem. I have CCed the maintainer
for comment. I have looked through most of the changes made
to fat and vfat since 2.6.8.1 and I wasn't able to see anything
there that looked like it would help your cause.

-- 
Horms

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVBWXDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVBWXDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVBWXCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:02:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:25299 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261671AbVBWW6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:58:22 -0500
Date: Wed, 23 Feb 2005 15:03:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-Id: <20050223150333.6ce83aef.akpm@osdl.org>
In-Reply-To: <421CFF5E.4030402@mesatop.com>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<421CB161.7060900@mesatop.com>
	<20050223121759.5cb270ee.akpm@osdl.org>
	<421CFF5E.4030402@mesatop.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> Andrew Morton wrote:
> > Steven Cole <elenstev@mesatop.com> wrote:
> 
> >> I am having trouble getting recent -mm kernels to boot on my test box.
> >> For 2.6.11-rc3-mm2 and 2.6.11-rc4-mm1 I get the following:
> >>
> >> VFS: Cannot open root device "301" or unknown-block(3,1)
> >> Please append a correct "root=" boot option
> >> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3,1)
> >>
> [snipped]
> > 
> > Please set CONFIG_BASE_FULL=y.  Check that this causes CONFIG_BASE_SMALL=0,
> > then retest.
> 
> Yes, that worked.

hmm, OK.  Matt, we have a block major enumeration problem.  It appears that
base-small-shrink-chrdevs-hash.patch has the same problem which
base-small-shrink-major_names-hash.patch had.


>  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be missing.
> 
> [root@spc1 steven]# uname -r
> 2.6.11-rc4-mm1-GX110
> [root@spc1 steven]# mount -t reiser4 /dev/hdb1 /reiser4_testing
> mount: special device /dev/hdb1 does not exist

It would seem that your /dev/hdb1 block-special device node isn't present. 
Try `mknod /dev/hdb1 3 65'.

> hdb: max request size: 128KiB
> hdb: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(66)
> hdb: cache flushes not supported
>   /dev/ide/host0/bus0/target1/lun0: p1

We found a partition.

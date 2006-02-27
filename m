Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWB0B55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWB0B55 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 20:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWB0B55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 20:57:57 -0500
Received: from xenotime.net ([66.160.160.81]:44452 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750944AbWB0B55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 20:57:57 -0500
Date: Sun, 26 Feb 2006 17:59:12 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: adobriyan@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: zcat: stdin: decompression OK
Message-Id: <20060226175912.bab4b473.rdunlap@xenotime.net>
In-Reply-To: <43FE90D6.1060801@ums.usu.ru>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<43FC6B8F.4060601@ums.usu.ru>
	<20060222225325.10a71472.rdunlap@xenotime.net>
	<20060223182107.GB7803@mipter.zuzino.mipt.ru>
	<43FE90D6.1060801@ums.usu.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006 09:51:34 +0500 Alexander E. Patrakov wrote:

> Alexey Dobriyan wrote:
> > On Wed, Feb 22, 2006 at 10:53:25PM -0800, Randy.Dunlap wrote:
> >> On Wed, 22 Feb 2006 18:47:59 +0500 Alexander E. Patrakov wrote:
> >>> Unfortunately, I lost my .config from the old kernel, so I attempted the
> >>> following:
> >>>
> >>> cd scripts
> >>> make binoffset
> >>> cd ..
> >>> scripts/extract-ikconfig /boot/vmlinuz-2.6.16-rc3-mm1-home >.config
> >>>
> >>> This results in:
> >>>
> >>> zcat: stdin: decompression OK, trailing garbage ignored
> >> No other output?  what $ARCH?
> >> What did the .config file contain?  was it correct?
> >> so is the only problem the zcat warning message?
> >>
> >> I tested extract-ikconfig several times without errors (on 2.6.16-rc4-mm1).
> > 
> > Since I can reproduce it, Randy, what version do you use? 1.3.5-r8 here
> > from Gentoo.
> > 
> > At least, we can trivially shut it up.
> 
> I think this would be wrong, because I am able to extract the config 
> without warnings from 2.6.15-mm2 or even vanilla 2.6.16-rc4, but not 
> vmlinuz-2.6.16-rc3-mm1. So something changed in -mm between 2.6.15-mm2 
> and 2.6.16-rc3-mm1 in the way how bzImages are produced.

Alexey,
It's the final zcat that is complaining -- last one in the script:
	(dd ibs="$off" skip=1 count=0 && dd bs=512k) <"$image" 2>/dev/null | \
		zcat >"$TMPFILE"

The 'dd' command begins at the gzip header of the kernel image file,
but it doesn't know where the end of the gzip area is, it just feeds
everything from $off to zcat, and zcat finds more data than it needs/wants.

still looking.
---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVGBXDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVGBXDO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 19:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGBXDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 19:03:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13581 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261322AbVGBXDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 19:03:07 -0400
Date: Sun, 3 Jul 2005 01:03:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Mike Bell <mike@mikebell.org>, linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty /dev
Message-ID: <20050702230303.GA27261@alpha.home.local>
References: <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr> <20050630155453.GA6828@kroah.com> <42C455C1.30503@free.fr> <20050702053711.GA5635@kroah.com> <42C640AC.1020602@free.fr> <20050702082218.GM8907@alpha.home.local> <42C659B2.8010002@free.fr> <20050702100349.GA25749@alpha.home.local> <20050702201356.GA32409@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050702201356.GA32409@mikebell.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 01:13:58PM -0700, Mike Bell wrote:
> On Sat, Jul 02, 2005 at 12:03:49PM +0200, Willy Tarreau wrote:
> > They cost almost nothing, and in all cases, far less than the required code
> > to autodetect them.
> 
> I beg to differ on that. As ndevfs has shown, the code required to
> create a device node from kernel space is actually very minimal, when
> you utilize all the infrastructure already available to you in the
> kernel. libfs has most of what you need, the rest is easily stolen from
> ramfs. Almost undoubtebly much less than all those device nodes,
> especially when you consider the need to be able to perform chown/chmod
> on nodes (thus they can't be stored in the read-only flash image, but
> must instead be created at each boot on a kernel-generated filesystem
> like ramfs)

Well, here on my firewall, the /.preinit script is 1.7 kB and the init
binary which does everything (mkdir,mknod,chmod,chown,mount,...) is 5.6 kB.
I doubt you can enable devfs in a kernel for less than 8 kB. One /tmpfs
entry consumes about 600 bytes of RAM, which is still fairly acceptable
IMHO.

> devfs not utilizing it is perfectly explainable by the fact none of it
> was around way back when devfs was created. Back then kernel generated
> filesystems were proc, proc and proc. proc is pretty ugly too.

Regards,
Willy


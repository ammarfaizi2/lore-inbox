Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUILUFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUILUFp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 16:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUILUFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 16:05:45 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:30891 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261169AbUILUFm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 16:05:42 -0400
Date: Sun, 12 Sep 2004 23:05:40 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [patch]   Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040912200540.GA18013@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de> <20040907181641.GB2154@mellanox.co.il> <20040908065548.GE27886@wotan.suse.de> <20040908142808.GA11795@mellanox.co.il> <20040908143852.GA27411@wotan.suse.de> <20040908145432.GA12332@mellanox.co.il> <20040908145837.GD15444@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908145837.GD15444@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: [patch]   Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> > So I wander what goes on here- the syscall returns a long but
> > libc cuts the high 32 bit?
> 
> System calls are always long, otherwise the syscall exit code cannot
> check properly for signal restarts. 
> 
> glibc seems to indeed truncate. 
> 
> > 
> > Now that I think about it,for compat if you start returning 0 in low
> > 32 bits you are unlike to get the effect you wanted ...
> > The ioctl_native could be changed but that would make it impossible
> > for compatible ioctls to just use the same pointer in both.
> > 
> > So what do you think - should I make just the native ioctl a long,
> > or both, and document that the high 32 bit are cut in the compat call?
> 
> both + document. 

Given that libc truncates the high 32 bit, that compat call can only use
low 32 bit,  I begin to really think its better to leave this as int
and avoid the whole issue.

Additional advantage is in keeping 
the exact same interface as ioctl is that its easier to change a driver
to use this interface - just assign the call in field, no other changes.

MST

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269063AbUIHPE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269063AbUIHPE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUIHPCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:02:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:44461 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269007AbUIHO6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:58:38 -0400
Date: Wed, 8 Sep 2004 16:58:37 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [patch]   Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040908145837.GD15444@wotan.suse.de>
References: <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de> <20040907181641.GB2154@mellanox.co.il> <20040908065548.GE27886@wotan.suse.de> <20040908142808.GA11795@mellanox.co.il> <20040908143852.GA27411@wotan.suse.de> <20040908145432.GA12332@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908145432.GA12332@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I wander what goes on here- the syscall returns a long but
> libc cuts the high 32 bit?

System calls are always long, otherwise the syscall exit code cannot
check properly for signal restarts. 

glibc seems to indeed truncate. 

> 
> Now that I think about it,for compat if you start returning 0 in low
> 32 bits you are unlike to get the effect you wanted ...
> The ioctl_native could be changed but that would make it impossible
> for compatible ioctls to just use the same pointer in both.
> 
> So what do you think - should I make just the native ioctl a long,
> or both, and document that the high 32 bit are cut in the compat call?

both + document. 

> 
> > The main thing missing is documentation. You need clear comments what
> > the locking rules are and what compat is good for.
> 
> Would these be best fit in the header file itself, or in a new
> Documentation/ file?

Header file should be enough.

> > And you should change the code style to follow Documentation/CodingStyle
> I'll go over it again. Something specific that I missed?

e.g. your use of white space.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUCVWVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbUCVWVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:21:15 -0500
Received: from gate.in-addr.de ([212.8.193.158]:5102 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263718AbUCVWVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:21:12 -0500
Date: Mon, 22 Mar 2004 23:22:16 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <20040322222216.GR25331@marowsky-bree.de>
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com> <4058C089.9060603@adaptec.com> <200403172245.31842.bzolnier@elka.pw.edu.pl> <4058EBEC.8070309@adaptec.com> <1079788027.5225.4.camel@laptop.fenrus.com> <405E287E.3080706@adaptec.com> <1079946343.5296.5.camel@laptop.fenrus.com> <405F61C1.9090907@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <405F61C1.9090907@adaptec.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-03-22T14:59:29,
   Scott Long <scott_long@adaptec.com> said:

> Ok, the technical arguments I've heard in favor of the DM approach is 
> that it reduces kernel bloat.  That fair, and I certainly agree with not
> putting the kitchen sink into the kernel.  Our position on EMD is that
> it's a special case because you want to reduce the number of failure
> modes, and that it doesn't contribute in a significant way to the kernel
> size.  Your response to that our arguments don't matter since your mind
> is already made up.  That's the barrier I'm trying to break through and
> have a techincal discussion on.

The problematic point is that the failure modes which you want to
protect against all basically amount to -EUSERTOOSTUPID (if he forgot to
update the initrd and thus basically missed a vital part of the kernel
update), or -EFUBAR (in which case even the kernel image itself won't
help you). In those cases, not even being linked into the kernel helps
you any.

All of these cases are well understood, and have been problematic in the
past already, and will fuck the user up whether he has EMD enabled or
not. That EMD is coming up is not going to help him much, because he
won't be able to mount the root filesystem w/o the filesystem module,
or without the LVM2/EVMS2 stuff etc. initrd has long been mostly
mandatory already for such scenarios.

This is the way how the kernel has been developing for a while. Your
patch does something different, and the reasons you give are not
convincing.

In particular, if EMD is going to be stacked with other stuff (ie, EMD
RAID1 on top of multipath or whatever), having the autodiscovery in the
kernel is actually cumbersome. And yes, right now you have only one
format. But bet on it, the spec will change, vendors will not 100%
adhere to it, new formats will be supported by the same code etc, and
thus the discovery logic will become bigger. Having such complexity
outside the kernel is good, and its also not time critical, because it
is only done once.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett


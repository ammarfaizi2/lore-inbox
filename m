Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWHFThY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWHFThY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 15:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWHFThX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 15:37:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751440AbWHFThX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 15:37:23 -0400
Date: Sun, 6 Aug 2006 12:37:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-Id: <20060806123715.b62d7b34.akpm@osdl.org>
In-Reply-To: <200608061554.42992.mlkernel@mortal-soul.de>
References: <200608061200.37701.mlkernel@mortal-soul.de>
	<20060806031512.57585f5d.akpm@osdl.org>
	<200608061554.42992.mlkernel@mortal-soul.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006 15:54:42 +0200
Matthias Dahl <mlkernel@mortal-soul.de> wrote:

> > I'd suggest that you generate a kernel profile while the sluggishness is
> > happening.
> 
> Done...

Please always do reply-to-all, especially on linux-kernel.  I'm often two
days behind, sometimes five days.

> profile 1: (emerge of three huge packages which caused quite some IO)
> 
> ...
>
> ffffffff803a0430 scsi_dispatch_cmd                           459   0.7172
> ffffffff8026afda copy_user_generic_c                         854  22.4737
> ffffffff80270e00 default_idle                              49571 516.3646
> 0000000000000000 total                                     54590   0.0232
> 
> profile 2: (emerge of recent kernel sources- huge, causes quite some IO too)
> 
> ...
>
> ffffffff8020cae0 vm_normal_page                              814   4.2396
> ffffffff8026ad70 copy_page                                  1929   8.6116
> ffffffff802075e0 unmap_vmas                                 2362   1.2726
> ffffffff80207d20 copy_page_range                            2683   1.6938
> ffffffff80270e00 default_idle                              45081 469.5938
> 0000000000000000 total                                     64216   0.0273
> 
> I hope this helps.

Well, it rules a lot of things out.  There's plenty of idle time there, so
that rules out a lot of silly things and points the finger at IO scheduler
bustage, poor page-replacement decisions, etc.

hm.  Do you have any reason for thinking that it's specific to any
particular device driver or hardware setup?

How much memory does the machine have?

It'd be interesting if you could gather a `vmstat 1' trace during the
sluggish period.



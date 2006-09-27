Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031264AbWI1AAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031264AbWI1AAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031265AbWI1AAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:00:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031264AbWI1AAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:00:10 -0400
Date: Wed, 27 Sep 2006 16:59:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom kill oddness.
Message-Id: <20060927165954.b73a389c.akpm@osdl.org>
In-Reply-To: <20060927205435.GF1319@redhat.com>
References: <20060927205435.GF1319@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 16:54:35 -0400
Dave Jones <davej@redhat.com> wrote:

> So I have two boxes that are very similar.
> Both have 2GB of RAM & 1GB of swap space.
> One has a 2.8GHz CPU, the other a 2.93GHz CPU, both dualcore.
>
> The slower box survives a 'make -j bzImage' of a 2.6.18 kernel tree
> without incident. (Although it takes ~4 minutes longer than a -j2)
>
> The faster box goes absolutely nuts, oomkilling everything in sight,
> until eventually after about 10 minutes, the box locks up dead,
> and won't even respond to pings.
> 
> Oh, the only other difference - the slower box has 1 disk, whereas the
> faster box has two in RAID0.   I'm not surprised that stuff is getting
> oom-killed given the pathological scenario, but the fact that the
> box never recovered at all is a little odd.  Does md lack some means
> of dealing with low memory scenarios ?

Are you sure it isn't a memory leak?

Suggest you kill things just before it locks up, have a look at
/proc/meminfo, /proc/slabinfo, sysrq-M, echo 3>/proc/sys/vm/drop_caches,
etc.


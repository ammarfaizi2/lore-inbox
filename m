Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbUCSSEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbUCSSEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:04:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:12526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263042AbUCSSEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:04:07 -0500
Date: Fri, 19 Mar 2004 10:03:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: tiwai@suse.de, andrea@suse.de, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040319100311.5aa11733.akpm@osdl.org>
In-Reply-To: <20040319172203.GB4537@in.ibm.com>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<s5hlllycgz3.wl@alsa2.suse.de>
	<20040318110159.321754d8.akpm@osdl.org>
	<s5hbrmuc6ed.wl@alsa2.suse.de>
	<20040318221006.74246648.akpm@osdl.org>
	<20040319172203.GB4537@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> On Thu, Mar 18, 2004 at 10:10:06PM -0800, Andrew Morton wrote:
>  > The worst-case latency is during umount, fs/inode.c:invalidate_list() when
>  > the filesystem has a zillion inodes in icache.  Measured 250 milliseconds
>  > on a 256MB 2.7GHz P4 here.   OK, so don't do that.
>  > 
>  > The unavoidable worst case is in the RCU callbacks for dcache shrinkage -
>  > I've seen 25 millisecond holdoffs on the above machine during filesystem
>  > stresstests when RCU is freeing a huge number of dentries in softirq
>  > context.
> 
>  What filesystem stresstest was that ? 

Something which creates a lot of slab, and a bit of memory pressure
basically.  Such as make-teeny-files from
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUBFDLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUBFDLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:11:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:16063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265352AbUBFDK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:10:59 -0500
Date: Thu, 5 Feb 2004 19:12:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve Lord <lord@xfs.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
Message-Id: <20040205191240.13638135.akpm@osdl.org>
In-Reply-To: <4021AC9F.4090408@xfs.org>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>
	<p73isilkm4x.fsf@verdi.suse.de>
	<4021AC9F.4090408@xfs.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@xfs.org> wrote:
>
>  I have seen some dire cases with the dcache, SGI had some boxes with
>  millions of files out there, and every night a cron job would come
>  along and suck them all into memory. Resources got tight at some point,
>  and as more inodes and dentries were being read in, the try to free
>  pages path was continually getting called. There was always something
>  in filesystem cache which could get freed, and the inodes and dentries
>  kept getting more and more of the memory.

There are a number of variables here.  Certainly, the old
inodes-pinned-by-highmem pagecache will cause this to happen - badly.  2.6
is pretty aggressive at killing off those inodes.

What kernel was it?

Was it a highmem box?  If so, was the filesystem in question placing
directory pagecache in highmem?  If so, that was really bad on older 2.4:
the directory pagecache in highmem pins down all directory inodes.


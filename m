Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVCOXxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVCOXxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVCOXuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:50:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:15031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262162AbVCOXq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:46:27 -0500
Date: Tue, 15 Mar 2005 15:46:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Noah Meyerhans <noahm@csail.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-Id: <20050315154608.29cee352.akpm@osdl.org>
In-Reply-To: <20050315204413.GF20253@csail.mit.edu>
References: <20050315204413.GF20253@csail.mit.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noah Meyerhans <noahm@csail.mit.edu> wrote:
>
> Active:12382 inactive:280459 dirty:214 writeback:0 unstable:0 free:2299 slab:220221 mapped:12256 pagetables:122

Vast amounts of slab - presumably inode and dentries.

What sort of local filesystems are in use?

Can you take a copy of /proc/slabinfo when the backup has run for a while,
send it?

It's useful to run `watch -n1 cat /proc/meminfo', see what the various
caches are doing during the operation.

Also, run slabtop if you have it.  Or bloatmeter
(http://www.zip.com.au/~akpm/linux/patches/stuff/bloatmon and
http://www.zip.com.au/~akpm/linux/patches/stuff/bloatmeter).  The thing to
watch for here is the internal fragmentation of the slab caches:

        dentry_cache:    76505KB    82373KB   92.87

93% is good.  Sometimes it gets much worse - very regular directory
patterns can trigger high fragmentation levels.

Does increasing /proc/sys/vm/vfs_cache_pressure help?  If you're watching
/proc/meminfo you should be able to observe the effect of that upon the
Slab: figure.


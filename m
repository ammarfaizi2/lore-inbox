Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266225AbUFXROt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266225AbUFXROt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266229AbUFXROt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:14:49 -0400
Received: from [66.199.228.3] ([66.199.228.3]:49927 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S266225AbUFXROr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:14:47 -0400
Date: Thu, 24 Jun 2004 10:14:47 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406241714.i5OHElWL026388@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cached memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:
>You may want to examine /proc/meminfo, /proc/slabinfo, and the output
>of sysrq-m.
>
>mm/vmscan.c (kswapd) is responsible for freeing most memory.  The
>routine you are probably most interested in is shrink_cache.
>
>I would check to make sure that the pages in the icache are backed by
>a mapping and if so, that they are clean.   If either of those two
>conditions are not met, then the page cannot be thrown away.


We're locating sysrq-m, I haven't used that before.
/proc/meminfo doesn't give any new insight. /proc/slabinfo the only
thing that jumped out at me was this:
BOX with 16M cached
buffer_head          448    600     96   15   15    1
BOX with 61M cached
buffer_head         1377   4160     96  104  104    1

The inode_cache lines didn't seem to differ much:
inode_cache          838    856    480  107  107    1
vs
inode_cache          313    784    480   97   98    1
The first was the 16M cached and the second was the 61M cached.

In both cases the root filesystem is mounted read-only. So I would think
it can't be a question of dirty pages. In one case the root filesystem
is nfs, and in the other it is a block device with an ext2 filesystem
on it.

Thanks--
Dave


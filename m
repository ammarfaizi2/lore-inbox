Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUFWWFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUFWWFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUFWWEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:04:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:12487 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbUFWWC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:02:56 -0400
Date: Wed, 23 Jun 2004 15:05:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [1/4] add __GFP_WIRED to pinned allocations
Message-Id: <20040623150546.4f66f941.akpm@osdl.org>
In-Reply-To: <0406231407.ZaHbZa1aIbIbKbZa3aHbLb3aYa2a3a5aWaIbWaKb2aYaKb4a4aHbIb3aLb5aHb2a342@holomorphy.com>
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com>
	<0406231407.ZaHbZa1aIbIbKbZa3aHbLb3aYa2a3a5aWaIbWaKb2aYaKb4a4aHbIb3aLb5aHb2a342@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> +#define __GFP_WIRED	0x8000	/* pinned */

This would be a nice thing to keep track of.

Isn't it the case that reclaimable slab pages (dentry, inode, mbcache,
dquot) should not be accounted as wired memory?  Could perhaps use
SLAB_RECLAIM_ACCOUNT for that.

It would need to be overridden for, say, sysfs inodes and dentries, but
they're about to become reclaimable anyway so no prob.

It would need to be overridden for, say, ramfs dentries and inodes though.

rd.c's blockdev pagecache pages are wired.

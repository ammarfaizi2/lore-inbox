Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUFWWl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUFWWl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUFWWhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:37:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:62172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263020AbUFWWdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:33:42 -0400
Date: Wed, 23 Jun 2004 15:36:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [1/4] add __GFP_WIRED to pinned allocations
Message-Id: <20040623153631.419f7474.akpm@osdl.org>
In-Reply-To: <20040623222221.GE1552@holomorphy.com>
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com>
	<0406231407.ZaHbZa1aIbIbKbZa3aHbLb3aYa2a3a5aWaIbWaKb2aYaKb4a4aHbIb3aLb5aHb2a342@holomorphy.com>
	<20040623150546.4f66f941.akpm@osdl.org>
	<20040623222221.GE1552@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Also, I should mention this concept is based on code seen in RHEL3,

What kernel is that?

> which uses a __GFP_WIRED flag, albeit for a different purpose (it
> appears to be centered around removing dirty ramfs pagecache from
> the LRU lists(s) as opposed to accounting for OOM-related reasons).

yes, putting ramfs, ramdisk and sysfs pages on the LRU is a bit silly.

However I think that taking a peek into mapping->backing_dev_info in
add_to_page_cache_lru(), __grab_cache_page() and wherever else would be a
tidier way of doing it.


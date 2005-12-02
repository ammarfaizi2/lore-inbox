Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVLBVnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVLBVnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVLBVnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:43:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750807AbVLBVnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:43:21 -0500
Date: Fri, 2 Dec 2005 13:44:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: mail@dirk-gerdes.de, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
 benchmarks
Message-Id: <20051202134431.005de2b2.akpm@osdl.org>
In-Reply-To: <1133558692.21429.89.camel@localhost.localdomain>
References: <1133443051.6110.32.camel@noti>
	<20051201172520.7095e524.akpm@osdl.org>
	<1133558692.21429.89.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Wondering, if this shrinks shared memory pages (since they are backed by
> tmpfs) ? (which is not what I want).

It'll reclaim unused pagecache pages.  What effect that has on
idioticfs^Wtmpfs pages depends on the state of the pages.  If they're
attached to tmpfs inodes then they won't be reclaimed because they have no
backing store.  If they're attached to swapcache then they won't be
reclaimed because they have no superblock.

So I guess you got lucky.

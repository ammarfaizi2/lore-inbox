Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbUCRRhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUCRRhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:37:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:1683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262800AbUCRRhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:37:18 -0500
Message-Id: <200403181737.i2IHbCE09261@mail.osdl.org>
Date: Thu, 18 Mar 2004 09:37:08 -0800 (PST)
From: markw@osdl.org
Subject: Re: 2.6.4-mm2
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040314172809.31bd72f7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I'm falling behind...  I see about a 10% decrease in throughput
with our dbt2 workload when comparing 2.6.4-mm2 to 2.6.3.  I'm wondering
if this might be a result of the changes to the pagecache, radix-tree
and writeback code since you mentioned it could affect i/o scheduling in
2.6.4-mm1.

PostgreSQL is using 8KB blocks and the characteristics of the i/o should
be that one lvm2 volume is experiencing mostly sequential writes, while
another has random reading and writing.  Both these volumes are using
ext2.  I'll summarize the throughput results here, with the lvm2 stripe
width varying across the columns:

kernel          16 kb   32 kb   64 kb   128 kb  256 kb  512 kb
2.6.3                           2308    2335    2348    2334
2.6.4-mm2       2028    2048    2074    2096    2082    2078

Here's a page with links to profile, oprofile, etc of each result:
	http://developer.osdl.org/markw/linux/2.6-pagecache.html

Comparing one pair of readprofile results, I find it curious that
dm_table_unplug_all and dm_table_any_congested show up near the top of a
2.6.4-mm2 profile when they haven't shown up before in 2.6.3.

Mark

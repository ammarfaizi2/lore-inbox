Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbUA0Aii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUA0Aii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:38:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:60059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265597AbUA0Aia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:38:30 -0500
Date: Mon, 26 Jan 2004 16:38:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: "John Stoffel" <stoffel@lucent.com>
Cc: stoffel@lucent.com, ak@muc.de, Valdis.Kletnieks@vt.edu, bunk@fs.tum.de,
       cova@ferrara.linux.it, eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 Hangs on boot (was: [patch] Re: Kernels > 2.6.1-mm3
 do not boot. - SOLVED)
Message-Id: <20040126163818.3ca49458.akpm@osdl.org>
In-Reply-To: <16405.44635.564011.414832@gargle.gargle.HOWL>
References: <200401232253.08552.eric@cisu.net>
	<200401251639.56799.cova@ferrara.linux.it>
	<20040125162122.GJ513@fs.tum.de>
	<200401251811.27890.cova@ferrara.linux.it>
	<20040125173048.GL513@fs.tum.de>
	<20040125174837.GB16962@colin2.muc.de>
	<200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
	<20040125191232.GC16962@colin2.muc.de>
	<16404.9520.764788.21497@gargle.gargle.HOWL>
	<20040125202557.GD16962@colin2.muc.de>
	<16404.10496.50601.268391@gargle.gargle.HOWL>
	<20040125220027.30e8cdf3.akpm@osdl.org>
	<16405.44635.564011.414832@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Stoffel" <stoffel@lucent.com> wrote:
>
> ...
> It hangs at the following spot:
> 
>    Linux version 2.6.2-rc2 (john@jfsnew) (gcc version 3.3.3 20040110
>    (prerelease) (Debian)) #2 SMP Mon Jan 26 09:17:00 EST 2004
>    BIOS-provided physical RAM map:
>     BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>     BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>     BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
>     BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
>     BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>     BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
>     BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
>    767MB LOWMEM available.
>    found SMP MP-table at 000fe710
>    hm, page 000fe000 reserved twice.
>    hm, page 000ff000 reserved twice.
>    hm, page 000f0000 reserved twice.
>    On node 0 totalpages: 196606
>      DMA zone: 4096 pages, LIFO batch:1
>      Normal zone: 192510 pages, LIFO batch:16
>      HighMem zone: 0 pages, LIFO batch:1
> 
> 
> Should I start adding in printks, or would it make sense to go back
> through the various 2.6.2-bk# snapshots looking for where the problem
> hit?

Adding printk's is a pretty quick-n-easy way of finding out where it is
getting stuck.  Just add

#define AAA() printk("%s:%d\n", __FILE__, __LINE__)

to kernel.h and sprinkle AAA()'s everywhere.  It takes a few iterations to
drill right down to the bug.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbTBFVH0>; Thu, 6 Feb 2003 16:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbTBFVHZ>; Thu, 6 Feb 2003 16:07:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:9423 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267394AbTBFVHV>;
	Thu, 6 Feb 2003 16:07:21 -0500
Date: Thu, 6 Feb 2003 13:16:40 -0800
From: Andrew Morton <akpm@digeo.com>
To: <niteowl@intrinsity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 kernel bugs
Message-Id: <20030206131640.2e668374.akpm@digeo.com>
In-Reply-To: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
References: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2003 21:16:52.0773 (UTC) FILETIME=[11CFAD50:01C2CE25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<niteowl@intrinsity.com> wrote:
>
> FWIW, here's a list of potential 2.5.59 kernel bugs.  Some of these
> might be causing real trouble. Many are probably benign.  A few may be
> non-bugs that are just poor coding style although I've tried to weed

I assume you picked these up with `gcc -W'?

gcc -W generates ten megabytes of warnings, with a few gems.  We really need
finer-grained control of gcc warnings so that the good ones can be turned on.
gcc warnings are being redone at present and this might yet happen...

> fs/super.c:313				if (!sb->s_op->sync_fs);

That's fixed in 2.5.59++

> net/ipv4/fib_hash.c:944			if (iter->zone->fz_next);

That too.  davem said "OMG that's scary :)"

> fs/hugetlbfs/inode.c:235		if (!super_block | (super_block->s_flags & MS_ACTIVE)) {

I'll fix that up.

As for the rest well gee.  Perhaps we should stick #error's in there to
flush out some people who can test the fixes.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268708AbTBZKlc>; Wed, 26 Feb 2003 05:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268709AbTBZKlc>; Wed, 26 Feb 2003 05:41:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:5063 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268708AbTBZKlb>;
	Wed, 26 Feb 2003 05:41:31 -0500
Date: Wed, 26 Feb 2003 02:52:16 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: jsherman@stuy.edu, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.5.63 - NULL pointer dereference in loop device
Message-Id: <20030226025216.114d4f2c.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302252059370.1430-100000@localhost.localdomain>
References: <20030224212530.GA631@j0nah.ath.cx>
	<Pine.LNX.4.44.0302252059370.1430-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2003 10:51:41.0504 (UTC) FILETIME=[0B9D4400:01C2DD85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Mon, 24 Feb 2003, Jonah Sherman wrote:
> 
> > I have come across a bug in the loop driver.  To reproduce this bug,
> > simply do:
> ...
> I can't reproduce this, and I don't understand it: please help me!

Well I can't make it happen either now.  It went pop first time I tried it
yesterday.

That being said, I can still trigger it by mmapping /dev/loop0 MAP_SHARED and
dirtying it all.  That triggers the problematic PF_MEMALLOC path much more easily.

	mem=256M
	losetup /dev/loop0 /dev/hda5
	usemem  -m 300 -f /dev/loop0
	<oops>

(gdb) p/x lo->lo_flags
$3 = 0x0

Userspace is passing in lo_encrypt_type == 0, so loop_init_xfer() never calls the transfer
init function.


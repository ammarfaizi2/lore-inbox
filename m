Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbTCOVy1>; Sat, 15 Mar 2003 16:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261606AbTCOVy1>; Sat, 15 Mar 2003 16:54:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:64143 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261601AbTCOVyY>;
	Sat, 15 Mar 2003 16:54:24 -0500
Date: Sat, 15 Mar 2003 14:03:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@muc.de>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from ext2's readdir
Message-Id: <20030315140318.657b70b7.akpm@digeo.com>
In-Reply-To: <m3adfwnvls.fsf@averell.firstfloor.org>
References: <m3vfyluedb.fsf@lexa.home.net.suse.lists.linux.kernel>
	<20030315023614.3e28e67b.akpm@digeo.com.suse.lists.linux.kernel>
	<m3adfwnvls.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 22:03:03.0610 (UTC) FILETIME=[A6A499A0:01C2EB3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> Andrew Morton <akpm@digeo.com> writes:
> 
> > foo_readdir()
> > {
> > 	loff_t pos = file->f_pos;
> >
> > 	....
> > 	<code which doesn't touch file->f_pos, but which modifies pos>
> > 	...
> >
> > 	file->f_pos = pos;
> > }
> 
> At least for alpha this will require an rmb_depends() between the read
> and the write. Probably on x86 an rmb() wouldn't hurt neither.
> 
> Otherwise there is no guarantee other CPUs see that intended memory 
> modification order
> 

Won't the atomic operations in down() and up() do that?

It's all a bit moot really.  If two user threads or processes are fighting
over the value of f_pos at the same time in this manner then they're buggy
anyway.  All we need to do here is to ensure that the kernel doesn't do
anything grossly wrong or insecure.


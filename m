Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbTAWJcZ>; Thu, 23 Jan 2003 04:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTAWJcZ>; Thu, 23 Jan 2003 04:32:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:48539 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265065AbTAWJcZ>;
	Thu, 23 Jan 2003 04:32:25 -0500
Date: Thu, 23 Jan 2003 01:41:45 -0800
From: Andrew Morton <akpm@digeo.com>
To: "dada1" <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strong kernel lock with linux-2.5.59 : futex in Huge Pages
Message-Id: <20030123014145.633b6517.akpm@digeo.com>
In-Reply-To: <00e201c2c2c0$838954c0$760010ac@edumazet>
References: <E18bd5l-000Duj-00@f16.mail.ru>
	<00e201c2c2c0$838954c0$760010ac@edumazet>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jan 2003 09:41:28.0788 (UTC) FILETIME=[9A985140:01C2C2C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"dada1" <dada1@cosmosbay.com> wrote:
>
> Hello
> 
> I found a way to lock a linux-2.5.59 in all cases, in using futexes landing
> in a HugeTLB page.
> 
> You need to be root to be able to obtain HugePages (or CAP_IPC_LOCK
> capability)
> 
> I suspect that the kernel/futex.c:__pin_page(unsigned long addr) or
> mm/memory.c:follow_page() are not HugeTLB page aware.
> 
> How you can reproduce it. (dont do it of course, unless you really want to
> debug the thing)

Yup, futexes and direct-io against hugepages are bust.  I was going to fix
that up this week, but got distracted.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUEYTxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUEYTxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUEYTvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:51:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:47258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265082AbUEYTrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:47:53 -0400
Date: Tue, 25 May 2004 12:47:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: joe.korty@ccur.com
Cc: markh@compro.net, linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-Id: <20040525124715.5f7e61b6.akpm@osdl.org>
In-Reply-To: <20040525142728.GA10738@tsunami.ccur.com>
References: <20031003214411.GA25802@rudolph.ccur.com>
	<40ADE959.822F1C23@compro.net>
	<20040521191326.58100086.akpm@osdl.org>
	<20040525142728.GA10738@tsunami.ccur.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> On Fri, May 21, 2004 at 07:13:26PM -0700, Andrew Morton wrote:
>  > Mark Hounschell <markh@compro.net> wrote:
>  > >
>  > > Joe Korty wrote:
>  > > > 
>  > > > 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
>  > > > the registers of an IO device will hang that process uninterruptibly.
>  > > > The task runs in an infinite loop in get_user_pages(), invoking
>  > > > follow_page() forever.
>  > > > 
>  > > > Using binary search I discovered that the problem was introduced
>  > > > in 2.5.14, specifically in ChangeSetKey
>  > > > 
>  > > >     zippel@linux-m68k.org|ChangeSet|20020503210330|37095
>  > > > 
>  > > 
>  > > I know this is an old thread but can anyone tell me if this problem is
>  > > resolved in the current 2.6.6 kernel? 
>  > > 
>  > 
>  > There's an utterly ancient patch in -mm which might fix this.
>  > 
>  > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm4/broken-out/get_user_pages-handle-VM_IO.patch
> 
>  [ 2nd send -- corporate email system in the throes of being scrambled / updated ]
> 
>  Andrew,
>  I have been using this patch for ages.  Any chance of it being forwared to
>  the official tree?

That patch had its first birthday last week.  I wrote it in response to
some long-forgotten problem, failed to changelog it at the time then forgot
why I wrote it.  I kept it in the hope that I'd remember why I wrote it.  I
subsequently wrote a best-effort changelog but am unconvinced by it.  Ho
hum.

Let me genuflect a bit.  I guess we can be reasonably confident it won't
break anything.

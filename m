Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265057AbUEVCRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbUEVCRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUEVCO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:14:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:5595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264992AbUEVCOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:14:03 -0400
Date: Fri, 21 May 2004 19:13:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: markh@compro.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-Id: <20040521191326.58100086.akpm@osdl.org>
In-Reply-To: <40ADE959.822F1C23@compro.net>
References: <20031003214411.GA25802@rudolph.ccur.com>
	<40ADE959.822F1C23@compro.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell <markh@compro.net> wrote:
>
> Joe Korty wrote:
> > 
> > 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
> > the registers of an IO device will hang that process uninterruptibly.
> > The task runs in an infinite loop in get_user_pages(), invoking
> > follow_page() forever.
> > 
> > Using binary search I discovered that the problem was introduced
> > in 2.5.14, specifically in ChangeSetKey
> > 
> >     zippel@linux-m68k.org|ChangeSet|20020503210330|37095
> > 
> 
> I know this is an old thread but can anyone tell me if this problem is
> resolved in the current 2.6.6 kernel? 
> 

There's an utterly ancient patch in -mm which might fix this.

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm4/broken-out/get_user_pages-handle-VM_IO.patch


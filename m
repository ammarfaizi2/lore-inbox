Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbTDKViB (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTDKViB (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:38:01 -0400
Received: from [12.47.58.73] ([12.47.58.73]:40170 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261665AbTDKViA (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:38:00 -0400
Date: Fri, 11 Apr 2003 14:49:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lockmeter 2.5] BKL with 51ms hold time, prove me wrong
Message-Id: <20030411144942.4934832d.akpm@digeo.com>
In-Reply-To: <34680000.1050084914@w-hlinder>
References: <46950000.1050023701@w-hlinder>
	<20030410185006.5fd88c30.akpm@digeo.com>
	<34680000.1050084914@w-hlinder>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 21:49:39.0227 (UTC) FILETIME=[4058BEB0:01C30074]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder <hannal@us.ibm.com> wrote:
>
> 
> Sure enough. I ported lockmeter to 2.5.67-mm1 and ran the same rmap-test
> and lo and behold all the ext3 issues went away. However, the one remaining
> long hold time moved to the top (unmap_vmas):

Ah, but the unmap_vmas lock was not kernel_flag, was it?  It'll be
page_table_lock.

That's OK I think.  The only time this is likely to bite anyone is if you
have a threaded application in which one thread it doing a massive munmap()
while another one is handling a pagefault, running mmap(), etc.  And given
that _establishing_ that large mapping in the first place takes tons of CPU,
the relative loss from the long hold time is small.

Famous last words.

> 
> Here is the port of lockmeter to the 2.5.67-mm1 kernel. If you would consider
> putting it in your tree that would be great and I would work on porting the
> rest of the architectures. 
> 
> http://prdownloads.sourceforge.net/lse/lockmeter1.5-2.5.67-mm1.patch?download

OK, that's pretty unintrusive.


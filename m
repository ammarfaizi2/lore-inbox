Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTLENFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 08:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTLENFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 08:05:31 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:17640 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S264106AbTLENFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 08:05:16 -0500
Date: Fri, 5 Dec 2003 14:05:20 +0100
From: Kristian Peters <kristian.peters@korseby.net>
To: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: oom killer in 2.4.23
Message-Id: <20031205140520.39289a3a.kristian.peters@korseby.net>
In-Reply-To: <Zbyn-23P-29@gated-at.bofh.it>
References: <Z6Iv-7O2-29@gated-at.bofh.it>
	<Z8Ag-3BK-3@gated-at.bofh.it>
	<Zbyn-23P-29@gated-at.bofh.it>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686 Linux 2.4.23-ck1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> schrieb:
> Marcelo asked me to to make it configurable at runtime so you could go
> in the deadlock prone stautus of 2.4.22 on demand, but I'm not going to
> add more features to 2.4 today unless they're blocker bugs (even if that
> would be simple to implement), actually it's not even my choice so don't
> ask me for that sorry.

Andrea, your vm does not work correctly in any cases.

It's so simple. I've tried to fill up my memory with that crappy khexedit that comes with kde2. You'll see how my memory fills with the contents of the whole file I load. When I have started 2 or 3 instances of khexedit my memory was nearly completely filled. Than I tried to start another khexedit (with a file that should nearly fit into memory), and the pain began.

See:

Dec  5 13:33:52 adlib kernel: __alloc_pages: 2-order allocation failed (gfp=0x1f0/0)
Dec  5 13:33:52 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:33:59 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:33:59 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:34:00 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec  5 13:34:01 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:34:02 adlib last message repeated 3 times

-------> kernel killed wmfire without saying

Dec  5 13:34:02 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:34:03 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:34:18 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:34:18 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:34:22 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:34:22 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:34:28 adlib last message repeated 3 times

-------> kernel killed xosview without mentioning

Dec  5 13:34:29 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:34:29 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:34:32 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:34:41 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec  5 13:34:41 adlib kernel: VM: killing process khexedit

-------> that was intended



Ok. That still is acceptable but when I tried to start mozilla, it got even worse:

Dec  5 13:37:26 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:37:27 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec  5 13:37:27 adlib kernel: VM: killing process mozilla-bin
Dec  5 13:37:27 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:37:27 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:37:28 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:37:30 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:37:30 adlib last message repeated 2 times
Dec  5 13:37:30 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:37:40 adlib last message repeated 3 times
Dec  5 13:37:56 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec  5 13:37:56 adlib kernel: VM: killing process mozilla-bin

-------> that was intended too
-------> but not the killing of another xosview and aterm

Dec  5 13:37:57 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:37:57 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec  5 13:37:58 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec  5 13:40:32 adlib kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec  5 13:40:32 adlib kernel: VM: killing process XFree86

-------> ouch ...


Ok. Could you please describe what your vm really does here in my specific case ?
Rick's old vm worked better. It'd have killed the task that had last allocated memory.

PS: If you need more details it should be no problem to do this again.

*Kristian


   _o)
   /\\
  _\_V


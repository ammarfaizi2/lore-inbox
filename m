Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263673AbUD0BM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUD0BM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 21:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbUD0BM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 21:12:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:53125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263673AbUD0BMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 21:12:53 -0400
Date: Mon, 26 Apr 2004 18:12:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 inode cache eats system, news at 11
Message-Id: <20040426181235.2b5b62c8.akpm@osdl.org>
In-Reply-To: <20040426171856.22514.qmail@lwn.net>
References: <20040426171856.22514.qmail@lwn.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote:
>
>  One of the remaining bits of weirdness with my x86_64 system has been that
>  I often find it unresponsive in the morning; it's harder to get out of bed
>  than my middle-school son.  Some things happen (the pointer moves in
>  response to the mouse) but everything on the system seems asleep.  Very
>  little disk activity happens.  Eventually, usually, the system comes back
>  to life, but that can take 15-30 minutes.
> 
>  I've managed to correlate this behavior with processes which read through
>  the whole disk.  The nightly updatedb run is the worst offender, but a full
>  backup of the disk can do it as well.
> 
>  A look at /proc/meminfo (appended below) shows that the bulk of main memory
>  is taken up by the slab cache.  I'll append a full slabinfo listing as
>  well, but two things stand out:
> 
>  ext3_inode_cache  488356 488978   1128    7    2 

                                                 ^^^

It's that 1-order allocation which is causing the problem.  I thought we'd
beaten this behaviour out of the slab code but it seems not.



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/broken-out/slab-order-0-for-vfs-caches.patch

is not a completely happy solution, but it should fix things up.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbTFFHIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbTFFHIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:08:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32850 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265367AbTFFHIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:08:42 -0400
Date: Fri, 6 Jun 2003 00:22:25 -0700
From: Andrew Morton <akpm@digeo.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5.70-bk10 oops when trying to mount root from raid-1 device
Message-Id: <20030606002225.5aba2572.akpm@digeo.com>
In-Reply-To: <3EE03F64.70501@aitel.hist.no>
References: <3EE03F64.70501@aitel.hist.no>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2003 07:22:15.0343 (UTC) FILETIME=[5AE843F0:01C32BFC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> 2.5.70-bk10 has some raid fixes, but raid-1 still fails unlike
> 2.5.70-mm4.
> 
> bk10 successfully discovers raid-1 and raid-0 arrays,
> but this happens when the kernel tries to mount root:
> 
> <lots of ordinary boot messages>
> md ... autorun DONE
> <this is where I normally get VFS: Mounted root (ext2 filesystem) readonly.
>   I got this instead:>
> unable to handle kernel paging request at 5a5a5a86


This is "use of uninitialised memory".  0x6b6b6b6b is "use of freed memory".

It's supposed to be that way in Linus's tree too, but I screwed it up.

> EIP at put_all_bios+0x047/0x80

I'd be suspecting that the write_bios[] array isn't being memset somewhere.

                struct bio **bio = r1_bio->write_bios + i;



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTEWJsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTEWJsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:48:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:60443 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263996AbTEWJsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:48:06 -0400
Date: Fri, 23 May 2003 03:04:09 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
Message-Id: <20030523030409.664c9b3a.akpm@digeo.com>
In-Reply-To: <20030523.024922.118612798.davem@redhat.com>
References: <20030522151156.C12171@flint.arm.linux.org.uk>
	<1053676924.30675.2.camel@rth.ninka.net>
	<20030523021204.4e3a4954.akpm@digeo.com>
	<20030523.024922.118612798.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 10:01:12.0289 (UTC) FILETIME=[3D963D10:01C32112]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
>    From: Andrew Morton <akpm@digeo.com>
>    Date: Fri, 23 May 2003 02:12:04 -0700
>    
>    install_page() is prefaulting pages into pagetables, so perhaps it should
>    have an update_mmu_cache()?
> 
> I agree.  Someone should take a close look at the do_file_page()
> code paths to make sure that's still kosher after such a change.

What would one be looking for?  I don't know what the sideeffects of
update_mmu_cache() might be.

It looks to be the same as do_no_page() though: the update_mmu_cache() is
the last substantive thing which happens in the fault or the syscall.


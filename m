Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269899AbUJNDWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269899AbUJNDWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 23:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269948AbUJNDWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 23:22:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:54206 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269899AbUJNDWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 23:22:32 -0400
Date: Wed, 13 Oct 2004 20:20:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Scott <nathans@sgi.com>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-xfs@oss.sgi.com
Subject: Re: Page cache write performance issue
Message-Id: <20041013202041.2e7066af.akpm@osdl.org>
In-Reply-To: <20041014005300.GA716@frodo>
References: <20041013054452.GB1618@frodo>
	<20041012231945.2aff9a00.akpm@osdl.org>
	<20041013063955.GA2079@frodo>
	<20041013000206.680132ad.akpm@osdl.org>
	<20041013172352.B4917536@wobbly.melbourne.sgi.com>
	<416CE423.3000607@cyberone.com.au>
	<20041013013941.49693816.akpm@osdl.org>
	<20041014005300.GA716@frodo>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>
> On Wed, Oct 13, 2004 at 01:39:41AM -0700, Andrew Morton wrote:
>  > Nick Piggin <piggin@cyberone.com.au> wrote:
>  > >
>  > >  Andrew probably has better ideas.
>  > 
>  > uh, is this an ia32 highmem box?
> 
>  Yep, it is.
> 
>  > If so, you've hit the VM sour spot.
>  > ...
>  > Basically, *any* other config is fine.  896MB and below, 1.5GB and above.
> 
>  I just tried switching CONFIG_HIGHMEM off, and so running the
>  machine with 512MB; then adjusted the test to write 256M into
>  the page cache, again in 1K sequential chunks.  A similar mis-
>  behaviour happens, though the numbers are slightly better (up
>  from ~4 to ~6.5MB/sec).  Both ext2 and xfs see this.  When I
>  drop the file size down to 128M with this kernel, I see good
>  results again (as we'd expect).

No such problem here, with

	dd if=/dev/zero of=x bs=1k count=128k

on a 256MB machine.  xfs and ext2.

Can you exhibit this one more than one machine?

Silly question: what does `grep sync' /etc/fstab say over there? ;)

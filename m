Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTJMJV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTJMJV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:21:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:7644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbTJMJV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:21:26 -0400
Date: Mon, 13 Oct 2003 02:24:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] No swapping on memory backed swapfiles
Message-Id: <20031013022441.79c800b6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0310130502440.28426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0310130354440.28426@montezuma.fsmlabs.com>
	<20031013011117.103de5e7.akpm@osdl.org>
	<Pine.LNX.4.53.0310130502440.28426@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> On Mon, 13 Oct 2003, Andrew Morton wrote:
> 
> > Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> > >
> > > +	bdi = mapping->backing_dev_info;
> > >  +	if (bdi->memory_backed)
> > >  +		goto bad_swap;
> > >  +
> > 
> > I guess that makes sense, although someone might want to swap onto a
> > ramdisk-backed file just for some testing purpose.
> > 
> > Why not simply test for a null ->readpage()?
> 
> That was my initial intention, but then i wondered why someone would be 
> swapping to a memory backed filesystem in the first place. Also things 
> like ramfs have ->readpage().

A non-memory-backed fs may still have a NULL ->readpage though (ncpfs?).

I do think it best to just test for ->readpage, and give the user the extra
rope.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUBKUjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUBKUjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:39:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:59108 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266189AbUBKUjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:39:33 -0500
Date: Wed, 11 Feb 2004 12:39:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: jamie@shareable.org, viro@math.psu.edu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: open-scale-2.6.2-A0
Message-Id: <20040211123914.7372625d.akpm@osdl.org>
In-Reply-To: <20040211122753.GA15129@elte.hu>
References: <20040211115828.GA13868@elte.hu>
	<20040211122031.GC15127@mail.shareable.org>
	<20040211122753.GA15129@elte.hu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Jamie Lokier <jamie@shareable.org> wrote:
> 
> > Ingo Molnar wrote:
> > > i've attached an obvious scalability improvement for write()s. We in
> > > essence used a system-global lock for every open(WRITE) - argh!
> > 
> > I wonder if the "rip the second arsehole" is there for a reason.
> 
> these days i dont think the comment is justified.

It was kinda funny though.

> > Does this scalability improvement make any measured difference in any
> > conceivable application, or is it just making struct inode larger?
> 
> i've not added any new lock, i'm merely reusing the existing ->i_lock. 
> So there's no data or code bloat whatsoever.

yes, that's why I called it i_lock and not i_blocks_lock.  i_lock's mandate
is "an innermost lock for protecting stuff in the inode".  This is an
appropriate use of it.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbTJORub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTJORua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:50:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:18377 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263816AbTJORuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:50:17 -0400
Date: Wed, 15 Oct 2003 10:53:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ben Collins <bcollins@debian.org>
Cc: kakadu_croc@yahoo.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7-mm1
Message-Id: <20031015105359.31c016c3.akpm@osdl.org>
In-Reply-To: <20031015174047.GE971@phunnypharm.org>
References: <20031015032215.58d832c1.akpm@osdl.org>
	<20031015123444.46223.qmail@web40904.mail.yahoo.com>
	<20031015102810.4017950f.akpm@osdl.org>
	<20031015174047.GE971@phunnypharm.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> wrote:
>
> > highlevel_add_host() does read_lock() and then proceeds to do things like
>  > starting kernel threads under that lock.  The locking is pretty broken
>  > in there :(
> 
>  No, highlevel_add_host() itself doesn't start any threads. But it does
>  pass around data that needs to be locked from changes, and one of the
>  handlers happens to start a thread, and other things allocate memory
>  (such as this case).
> 
>  It's ugly, and I've been trying to clean it up. This case can be fixed
>  quickly with a simple check in hpsb_create_hostinfo() to pass GFP_ATOMIC
>  to kmalloc.

nodemgr_add_host() looks like the hard one.  Maybe make hl_drivers_lock a
sleeping lock?

>  My problem right now, is I don't use any architectures that support
>  preempt, so I don't see a lot of these problems, like I catch with
>  CONFIG_SMP.

Anton had a ppc64 patch which implemented the preempt_count beancounting
without actually implementing premption.  So might_sleep() does the right
thing.


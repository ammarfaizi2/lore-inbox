Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267636AbUBTGrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267667AbUBTGrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:47:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:55938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267636AbUBTGrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:47:40 -0500
Date: Thu, 19 Feb 2004 22:47:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: report NGROUPS_MAX via a sysctl (read-only)
Message-Id: <20040219224752.44da2712.akpm@osdl.org>
In-Reply-To: <20040220063519.GP9155@sun.com>
References: <20040220023927.GN9155@sun.com>
	<20040219213028.42835364.akpm@osdl.org>
	<20040220063519.GP9155@sun.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> On Thu, Feb 19, 2004 at 09:30:28PM -0800, Andrew Morton wrote:
> > >  Attached is a simple patch to expose NGROUPS_MAX via sysctl.
> > 
> > Why does userspace actually care?  You try to do an oversized setgroups(),
> > so you get an error?
> 
> I am systematically tracking down apps that use it.  glibc is almost free of
> it.  sysconf() still uses it, but as long as the value compiled into glibc
> as NGROUPS_MAX is less-than-or-equal-to the current kernel's idea, it meets
> POSIX, right?  If any one goes into their kernel source and lowers
> NGROUPS_MAX they might break things, but I guess that isn't too big of a
> worry.  Some apps are still assuming that the value they get from sysconf()
> is the absolute max number of groups.  Anyone with libc compiled against an
> older kernel will see 32, when they could have 64k.

OK, well certainly fishing the number out of the currently-running kernel
is the one sure way of getting it right.

> > And why does NGROUPS_MAX still exist, come to that?  AFAICT the only thing
> 
> Because Linus would not let me set it to INT_MAX. Something about
> "insanity" ;)

Is 64k enough?


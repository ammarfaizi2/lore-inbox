Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUBFJOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUBFJOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:14:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:27584 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265291AbUBFJOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:14:36 -0500
Date: Fri, 6 Feb 2004 01:16:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt <dirtbird@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-Id: <20040206011630.42ed5de1.akpm@osdl.org>
In-Reply-To: <402359E1.6000007@ntlworld.com>
References: <402359E1.6000007@ntlworld.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt <dirtbird@ntlworld.com> wrote:
>
> > Werner Almesberger <wa@almesberger.net> wrote:
> >>
> >> "[...] read( ) [...] shall be atomic with respect to each other
> >>   in the effects specified in IEEE Std. 1003.1-200x when they
> >>   operate on regular files. If two threads each call one of these
> >>   functions, each call shall either see all of the specified
> >>   effects of the other call, or none of them."
> 
> > Whichever thread finishes its read last gets to update f_pos.
> 
> > I'm struggling a bit to understand what they're calling for there.  If
> > thread A enters a read and then shortly afterwards thread B enters the
> > read, does thread B see an f_pos which starts out at the beginning of A's
> > read, or the end of it?
> 
> > Similar questions apply as the threads exit their read()s.
> 
> > Either way, there's no way in which we should serialise concurrent readers.
> > That would really suck for sensible apps which are using pread64().
> 
> Surely, we can just serialise read() (and related) calls that modify f_pos?
> Since pread() doesn't modify f_pos we shouldn't need to serialise those calls
> no? Also doesn't spec make the same claims about other calls that modify
> f_pos such as write()?

We could do somethnig like that.

But is there any application in which two threads simultaneously perform
read() against the same fd which is not already buggy?


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUCaA0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbUCaA0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:26:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:4738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbUCaA0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:26:37 -0500
Date: Tue, 30 Mar 2004 16:28:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
Message-Id: <20040330162850.50a0fad4.akpm@osdl.org>
In-Reply-To: <20040331000301.GB9269@kroah.com>
References: <20040330023437.72bb5192.akpm@osdl.org>
	<20040331000301.GB9269@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Tue, Mar 30, 2004 at 02:34:37AM -0800, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm1/
> > 
> > - Dropped the tty locking fix.  As predicted, it deadlocked.  I also
> >   reverted the patch from bk-driver-core.patch which is causing this race to
> >   trigger more frequently.
> 
> Argh, so the only way I'm going to be able to get my little, tiny,
> simple vc class patch is by fixing all of the tty layer locking code?

Well the good news is that my test box now oopses on about 2-out-of-3 boot
attempts.  But that gets tiresome.

> Ugh, that's so mean...  :)

Optimistic, too.

I'm thinking that this can be fixed from the other direction: just before
release_dev() calls close (dropping BKL), if tty->count==1, make the
going-away tty ineligible for concurrent lookups.  Do that by setting
tty->driver->ttys[idx] to NULL.  Maybe.

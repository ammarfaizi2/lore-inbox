Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUDOUCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUDOUCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:02:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:45449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262468AbUDOUCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:02:38 -0400
Date: Thu, 15 Apr 2004 13:02:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mq_open() honor leading slash
Message-ID: <20040415130236.I21045@build.pdx.osdl.net>
References: <20040415113951.G21045@build.pdx.osdl.net> <20040415192735.GO31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040415192735.GO31589@devserv.devel.redhat.com>; from jakub@redhat.com on Thu, Apr 15, 2004 at 03:27:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jakub Jelinek (jakub@redhat.com) wrote:
> On Thu, Apr 15, 2004 at 11:39:51AM -0700, Chris Wright wrote:
> > Patch below simply eats all leading slashes before passing name to
> > lookup_one_len() in mq_open() and mq_unlink().
> 
> glibc already strips the leading slash in userland.

Ah, OK.  I'm just using the kernel interfaces directly.

> If you want to do it in the kernel instead, it shouldn't IMHO be silent if it
> doesn't see a leading slash or sees more than one. I.e.
> 	error = -EINVAL;
> 	if (name[0] != '/')
> 		goto out_err;

Given it's implementation defined what happens w/out leading slash, I
see no trouble with allowing names w/out leading slashes to be looked
up as well as names with leading slash (in kernel rather than glibc).
But I don't feel strongly either way.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

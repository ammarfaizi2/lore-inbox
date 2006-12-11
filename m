Return-Path: <linux-kernel-owner+w=401wt.eu-S1762699AbWLKJlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762699AbWLKJlG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762702AbWLKJlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:41:06 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:44036 "EHLO
	liaag2af.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762699AbWLKJlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:41:03 -0500
Date: Mon, 11 Dec 2006 04:33:00 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't
  mounted
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200612110436_MC3-1-D49E-FE59@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061211005557.04643a75.akpm@osdl.org>

On Mon, 11 Dec 2006 00:55:57 -0800, Andrew Morton wrote:

> > Prevent oops when an app tries to create a pipe while pipefs
> > is not mounted.
> 
> That's pretty lame.  It means that pipes just won't work, so people who are
> using pipes in their initramfs setups will just get mysterious failures
> running userspace on a crippled kernel.

I know, I just wanted to keep the issue alive. :)

> I think the bug really is the running of populate_rootfs() before running
> the initcalls, in init/main.c:init().  It's just more sensible to start
> running userspace after the initcalls have been run.  Statically-linked
> drivers which want to load firmware files will lose.  To fix that we'd need
> a new callback.  It could be with a new linker section or perhaps simply a
> notifier chain.

Why not create a new initcall category for things that must run before
early userspace?

-- 
MBTI: IXTP


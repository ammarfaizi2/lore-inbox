Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWHTOgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWHTOgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 10:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHTOgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 10:36:35 -0400
Received: from mother.openwall.net ([195.42.179.200]:64959 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750804AbWHTOge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 10:36:34 -0400
Date: Sun, 20 Aug 2006 18:32:35 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
Message-ID: <20060820143235.GA19543@openwall.com>
References: <20060819234629.GA16814@openwall.com> <20060820072148.GB306@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820072148.GB306@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 09:21:48AM +0200, Willy Tarreau wrote:
> I still remembered this problem being discussed, and finally found
> the thread :
> 
>   http://lkml.org/lkml/2003/11/14/55

I was not aware that this had been discussed before.  Bernhard (in the
old LKML posting above) seems to imply that having kernel_thread()
itself not fail on ptrace would be a sufficient fix, which I don't agree
with.  There may be other reasons for kernel_thread() to fail, such as
the kernel running out of resources; with OpenVZ, kernel_thread() is not
allowed from within VEs.

> In fact, no code was proposed and 2.6 got fixed later, then stopped
> using kernel_thread() so nearly nobody might have noticed it :
> 
>   http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=3e88c17d404c5787afd5bd1763380317f5ccbf84;hp=22e6c1b39c648850438decd491f62d311800c7db

I'm afraid that this does not properly clean things up on error.  I just
had a look at linux-2.6.17.9/drivers/block/loop.c - it still uses
kernel_thread() and has the same "goto out_putf" on error return from
kernel_thread(), which appears to not clean things up.

Alexander

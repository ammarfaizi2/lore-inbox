Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUBRAPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUBRAPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:15:40 -0500
Received: from dp.samba.org ([66.70.73.150]:2500 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266826AbUBRAOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:14:41 -0500
Date: Tue, 17 Feb 2004 18:37:49 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ian Kent <raven@themaw.net>
Cc: ia6432@inbox.ru, linux-kernel@vger.kernel.org, autofs@linux.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] nfs or autofs related hangs
Message-Id: <20040217183749.490777c5.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.58.0402160910300.28358@wombat.indigo.net.au>
References: <20040215222107.7E4382C2D8@lists.samba.org>
	<Pine.LNX.4.58.0402160910300.28358@wombat.indigo.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 09:13:55 +0800 (WST)
Ian Kent <raven@themaw.net> wrote:

> On Sun, 15 Feb 2004, Rusty Russell wrote:
> > Is this __cacheline_aligned_in_smp really required?
> 
> I must admit I put this together without much thought with a "cut and 
> paste".
> 
> But, please tell me. I'm not entirely clear on what conditions I 
> should be concerned about blowing the cache.

You should usually try to declare the spinlock near the things it protects, in
the hope that they'll be in the same cacheline.  If we blow 128 bytes for
every spinlock, things will get slower, not faster.

ie. like any optimization, the default should be not to do it unless there's
a reason[1]

Cheers,
Rusty.
[1] An optimization being defined here as something with tradeoffs.
    Doing the obviously superior thing is not an optimization, it's simply
    being a decent coder.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265678AbSJXWtr>; Thu, 24 Oct 2002 18:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265697AbSJXWtr>; Thu, 24 Oct 2002 18:49:47 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:2317 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S265678AbSJXWtq>; Thu, 24 Oct 2002 18:49:46 -0400
Date: Thu, 24 Oct 2002 23:56:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: cmm@us.ibm.com, <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>,
       <dipankar@in.ibm.com>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH]updated ipc lock patch
In-Reply-To: <3DB87458.F5C7DABA@digeo.com>
Message-ID: <Pine.LNX.4.44.0210242342460.1169-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Andrew Morton wrote:
> mingming cao wrote:
> > 
> > Hi Andrew,
> > 
> > Here is the updated ipc lock patch:
> 
> Well I can get you a bit of testing and attention, but I'm afraid
> my knowledge of the IPC code is negligible.
> 
> So to be able to commend this change to Linus I'd have to rely on
> assurances from people who _do_ understand IPC (Hugh?) and on lots
> of testing.
> 
> So yes, I'll include it, and would solicit success reports from
> people who are actually exercising that code path, thanks.

Manfred and I have both reviewed the patch (or the 2.5.44 version)
and we both recommend it highly (well, let Manfred speak for himself).

I can't claim great expertise on IPC (never on msg, but some on shm and
sem), but (unless there's an error we've missed) there's no change to
IPC functionality here - it's an exercise in "self-evidently" better
locking (there used to be just one spinlock covering all e.g. sems),
with RCU to avoid the dirty cacheline bouncing in earlier version.

And I rarely exercise IPC paths, except when testing if I change
something: I do hope someone else can vouch for it in practice,
we believe Mingming has devised a fine patch here.

Hugh


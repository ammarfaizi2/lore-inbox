Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131145AbRCGSXh>; Wed, 7 Mar 2001 13:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131144AbRCGSXX>; Wed, 7 Mar 2001 13:23:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29958 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131143AbRCGSXC>; Wed, 7 Mar 2001 13:23:02 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Hashing and directories
Date: 7 Mar 2001 10:21:56 -0800
Organization: Transmeta Corporation
Message-ID: <985u84$2ku$1@penguin.transmeta.com>
In-Reply-To: <000201c0a71f$3a48fae0$5517fea9@local> <20010307171020.A10607@pcep-jamie.cern.ch> <003701c0a722$f6b02700$5517fea9@local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <003701c0a722$f6b02700$5517fea9@local>,
Manfred Spraul <manfred@colorfullife.com> wrote:
>
>exec_mmap currenly avoids mm_alloc()/activate_mm()/mm_drop() for single
>threaded apps, and that would become impossible.
>I'm not sure how expensive these calls are.

They aren't that expensive: activate_mm() needs to flush the TLB, but we
do that anyway in the re-use case too, so on the whole the expense is
limited to having to do the extra allocation.

That expense might be at least partially offset by being able to do some
things more simply - right now the mm re-use case actually has to be
more careful than I really like for security and protection reasons, for
example.  We've had bugs in this area before - simplifying it would be
nice.  And it also gets rid of the special cases. 

I don't think the patches to do this should be all that huge, but who
knows? It's not a trivial part of the kernel.

		Linus

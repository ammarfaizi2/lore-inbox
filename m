Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284705AbRLEUt4>; Wed, 5 Dec 2001 15:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284704AbRLEUtr>; Wed, 5 Dec 2001 15:49:47 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:64267 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284703AbRLEUtd>; Wed, 5 Dec 2001 15:49:33 -0500
Date: Wed, 5 Dec 2001 13:00:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct + kernel stack colouring ...
In-Reply-To: <3C0E84B4.1070808@colorfullife.com>
Message-ID: <Pine.LNX.4.40.0112051257230.1644-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Manfred Spraul wrote:

> Davide Libenzi wrote
>
> >
> >
> >By adding three bits of colouring you're going to cut the collision of
> >about 1/8.
> >
> No, Shuji is right:
> You have just shifted the problem, without reducing collisions.
> 256 kB, 4 way cache with 32 byte linesize.
>
> cacheline == bits 15..5
> offset within cacheline: bits 4..0
>
> The colouring must depend on more than just bits 13 to 15 - if these
> bits are different, then the access goes into a different line even
> without colouring, there won't be a collision.

Yep, damn true, using 13..15 I'll get "vertical" shift that is already
implicit.
In that case we need a more deep knowledge of the cache architecture like
size and associativity.




- Davide



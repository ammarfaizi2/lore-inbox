Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287116AbSABWoy>; Wed, 2 Jan 2002 17:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287101AbSABWoo>; Wed, 2 Jan 2002 17:44:44 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:19984 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287116AbSABWog>; Wed, 2 Jan 2002 17:44:36 -0500
Date: Wed, 2 Jan 2002 14:48:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Peter Osterlund <petero2@telia.com>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] scheduler fixups ...
In-Reply-To: <m28zbgpeqf.fsf@pengo.localdomain>
Message-ID: <Pine.LNX.4.40.0201021438500.1034-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Jan 2002, Peter Osterlund wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
>
> > a still lower ts
>
> This also lowers the effectiveness of nice values. In 2.5.2-pre6, if I
> run two cpu hogs at nice values 0 and 19 respectively, the niced task
> will get approximately 20% cpu time (on x86 with HZ=100) and this
> patch will give even more cpu time to the niced task. Isn't 20% too
> much?

The problem is that with HZ == 100 you don't have enough granularity to
correctly scale down nice time slices. Shorter time slices helps the
interactive feel that's why i'm pushing for this. Anyway i'm currently
running experiments with 30-40ms time slices. Another thing to remember is
that cpu hog processes will sit at dyn_prio 0 while processes like for
example gcc during a kernel build will range between 5-8 to 36 and in this
case their ts is actually doubled by the fact that they can require
another extra ts. For all processes that does not sit at dyn_prio 0 ( 90%
) the nice tasks cpu time is going to be half.




- Davide



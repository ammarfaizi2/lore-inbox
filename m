Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284073AbRLRPdP>; Tue, 18 Dec 2001 10:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283876AbRLRPc4>; Tue, 18 Dec 2001 10:32:56 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:2321 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S282941AbRLRPct>; Tue, 18 Dec 2001 10:32:49 -0500
To: Kurt Roeckx <Q@ping.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait() and strace -f
In-Reply-To: <20011218021407.A1595@ping.be>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 19 Dec 2001 00:32:33 +0900
In-Reply-To: <20011218021407.A1595@ping.be>
Message-ID: <87itb4v90u.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Roeckx <Q@ping.be> writes:

> int     main()
> {
>         int     i;
> 
>         if (!fork())
>         {
>                 /* Child 1. */
>                 return 0;
>         }
> 
>         if (!fork())
>         {
>                 /* Child 2. */
>                 sleep(10);
>                 return 0;
>         }
> 
>         /* Parent. */
>         sleep(1);
>         wait(&i);
>         return 0;
> }
> 
> Without strace -f, this program stops after 1 second and the
> second child still lives for 9 seconds.  With strace -f this
> program stops after 10 second after the second child died.
> 
> I think it's related to strace being the "real" parent of the
> child.  But that doesn't really explain why I need 2 childs.

Probably, it's feature (or bug) of strace. If the trace process has
child, trace of a child is continued before wait() of parent. Then,
exit() of the child process continue wait() of parent.

>         if (!fork())
>         {
>                 /* Child 1. */
		  sleep(2);
>                 return 0;
>         }

The above continued the parent after 2 seconds.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

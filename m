Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318319AbSHEGem>; Mon, 5 Aug 2002 02:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318320AbSHEGem>; Mon, 5 Aug 2002 02:34:42 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:25996 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S318319AbSHEGel>; Mon, 5 Aug 2002 02:34:41 -0400
Message-Id: <5.1.0.14.2.20020805163418.02d69248@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Aug 2002 16:37:37 +1000
To: torvalds@transmeta.com (Linus Torvalds)
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating
  user mode linux]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ail2qh$bf0$1@penguin.transmeta.com>
References: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk>
 <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain>
 <m3u1mb5df3.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:35 AM 5/08/2002 +0000, Linus Torvalds wrote:
> >Linux got a lot slower in signal delivery when the SSE2 support was
> >added. That got this speed back.
>
>This will break _horribly_ when (if) glibc starts using SSE2 for things
>like memcpy() etc.
>
>I agree that it is really sad that we have to save/restore FP on
>signals, but I think it's unavoidable. Your hack may work for you, but
>it just gets really dangerous in general. having signals randomly
>subtly corrupt some SSE2 state just because the signal handler uses
>something like memcpy (without even realizing that that could lead to
>trouble) is bad, bad, bad.

how about putting the onus on userspace to tell the kernel if/when it uses 
extensions that require FP state to be saved/restored?
if/when glibc starts using SSE2, it could then use these extensions.

could be as simple as user-space setting some bit somewhere.

>And yes, this signal handler thing is clearly visible on benchmarks.
>MUCH too clearly visible.  I just didn't see any safe alternatives
>(and I still don't ;( )

it probably isn't worthwhile penalising all users of signal just for those 
few userspace apps that actually do use SSE2.


cheers,

lincoln.


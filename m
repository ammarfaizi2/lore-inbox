Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSLQSk7>; Tue, 17 Dec 2002 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSLQSk7>; Tue, 17 Dec 2002 13:40:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44050 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265385AbSLQSk6>; Tue, 17 Dec 2002 13:40:58 -0500
Date: Tue, 17 Dec 2002 10:49:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ulrich Drepper <drepper@redhat.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <1040153030.20804.8.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212171046550.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 Dec 2002, Alan Cox wrote:
>
> Is there any reason you can't just keep the linker out of the entire
> mess by generating
>
> 	.byte whatever
> 	.dword 0xFFFF0000
>
> instead of call ?

Alan, the problem is that there _is_ no such instruction as a "call
absolute".

There is only a "call relative" or "call indirect-absolute". So you either
have to indirect through memory or a register, or you have to fix up the
call at link-time.

Yeah, I know it sounds strange, but it makes sense. Absolute calls are
actually very unusual, and using relative calls is _usually_ the right
thing to do. It's only in cases like this that we really want to call a
specific address.

			Linus


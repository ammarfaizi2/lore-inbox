Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313731AbSEIQDC>; Thu, 9 May 2002 12:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSEIQDB>; Thu, 9 May 2002 12:03:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2061 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313731AbSEIQDB>; Thu, 9 May 2002 12:03:01 -0400
Date: Thu, 9 May 2002 09:02:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug CPU prep II: CLONE_IDLETASK
In-Reply-To: <E175jNV-0007W9-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205090900270.2630-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 May 2002, Rusty Russell wrote:
>
> This changes CLONE_PID ("if my pid is 0, copy it") to CLONE_IDLETASK
> ("if I have CAP_SYS_MODULE, set child's pid to zero").

The "CAP_SYS_MODULE" thing needs to change, I think.

We simply cannot allow user-space to do this AT ALL, even root by mistake.

Sure, root can do other damage, but we should never allow root to do
things that simply cannot make sense from an internal consistency
standpoint.

Suggested approach:
 - remove the CAP_SYS_MODULE etc checking altogether
 - make sys_clone() just always mask that bit off.

Ok?

		Linus


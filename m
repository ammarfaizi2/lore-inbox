Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292990AbSCAAaV>; Thu, 28 Feb 2002 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292520AbSCAA2L>; Thu, 28 Feb 2002 19:28:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14855 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310276AbSCAAUu>; Thu, 28 Feb 2002 19:20:50 -0500
Date: Thu, 28 Feb 2002 16:20:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: thread groups bug? 
In-Reply-To: <15283.1014933475@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0202281616510.31454-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Feb 2002, David Howells wrote:
> 
> Except that the execve() _can_ (a) change the TGID and (b) result in two
> effective thread groups of the same TGID as far as the kernel is concerned.

You're right. I did that for security reasons - making sure that nobody 
can execve a suid application and then keep on sending signals to it under 
the auspices of thread groups. I'd forgotten about that thing.

Maybe killing the other threads on execve _is_ the right thing after all, 
if that also gives us POSIX behaviour.

Who actually maintains the pthread library? I don't think they use 
CLONE_THREAD at all yet, right?

		Linus


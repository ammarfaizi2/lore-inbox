Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291085AbSBGCsL>; Wed, 6 Feb 2002 21:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291087AbSBGCsC>; Wed, 6 Feb 2002 21:48:02 -0500
Received: from ns.suse.de ([213.95.15.193]:47374 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291085AbSBGCrt>;
	Wed, 6 Feb 2002 21:47:49 -0500
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <E16Ydys-0007D6-00@the-village.bc.nu.suse.lists.linux.kernel> <Pine.LNX.4.44.0202062101390.4832-100000@age.cs.columbia.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Feb 2002 03:47:48 +0100
In-Reply-To: Ion Badulescu's message of "7 Feb 2002 03:13:54 +0100"
Message-ID: <p73zo2mqa7f.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu <ionut@cs.columbia.edu> writes:
> I'll state again: if data (UDP or otherwise) is lost after sendto() 
> returns success but before it hits the wire, something is BROKEN in that 
> IP stack.

Your proposal would break select(). It would require UDP sendmsg to block
when the TX queue is full. Most applications using select do
not send the socket non blocking. If they select for writing and the 
kernel signals the socket writable they expect not to block in the write. 
As long as the only thing controlling the blocking is the per socket
send buffer that works out as long as the application is careful enough
not to fill its send buffer. If you would put the TX queue into the 
blocking equation too this cannot be guaranteed anymore because the TX queue
is shared between all local processes and even forwarding. You would
get random blocking on select based applications, breaking them.

I BTW had a proposal for blocking the sender in TX some time ago but it was
luckily shot down by people who knew better than me. 

-Andi

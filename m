Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280812AbRKBTxa>; Fri, 2 Nov 2001 14:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280813AbRKBTxU>; Fri, 2 Nov 2001 14:53:20 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:16392 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S280812AbRKBTxR>; Fri, 2 Nov 2001 14:53:17 -0500
Date: Fri, 2 Nov 2001 21:53:13 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Doug McNaught <doug@wireboard.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need blocking /dev/null
Message-ID: <20011102215312.Q1504@niksula.cs.hut.fi>
In-Reply-To: <m31yjjz6ws.fsf@belphigor.mcnaught.org> <Pine.LNX.4.21.0111012322310.14742-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0111012322310.14742-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Thu, Nov 01, 2001 at 11:51:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 11:51:39PM +0000, you [Riley Williams] claimed:

  (Piping only stderr to a program)
  
> Also, even if it's true, is that also true with all other possible
> shells? 

I think the point is it can be made to work in userland, not that a
particular shell isn't able to do that.  In fact, I'm a bit dissapointed
that shells such as zsh and bash seem to lack an easy way to do that. But
really, this is theoretical, I think nobody is really advocating getting rid
of /dev/null and /dev/zero.

> Redirecting to /dev/null is independant of the shells, but piping hacks
> like that aren't.

The way I see it piping is independent from shells just because it can be
accomplished in userland using the present linux system calls.
 
> So it should be deliberately written to write them out in an infinite
> loop? Makes a bizarre sort of sense, but not something I would ever do.

Why is that? I see nothing bizarre in that.
 
> Also, as I've had pointed out to me, one sometimes needs to tell a
> program to take input other than stdin from /dev/zero and that often
> can't be done using pipes. The friend who pointed this out to me
> recently had reason to do precicely this. The following isn't exactly
> what he needed, but is similar...
> 
>  Q> ebcdic2ascii < /dev/ttyS1 | tr A-Z a-z | bindiff /dev/zero /dev/stdin

Again, I think it can be done in userland. Some shells even give you
convenient syntax for that. This works in zsh:

head -2 <(yes) <(uname)
==> /proc/self/fd/11 <==
y
y

==> /proc/self/fd/12 <==
Linux

So you can pipe arbitrary program output as a filename argument.

I guess you example could be written as

ebcdic2ascii < /dev/ttyS1 | tr A-Z a-z | bindiff <(zerofill) /dev/stdin
 
but I'm not sure since I have no idea your example does ;) ;).

> > I'm still happy to keep /dev/null and /dev/zero.  ;)
> 
> So am I.


-- v --

v@iki.fi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132715AbRDNBz7>; Fri, 13 Apr 2001 21:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132713AbRDNBzt>; Fri, 13 Apr 2001 21:55:49 -0400
Received: from m343-mp1-cvx1a.col.ntl.com ([213.104.69.87]:55425 "EHLO
	[213.104.69.87]") by vger.kernel.org with ESMTP id <S132711AbRDNBzf>;
	Fri, 13 Apr 2001 21:55:35 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <200104132351.QAA05523@adam.yggdrasil.com>
From: John Fremlin <chief@bandits.org>
Date: 14 Apr 2001 02:54:08 +0100
In-Reply-To: "Adam J. Richter"'s message of "Fri, 13 Apr 2001 16:51:34 -0700"
Message-ID: <m2g0fc6ybj.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> "John Fremlin" <chief@bandits.org> writes:
> > "Adam J. Richter" <adam@yggdrasil.com> writes:
> >> 	Guess why you're seeing this email.  That's right.  Linux-2.4.3's
> >> fork() does not run the child first.
> 
> >[...] If an app wants to fork and exec, it
> >should use *vfork* and exec, which is a performance win across many
> >OSs because the COW mappings don't even have to be set up, IIRC.
> 
> Even in that case, you want to run the child first because

The parent is not allowed to run until the child execs, if I
understand correctly. Read up on CLONE_VFORK.
 
[...]

> Of course, in the vfork case, this change is probably only a very
> small win.  The real advantage is with regular fork() followed by an
> exec, which happens quite a lot.  For example, I do not see vfork
> anywhere in the bash sources.

If it is a real advantage you can get a bigger advantage by changing
the app to use vfork, i.e. you can solve the problem (if it exists)
better without hacking the kernel. Further, your change will hurt
those apps which expect the parent to be given a fair chance, so
you'll need to add a fairfork(2) syscall to comply with Californian
anti age discrimmination legislation (humour). In fact, if you think
fork+exec is such a big performance hit why not go for spawn(2) and
have Linus and Al jump on you? ;-)

[...]

-- 

	http://www.penguinpowered.com/~vii

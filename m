Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWCQU2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWCQU2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWCQU2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:28:09 -0500
Received: from mail.linicks.net ([217.204.244.146]:14477 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751309AbWCQU2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:28:07 -0500
From: Nick Warne <nick@linicks.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: chmod 111
Date: Fri, 17 Mar 2006 20:27:43 +0000
User-Agent: KMail/1.9.1
Cc: Phillip Susi <psusi@cfl.rr.com>, Steven Rostedt <rostedt@goodmis.org>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
References: <200603171746.18894.nick@linicks.net> <441B1025.7000708@cfl.rr.com> <Pine.LNX.4.64.0603171202240.3618@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603171202240.3618@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603172027.43968.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 20:11, Linus Torvalds wrote:
> On Fri, 17 Mar 2006, Phillip Susi wrote:
> > Linus Torvalds wrote:
> > > In particular, it's fairly easy to create a shared library that
> > > replaces a system library (LD_LIBRARY_PATH) and then just dumps out the
> > > binary image.
> >
> > What prevents you from injecting a shared library and manipulating a suid
> > executable?
>
> Suid executables do not accept LD_LIBRARY_PATH.
>
> > Does the environment get cleared when you exec a suid program?
>
> No, but the startup environment can tell if it's suid, and refuse to load
> anything but the fixed environment, so it's _effectively_ cleared for a
> subset of the environment strings.
>
> Suid executables also get some special handling by the kernel (it will,
> for example, refuse to dump core for them - another way to get readable
> information from an executable). Similarly, you can't ptrace a suid
> executable (a _third_ way of getting information from a execute-only
> binary in general).
>
> So suid executables are a separate issue: they actually _do_ have security
> protection (regardless of whether they are marked "readable" or not).
>
> And finally don't get me wrong - you _can_ build up security around the
> executable bits, but it has to be a lot more involved than just assuming
> that being unreadable means that nobody can see what a binary does. So for
> example, you _can_ create a system where you only have a certain subset of
> binaries that will be run (no debuggers), and where user-supplied binaries
> simply won't execute (mounting any user-writable area no-exec, and make
> sure that none of the executable loaders like /lib/ld.so will load a
> non-exec image).
>
> But in general, I'd say that is only applicable in some embedded
> environments (you could have a special chroot'ed jail environment where it
> could be very hard to read the binaries that you expose in the jail
> environment, for example). It's not useful in something that gives shell
> access and allows the user to create his own executable program files.

Well, I thought after making my post and read the first few replies that I 
made 'dork of the week' post.

But now I am glad I did post.  I have learnt a lot.

Thanks everybody.  A real insight to the sub-system.

Nick 


-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSIOU4O>; Sun, 15 Sep 2002 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSIOU4O>; Sun, 15 Sep 2002 16:56:14 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:3225 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S318255AbSIOU4N>;
	Sun, 15 Sep 2002 16:56:13 -0400
Date: Sun, 15 Sep 2002 23:00:47 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Willy Tarreau <willy@w.ods.org>
cc: Hans-Peter Jansen <hpj@urpla.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
In-Reply-To: <20020915193410.GA17662@alpha.home.local>
Message-ID: <Pine.GSO.4.30.0209152252550.22107-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Willy Tarreau wrote:

> On Sun, Sep 15, 2002 at 09:13:30PM +0200, Pozsar Balazs wrote:
>
> > This is because the kernel cannot execute the "/home/pozsy/b" script, and
> > then bash tries to interpret it itself. (but this in *not* what I want: I
> > want the "b" 'script' interpreted by the "a" script).
> > If you try this:
> >   strace -f /home/pozsy/b
> > You will get this:
> > execve("/home/pozsy/b", ["/home/pozsy/b"], [/* 24 vars */]) = 0
> > strace: exec: Exec format error
> >
> > The root of the problem is still that /home/pozsy/b cannot be execve'd.
> > That is a kernel problem.
>
> the problem is far simpler :
> when you execute /home/pozsy/b, the kernel should have to launch /home/pozsy/a
> with /home/pozsy/b in argv[0]. If it accepted to run it, it would run sh (or
> perl or any other interpreter) with /home/pozsy/a in argv[0], thus loosing
> track of /home/pozsy/b.
>
> The simplest solution for you is to write a little C wrapper to start your
> interpreted interpreter with the script in argument. Written with dietlibc or
> anything like it, it would not be more than a few hundred bytes long.

I wrote a little wrapper, but that showed me that the kernel does _not_
replace argv[0], instead it pushes the original argv[0] into argv[1] or
argv[2].
So we would not loose track of the original name, as interpreters could be
called like this:
/interpreter1 script
/interpreter2 /interpreter1 script
/interpreter3 /interpreter2 /interpreter1 script
...and so on.

-- 
pozsy



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSIOT3U>; Sun, 15 Sep 2002 15:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSIOT3U>; Sun, 15 Sep 2002 15:29:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40201 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S318208AbSIOT3T>;
	Sun, 15 Sep 2002 15:29:19 -0400
Date: Sun, 15 Sep 2002 21:34:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: Hans-Peter Jansen <hpj@urpla.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
Message-ID: <20020915193410.GA17662@alpha.home.local>
References: <200209152055.05322.hpj@urpla.net> <Pine.GSO.4.30.0209152057580.22107-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0209152057580.22107-100000@balu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 09:13:30PM +0200, Pozsar Balazs wrote:
 
> This is because the kernel cannot execute the "/home/pozsy/b" script, and
> then bash tries to interpret it itself. (but this in *not* what I want: I
> want the "b" 'script' interpreted by the "a" script).
> If you try this:
>   strace -f /home/pozsy/b
> You will get this:
> execve("/home/pozsy/b", ["/home/pozsy/b"], [/* 24 vars */]) = 0
> strace: exec: Exec format error
> 
> The root of the problem is still that /home/pozsy/b cannot be execve'd.
> That is a kernel problem.

the problem is far simpler :
when you execute /home/pozsy/b, the kernel should have to launch /home/pozsy/a
with /home/pozsy/b in argv[0]. If it accepted to run it, it would run sh (or
perl or any other interpreter) with /home/pozsy/a in argv[0], thus loosing
track of /home/pozsy/b.

The simplest solution for you is to write a little C wrapper to start your
interpreted interpreter with the script in argument. Written with dietlibc or
anything like it, it would not be more than a few hundred bytes long.

Cheers,
Willy


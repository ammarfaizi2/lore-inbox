Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272243AbSISSYy>; Thu, 19 Sep 2002 14:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272249AbSISSYy>; Thu, 19 Sep 2002 14:24:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11906 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272243AbSISSYw>; Thu, 19 Sep 2002 14:24:52 -0400
Date: Thu, 19 Sep 2002 14:32:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: dvorak <dvorak@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
In-Reply-To: <20020919175941.GA7851@xs4all.nl>
Message-ID: <Pine.LNX.3.95.1020919143125.15604C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, dvorak wrote:

> On Thu, Sep 19, 2002 at 01:22:35PM -0400, Richard B. Johnson wrote:
> > On Thu, 19 Sep 2002, Brian Gerst wrote:
> > 
> > > Richard B. Johnson wrote:
> > > > On Thu, 19 Sep 2002, dvorak wrote:
> > > > 
> > > > 
> > > >>Hi,
> > > >>
> > > >>recently i came across a situation were on linux-i386 not only %eax was
> > > >>altered after a syscall but also %ebx. I tracked this problem down, to
> > > >>gcc re-using a variable passed to a function.
> > > >>
> > > >>This was found on a debian system with a 2.4.17 kernel compiled with gcc
> > > >>2.95.2 and verified on another system, kernel 2.4.18 compiled with 2.95.4 
> > > >>Attached is small program to test for this 'bug'
> > > >>
> <SNIP part of the explanation>
> 
> > > >>It seems that gcc in certain cases optimizes in such a way that it changes
> > > >>the variable ufds as placed on the stack directly. Which results in saved(ebx)
> > > >>being overwritten and thus in a changed %ebx on return from the system call.
> > > >>
> > > > 
> > > > 
> > > > The 'C' compiler must make room on the stack for any local
> > > > variables except register types. If it was doing as you state, you
> > > > couldn't even execute a "hello world" program. Further, the local
> > > > variables are after the return address. It would screw up the return
> > > > address and you'd go off into hyper-space upon return.
> 
> The problem is it uses one of the _arguments_ passed to the function, 
> that argument gets modified, normally this happens on a copy, but there
> is no 'garantue' that is doesn't modify the original argument as
> putted on the stack by the calling function.
> 
> > > > No. Various 'C' implementers have standardized calling methods even
> > > > though it's not part of the 'C' standard. gcc and others assume that
> > > > a called procedure is not going to change any segments or index registers.
> > > > There are various optimization things, like "-fcaller-saves" where the
> > > > called procedure can destroy anything. You may be using something that
> > > > was wrongly compiled using that switch.
> This is not what happens here, what happens is that one of the _arguments_
> placed on the stack is being modified, normally a calling function discards
> these values after use (addl $0x10, %esp or similar) but in this case they
> are reused. (in the RESTORE_ALL call)
> 
> > > 
> > > The bug is only with _some_ syscalls, and getpid() is not one of them, 
> > > so your example is flawed.  It happens when a syscall modifies one of 
> > > it's parameter values.  The solution is to assign the parameter to a 
> > > local variable before modifying it.
> > > 
> and only with _some_ compiler + kernel combinations.
[SNIPPED...]

Okay. Thanks for the explaination.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


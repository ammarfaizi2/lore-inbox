Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbREVQlE>; Tue, 22 May 2001 12:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbREVQky>; Tue, 22 May 2001 12:40:54 -0400
Received: from mail2.rdc2.bc.home.com ([24.2.10.85]:31149 "EHLO
	mail2.rdc2.bc.home.com") by vger.kernel.org with ESMTP
	id <S262628AbREVQkh>; Tue, 22 May 2001 12:40:37 -0400
Date: Tue, 22 May 2001 09:40:19 -0700 (PDT)
From: Ryan Cumming <bodnar42@bodnar42.dhs.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/coda.h
In-Reply-To: <E152DEZ-0001y7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L2.0105220924560.32368-100000@bodnar42.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Alan Cox wrote:

> If __linux__ is not defined by the cross compiler, then the cross compiler
> is broken. A cross compiler has the same environment as the native compiler
> for the target. The only stuff that should break (well should as in might) is
> tools native built
>
> Or am I misunderstanding the report ?

It is not a cross compiler, it is the FreeBSD native gcc. As I understood
it, Linux is a self contained project and should be targetting the
native platform, not Linux on that platform. A cross compiler should
not be needed unless one is building for another CPU.

The coda.h file was doing something along the lines of:

#ifdef __linux__
#ifdef __KERNEL__
/* Define things */
#endif
#endif

When compiling the kernel under FreeBSD, __KERNEL__ is defined, but
__linux__ is not. I think this is an error on the part of the header file,
because on non-Linux build environments, which would otherwise compile the
Linux kernel correctly, do not have __linux__ defined.

However, not many people will probably find much use in compiling the
kernel on other platforms, so if you think this isn't worth inclusion, I
totally understand. I'm in the process of porting UML to FreeBSD, and
having this patch in the tree would make my job slightly easier.

-Ryan


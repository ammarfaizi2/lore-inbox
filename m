Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbREVQ5E>; Tue, 22 May 2001 12:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbREVQ4o>; Tue, 22 May 2001 12:56:44 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:30613 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S262656AbREVQ4e>; Tue, 22 May 2001 12:56:34 -0400
Date: Tue, 22 May 2001 12:56:26 -0400
To: Ryan Cumming <bodnar42@bodnar42.dhs.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Jeff Dike <jdike@karaya.com>
Subject: UML cross-platform build problems (was Re: [PATCH] include/linux/coda.h)
Message-ID: <20010522125625.A3985@cs.cmu.edu>
Mail-Followup-To: Ryan Cumming <bodnar42@bodnar42.dhs.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Jeff Dike <jdike@karaya.com>
In-Reply-To: <E152DEZ-0001y7-00@the-village.bc.nu> <Pine.LNX.4.33L2.0105220924560.32368-100000@bodnar42.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33L2.0105220924560.32368-100000@bodnar42.dhs.org>; from bodnar42@bodnar42.dhs.org on Tue, May 22, 2001 at 09:40:19AM -0700
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 09:40:19AM -0700, Ryan Cumming wrote:
> On Tue, 22 May 2001, Alan Cox wrote:
> 
> > If __linux__ is not defined by the cross compiler, then the cross compiler
> > is broken. A cross compiler has the same environment as the native compiler
> > for the target. The only stuff that should break (well should as in might) is
> > tools native built
> >
> > Or am I misunderstanding the report ?
> 
> It is not a cross compiler, it is the FreeBSD native gcc. As I understood
> it, Linux is a self contained project and should be targetting the
> native platform, not Linux on that platform. A cross compiler should
> not be needed unless one is building for another CPU.

The problem is that the same coda.h header is also used as part of the
FreeBSD kernel to build a Coda kernel module. Both Linux and FreeBSD
have different include and typedef requirements for their kernel code.

There is no way for an identical coda.h header to recognize whether it
is built as part of the FreeBSD kernel or as part of a (UML) Linux
kernel, except if the parts that are OS dependent are not part of the
same header.

I agree that a UML kernel on FreeBSD should be a native binary and not
cross-compiled. However, this could be an UML specific problem and
-D__linux__ should be added to CFLAGS in arch/uml/Makefile as all
drivers and filesystems that are developed for different platforms and
share parts of their code are possibly affected.

Jan


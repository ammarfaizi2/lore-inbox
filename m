Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTDPRoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264491AbTDPRoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:44:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28289 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264490AbTDPRoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:44:37 -0400
Date: Wed, 16 Apr 2003 13:58:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bruce Harada <bharada@coral.ocn.ne.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: System Call parameters
In-Reply-To: <20030417024147.33a76987.bharada@coral.ocn.ne.jp>
Message-ID: <Pine.LNX.4.53.0304161354190.12149@chaos>
References: <Pine.LNX.4.53.0304161256130.11667@chaos>
 <20030417024147.33a76987.bharada@coral.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003, Bruce Harada wrote:

> On Wed, 16 Apr 2003 12:58:15 -0400 (EDT)
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
>
> >
> > How does the kernel get more than five parameters?
> >
> > Currently...
> > 	eax	= function code
> > 	ebx	= first parameter
> > 	ecx	= second parameter
> > 	edx	= third parameter
> > 	esi	= fourth parameter
> > 	edi	= fifth parameter
> >
> > Some functions like mmap() take 6 parameters!
> > Does anybody know how these parameters get passed?
> > I have an "ultra-light" 'C' runtime library I have
> > been working on and, so-far, I've got everything up
> > to mmap()  (in syscall.h) (89 functions) working.
> > I thought, maybe ebp was being used, but it doesn't
> > seem to be the case.
> >
> > Maybe after 5 functions, there is a parameter list
> > passed by pointer???? I don't have a clue and I
> > can figure out the code, it's really obscure...
>
> >From http://www.google.co.jp/search?q=cache:7GJP4whNQEkC:webster.cs.ucr.edu/Page_Linux/LinuxSysCalls.pdf+Linux+mmap+parameters+ebp&hl=ja&ie=UTF-8 :
>
>  Certain Linux 2.4 calls pass a sixth parameter in EBP. Calls compatible with earlier versions of the kernel pass six or
>  more parameters in a parameter block and pass the address of the parameter block in EBX (this change was probably
>  made in kernel 2.4 because someone noticed that an extra copy between kernel and user space was slowing down
>  those functions with exactly six parameters; who knows the real reason, though).
>
> Relevant? No idea.
>

Yes. Absolutely relevant. FYI, I experimentaly I found out that
the 6th parameter is passed in EBP if I use __NR_mmap2 as the
function call instead of __NR_mmap. Thanks -- and I now have that
working...


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


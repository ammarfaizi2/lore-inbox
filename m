Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUC2Vt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUC2Vt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:49:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38018 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261950AbUC2VtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:49:15 -0500
Date: Mon, 29 Mar 2004 16:50:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Lev Lvovsky <lists1@sonous.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
In-Reply-To: <1CD69E8E-81C9-11D8-A0A8-000A959DCC8C@sonous.com>
Message-ID: <Pine.LNX.4.53.0403291644200.3114@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
 <Pine.LNX.4.53.0403291602340.2893@chaos> <1CD69E8E-81C9-11D8-A0A8-000A959DCC8C@sonous.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Lev Lvovsky wrote:

>
> On Mar 29, 2004, at 1:17 PM, Richard B. Johnson wrote:
>
> > For glibc compatibility you need to get rid of the sym-link(s)
> > /usr/include/asm and /usr/include/linux in older distributions.
> > You need to replace those with headers copied from the kernel
> > in use when the C runtime library was compiled. If you can't find
> > those, you can either upgrade your C runtime library, or copy
> > headers from some older kernel that was known to work.
>
> I might be a bit confused here, but the problem with that, is that I'm
> effectively working backwards.  I've reverted the kernel version, but
> all other applications have been kept of course - this means that
> though I can keep those sym-links pointing to the correct kernel
> headers (those which were present when glibc was compiled), the current
> kernel (the reverted one) will obviously have different include files.
>
> In order to compile the modules for the afformentioned hardware, those
> symlinks need to point to the 2.2.x kernel directories - will this
> break functionality of future compiled applications etc?
>

No No. Never! The modules never, ever, use glibc headers. Never!

The compilation should set the -I (include) parameter to point
to the kernel headers.

Something like:

VER	:= $(shell uname -r)
INC= -I. -I/usr/src/linux-$(VER)
DEF= -D__KERNEL__ -DMODULE

gcc -c -Wall -O2 -fomit-frame-pointer $(INC) $(DEF) -m module.o module.c



Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



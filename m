Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312412AbSCaIms>; Sun, 31 Mar 2002 03:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSCaIm3>; Sun, 31 Mar 2002 03:42:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6396 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312412AbSCaImV>;
	Sun, 31 Mar 2002 03:42:21 -0500
Date: Sun, 31 Mar 2002 03:42:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: "David S. Miller" <davem@redhat.com>, tim@birdsnest.maths.tcd.ie,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
In-Reply-To: <3CA6C91D.67186FAB@zip.com.au>
Message-ID: <Pine.GSO.4.21.0203310333460.4431-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Mar 2002, Andrew Morton wrote:

> Could you remind us what problem this is solving?  The
> #ifdef approach seemed reasonable and there's no indication
> here why weak linkage is needed.

The thing we want here _is_ weak linkage - "return -ENOSYS unless
you have the real thing".  You can emulate that with ifdefs,
but that's what it is - emulation.  IOW, what we want actually
belongs to linker, not compiler.

When file looks like

#ifdef FOO
<lots of stuff>
<function calling that stuff>
#else
<make that function an equivalent of sys_ni_syscall()>
#endif

we are really talking about "make it an alias of sys_ni_syscall() and let
<all this stuff> override that".


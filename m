Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTBXOls>; Mon, 24 Feb 2003 09:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbTBXOls>; Mon, 24 Feb 2003 09:41:48 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:21198 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S267135AbTBXOlr>; Mon, 24 Feb 2003 09:41:47 -0500
Date: Mon, 24 Feb 2003 15:51:22 +0100 (CET)
From: fcorneli@elis.rug.ac.be
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-kernel@vger.kernel.org, <Frank.Cornelis@elis.rug.ac.be>
Subject: Re: [PATCH] ptrace PTRACE_READDATA/WRITEDATA, kernel 2.5.62
In-Reply-To: <20030224141608.GA24699@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0302241538570.1277-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> FYI Frank, three things.  First of all, I really don't like the
> interface of adding a second address to ptrace; I believe it interferes
> with PIC on x86, since IIRC the extra argument would go in %ebx.  
> The BSDs have a nice interface involving passing a request structure. 

I don't see the problem since we can pass up to 6 parameters on the i386 
architecture. The extra argument will be passed on using the stack as the 
other arguments do because of the asmlinkage directive. Using a structure 
slows everything down too much; if you can use the stack I think it's 
better to do so. What about that PIC?

> Secondly, the implementation should be in kernel/ptrace.c not under
> i386, we're trying to stop doing that.

The implementation is already in kernel/ptrace.c, only the usage lives 
under the arch-dependent directories since there the sys_ptrace entries 
are located.

> Thirdly, I was going to do this, but I ended up making GDB use pread64
> on /dev/mem instead.  It works with no kernel modifications, and is
> just as fast.

mmm... I thought it would be convenient to use ptrace for all the trace 
work.

Frank.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288021AbSABXzF>; Wed, 2 Jan 2002 18:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288038AbSABXyp>; Wed, 2 Jan 2002 18:54:45 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:63712 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287169AbSABXxY>;
	Wed, 2 Jan 2002 18:53:24 -0500
From: dewar@gnat.com
To: paulus@samba.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, trini@kernel.crashing.org
Message-Id: <20020102235318.26F2FF2EC7@nile.gnat.com>
Date: Wed,  2 Jan 2002 18:53:18 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<One of the reasons why C is a good language for the kernel is that its
memory model is a good match to the memory organization used by the
processors that linux runs on.  Thus, for these processors, adding an
offset to a pointer is in fact simply an arithmetic addition.  Combine
that with the fact that the kernel is far more aware of how stuff is
laid out in its virtual memory space than most C programs, and you can
see that it is reasonable for the kernel to do pointer arithmetic
which might be undefined according to the strict letter of the law,
but which in fact works correctly on the class of processors that
Linux runs on, for all reasonable compiler implementations.
>>

The concept of "all reasonable compiler implementations" is a very dubious
one. There is nothing to stop a valid C compiler from building assertions
based on the quoted paragraph from the C standard, e.g. it could derive
valid range information from knowing that an offset was constrained to
certain limits. So writing bogus C like this is risky, and as compilers
get more sophisticated, one is likely to hear screams, but they are not
justified in my opinion. There is no excuse for such abuse.

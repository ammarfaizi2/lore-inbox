Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSETEyh>; Mon, 20 May 2002 00:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSETEyg>; Mon, 20 May 2002 00:54:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65464 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315754AbSETEyf>;
	Mon, 20 May 2002 00:54:35 -0400
Date: Sun, 19 May 2002 21:40:53 -0700 (PDT)
Message-Id: <20020519.214053.19164382.davem@redhat.com>
To: ppadala@cise.ufl.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.05.10205192307500.26915-100000@rain.cise.ufl.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pradeep Padala <ppadala@cise.ufl.edu>
   Date: Sun, 19 May 2002 23:08:36 -0400 (EDT)

      I was trying to understand ptrace code in kernel. It seems there's
   no PTRACE_READDATA for architectures other than sparc and sparc64.
   There's a function named ptrace_readdata() in kernel/ptrace.c but I
   couldn't find a way to invoke it from user space. Is the feature
   missing? or Is it intended?

Only Sparc implements this, that is correct.

If other platforms added PTRACE_READDATA support, they would
also need to add some way to do a feature test for it's presence
so that GDB and other debugging code could actually make use
of it portably.

      Another thing I noticed, the prototype for do_ptrace() in
      arch/sparc/kernel/ptrace.c is
   
      asmlinkage void do_ptrace(struct pt_regs *regs)
   
      I thought it should be some thing like
      asmlinkage int sys_ptrace(long request, long pid, long addr, long
   data)

The return values are set directly in the user's pt_regs.

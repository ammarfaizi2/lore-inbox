Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272194AbRHWCog>; Wed, 22 Aug 2001 22:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272195AbRHWCo1>; Wed, 22 Aug 2001 22:44:27 -0400
Received: from zok.sgi.com ([204.94.215.101]:48326 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S272194AbRHWCoQ>;
	Wed, 22 Aug 2001 22:44:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Richard J Moore" <richardj_moore@uk.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there any interest in Dynamic API 
In-Reply-To: Your message of "Wed, 22 Aug 2001 18:44:27 +0100."
             <OF7D8B08B8.41635C2F-ON80256AB0.0060953B@portsmouth.uk.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Aug 2001 12:44:22 +1000
Message-ID: <19879.998534662@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001 18:44:27 +0100, 
"Richard J Moore" <richardj_moore@uk.ibm.com> wrote:
>I was wondering whether the kernel community had any interest in seeing a
>dynamic api capability in the kernel. What I have in mind the ability for a
>kernel module to request a system call entry be added by supplying a call
>name to a create_dynamic_api service.

Why does this remind me of SVCUPDTE?

You will have problems on architectures where indirect function calls
require extra handling.  IA64 has to load a global data pointer (gp) as
well as the function address for an indirect call.  The existing
syscall table avoids this overhead because all system calls are in the
kernel with a constant gp.  To allow syscalls to modules you either
load a gp for each entry point (which slows down all syscalls) or you
need arch specific trampoline code to enter and exit a syscall in a
module.  PPC64 looks like it has the same problem.

There is also the problem of generating syscalls in userspace pic code.
Each arch is different, look at all the hassles glibc goes through to
create syscall interfaces.  It is not surprising that _syscall[0-5] are
deprecated interfaces.  It is much easier to use a device or fs interface.


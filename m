Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSLRE3R>; Tue, 17 Dec 2002 23:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbSLRE3R>; Tue, 17 Dec 2002 23:29:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54799 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267048AbSLRE3Q>; Tue, 17 Dec 2002 23:29:16 -0500
Message-ID: <3DFFFB56.6070803@transmeta.com>
Date: Tue, 17 Dec 2002 20:36:38 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ulrich Drepper <drepper@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171956170.1230-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>>
>>Destroying %ecx is a lot less destructive than destroying %eip and %esp...
> 
> Actually, as far as the kernel is concerned, they are about equally bad.
> 

Right, but from a user-mode point of view it means at least one extra 
instruction.

> Destroying %eip is the _least_ bad register to destroy, since the kernel
> can control that part, and it is trivial to just have a single call site.

Trivial, perhaps, but it requires a call/ret pair in userspace, which is 
   a fairly expensive form of push/pop.

> The good news is that since both of them suck, it's easier to make the
> six-argument decision. Since six arguments are problematic for all major
> "fast" system calls, my executive decision is to just say that
> six-argument system calls will just have to continue using the old and
> slower system call interface. It's kind of a crock, but it's simply due to
> silly CPU designers.

Oh, so you're not going to do the "read from stack" thing?  (Agreed, by 
the way, on the CPU design -- both SYSENTER and SYSCALL suck.  SYSCALL 
was changed rather substantially in x86-64 for that reason.)

	-hpa




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbSL2FA3>; Sun, 29 Dec 2002 00:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266460AbSL2FA3>; Sun, 29 Dec 2002 00:00:29 -0500
Received: from mnh-1-16.mv.com ([207.22.10.48]:58117 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S266443AbSL2FA2>;
	Sun, 29 Dec 2002 00:00:28 -0500
Message-Id: <200212290512.AAA05609@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address space 
In-Reply-To: Your message of "Sat, 28 Dec 2002 20:13:44 PST."
             <Pine.LNX.4.44.0212282010080.2029-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Dec 2002 00:12:51 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com said:
> But that is an address space that it should already has access to
> through,  since it created it in the first place (ie it would fall
> under the normal  "sys_mm_indirect()" case). 

Yes, and so it doesn't fall under ptrace.  I think we're in violent agreement
here.

> The thing that I _really_ don't want to have is soem uncontrolled way
> to  generate accesses to existing "struct mm_struct"s, since that is
> really  dangerous from a security standpoint. 

Fine by me.  UML has no need for manipulating pre-existing address spaces.

> We could have a PTRACE_GET_MM_FD kind of thing for ptrace (and then
> the  gdb/tracer can use that to create mappings in the process), but
> the reason  I want that "hook" to be through ptrace itself is simply
> that it's a known  interface to control other unrelated processes.
>
> So if you create the MM's yourself, you can use the indirection
> directly.  But if you want to control your children or unrelated
> processes, you use  ptrace to get the hook.  

Yup.  As far as UML is concerned, this is all fine.  It has no need of
a PTRACE_GET_MM_FD since it creates all address spaces itself, but other
tools might.

				Jeff


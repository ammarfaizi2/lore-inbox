Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSAICpx>; Tue, 8 Jan 2002 21:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288732AbSAICpm>; Tue, 8 Jan 2002 21:45:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29971 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288731AbSAICpY>; Tue, 8 Jan 2002 21:45:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: can we make anonymous memory non-EXECUTABLE?
Date: 8 Jan 2002 18:44:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1gar7$12t$1@cesium.transmeta.com>
In-Reply-To: <200201080025.QAA26731@napali.hpl.hp.com> <20020107.220208.23012783.davem@redhat.com> <15419.17581.990574.160248@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <15419.17581.990574.160248@napali.hpl.hp.com>
By author:    David Mosberger <davidm@napali.hpl.hp.com>
In newsgroup: linux.dev.kernel
> 
> I don't consider SIGSEGV to be a silent failure.  Also, I think
> all the evidence is that it's unlikely to break many existing
> apps:
> 
> 	o The bug I described has been present for *years* on
> 	  Alpha and probably all other platforms other than x86;
> 	  even on ia64 it took almost two years before someone
> 	  noticed.  It's possible that nobody noticed because
> 	  the code generators were part of a larger program,
> 	  but it's very likely that anyone writing a test program
> 	  would have allocated the non-executable memory, so you'd
> 	  expect *someone* to have run into it at some point.
> 
> 	o Certain libraries such as the Boehm Garbage Collector
> 	  already turn off execute permission by default.  While
> 	  there may not be that many apps that use it in a production
> 	  environment, it is my impression that many developers are
> 	  using it as a memory-leak detector (e.g., Mozilla does that).
> 
> 
>   DaveM> Secondly, I do not see any
>   DaveM> real gain from any of this and my ports are those that have
>   DaveM> I-cache coherency issues :-)
> 
> I think that's fine.  If the consensus is that apps *should* use
> mprotect() to get executable permission (Linus implied as much) and
> it's an architecture specific choice as to whether this is enforced,
> I'm happy.  My belief is that we could make this change on ia64
> without undue burden on programmers.  If not, I'm sure I'll find out
> about it and I'm willing to take the responsibility.
> 

One way to do this would be to create a newbrk() syscall which takes a
permission argument (for new pages.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

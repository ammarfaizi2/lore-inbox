Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSGDA1e>; Wed, 3 Jul 2002 20:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317293AbSGDA1d>; Wed, 3 Jul 2002 20:27:33 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:44037 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S317282AbSGDA1d>; Wed, 3 Jul 2002 20:27:33 -0400
X-mailer: xrn 8.03-beta-26
From: pmenage@ensim.com
Subject: Re: simple handling of module removals Re: [OKS] Module removal
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: 
In-reply-to: <0C01A29FBAE24448A792F5C68F5EA47D2B0A8A@nasdaq.ms.ensim.com>
Message-Id: <E17PuV9-0006iy-00@pmenage-dt.ensim.com>
Date: Wed, 03 Jul 2002 17:29:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D2B0A8A@nasdaq.ms.ensim.com>,
you write:
>
>Is it just the mod_dec_use_count; return/unload race we're worried about? 
>>I'm not clear on why this is hard.  I'd think it would be sufficient just
>to 
>walk all runnable processes to ensure none has an execution address inside
>the
>module.  For smp, an ipi would pick up the current process on each cpu.
>
>At this point the use count must be zero and the module deregistered, so
>all 
>we're interested in is that every process that dec'ed the module's use
>count 
>has succeeded in executing its way out of the module.  If not, we try
>again 
>later, or if we're impatient, also bump any processes still inside the
>module 
>to the front of the run queue.
>
>I'm sure I must have missed something.
>

Identifying the valid execution address in a stack traceback isn't
possible on many architectures (in particular, i386 without debugging
support enabled) so this wouldn't work if one of the functions had
called into a function outside the module.

On the other hand, if it was made a rule that any code in a module that
might theoretically be running without reference counts wasn't allowed
to call out of the module (or maybe was allowed to call out to a very
specific small set of library functions that were known to the module
system), then something like this might work.

Paul

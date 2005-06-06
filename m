Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVFFMyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVFFMyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 08:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVFFMyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 08:54:20 -0400
Received: from mail.ccur.com ([208.248.32.212]:9892 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261366AbVFFMyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 08:54:12 -0400
Message-ID: <42A4476F.2070704@ccur.com>
Date: Mon, 06 Jun 2005 08:54:07 -0400
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ak@suse.de, bugsy@ccur.com, roland@redhat.com, akpm@osdl.org
Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2005 12:54:09.0227 (UTC) FILETIME=[D47911B0:01C56A96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
 > From: Andi Kleen <ak@suse.de>
 > Date: Sun, 5 Jun 2005 13:21:19 +0200
 > To: John Blackwood <john.blackwood@ccur.com>
 > CC: linux-kernel@vger.kernel.org, roland@redhat.com, ak@suse.de, 
akpm@osdl.org, bugsy@ccur.com
 >
 > On Fri, Jun 03, 2005 at 01:21:20PM -0400, John Blackwood wrote:
 >
 > >> 1. Make the default behavior that we single-step to the next 
instruction
 > >>    in the main (non-signal handler) stream of execution, instead of
 > >>    single-stepping into the user's signal handler.
 >
 >
 > I think it is better to not change the default behaviour. You risk
 > breaking programs and there are much more that use ptrace than just gdb.

O.K.  Yes, it seems that this is definitely not a popular idea.   :-)


 > >> 2. Add a new ptrace PTRACE_SETOPTIONS command flag,
 >
 >
 > I think it would be better to just define a new ptrace singlestep command
 > with the new semantics instead of adding options.

Yes, this is a good idea...  I just might re-post this approach
as a suggestion.


 > >> - The ptraced process has a pending signal and
 > >>   it stops to notify the debugger.
 > >>
 > >> - The debugger then single-steps into the ptraced process's signal 
handler.
 > >>
 > >> - On the next eventual continue (PTRACE_CONT) command, we run 
through the
 > >>   signal handler, and we stop once again at the next instruction 
before
 > >>   we changed our execution stream and single-stepped into the user's
 > >>   signal handler.
 > >>
 > >> - At this point, we can no longer continue the ptraced process
 > >>   with a PTRACE_CONT command.  Instead, all ptrace(2) PTRACE_CONT 
calls
 > >>   are treated as if we had made a ptrace(2) PTRACE_SINGLESTEP call.
 >
 >
 > Have you actually seen this in practice?

Yes, but Andrew Morton suggested I try out the above test scenario on:

 
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.12-rc5.tar.bz2

And the problem has indeed been fixed - there is some new code in the
i386 version of handle_signal() that fixes this problem.

(I saw the problem on earlier 2.6.11.10 and 2.6.11.11 kernels.)


Thanks for the feedback, Andrew.



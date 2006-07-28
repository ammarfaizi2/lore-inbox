Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161264AbWG1UMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWG1UMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161267AbWG1UMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:12:54 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:50336 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161264AbWG1UMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:12:54 -0400
Date: Fri, 28 Jul 2006 16:07:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: ptrace bugs and related problems
To: Daniel Jacobowitz <dan@debian.org>
Cc: Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607281609_MC3-1-C65B-2D1A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060728034741.GA3372@nevyn.them.org>

(cc: trimmed)

On Thu, 27 Jul 2006 23:47:41 -0400, Daniel Jacobowitz wrote:
> 
> > In do_fork, the result of fork_traceflag is assigned
> > to the "trace" variable. Note that PT_TRACE_VFORK_DONE
> > does not cause "trace" to be non-zero.
> > 
> > Then we hit this code:
> > 
> >                if (unlikely (trace)) {
> >                        current->ptrace_message = nr;
> >                        ptrace_notify ((trace << 8) | SIGTRAP);
> >                }
> > 
> > That doesn't run. The ptrace_message is thus not set when
> > ptrace_notify is called to send the PTRACE_EVENT_VFORK_DONE
> > message. You get random stale data from a previous message.
> 
> Why do you want the message data anyway?
> 
> FORK/VFORK/CLONE events have a message: it says what the new process's
> PID is.  VFORK_DONE doesn't have a message, because it only indicates
> that the current process is about to resume; it's an event that only
> has one process associated with it.
> 
> I really don't think this is a bug.

Maybe not a bug, but this would be a nice enhancement.  It would cost
exactly one line of code.  I looked at user code I had written and it
assumed the message was available (it was, because I was also tracing
EVENT_VFORK and it happens to be left over from that.)  If we make this
a part of the API, future kernel changes wouldn't break this (erroneous)
assumption, which otherwise might give someone a nasty surprise in
currently-working code.

Otherwise we should zero it out and see what breaks. :)

-- 
Chuck


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271729AbRICPug>; Mon, 3 Sep 2001 11:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271733AbRICPu0>; Mon, 3 Sep 2001 11:50:26 -0400
Received: from [216.151.155.121] ([216.151.155.121]:22278 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S271729AbRICPuG>; Mon, 3 Sep 2001 11:50:06 -0400
To: psusi@cfl.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug report] NFS and uninterruptable wait states
In-Reply-To: <01090310483100.26387@faldara>
From: Doug McNaught <doug@wireboard.com>
Date: 03 Sep 2001 11:50:17 -0400
In-Reply-To: Phillip Susi's message of "Mon, 3 Sep 2001 10:48:31 +0000"
Message-ID: <m3zo8cp93a.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> The other day I was trying to set up an NFS mount to my room mate's system, 
> and ran into what I at least, call a bug.  When I tried to mount his NFS 
> export, the mount command locked up, and would not die.  Not even a SIGKILL 
> would do any good.  According to ps, the mount process was in the 'D' - 
> uninterruptable wait state.  It also looked like the WCHAN was rpc_ 
> something.  I think it was waiting for an rpc call to return in the D state, 
> and it never did return.  The bug here is that it should NOT be waiting in 
> the D state for something that could never happen.  For that matter, why 
> should anything ever need to wait in an uninterruptable state?  Whenever you 
> wait, you should expect the possibility of being interrupted, check for that 
> when you wake up, and if you were, clean up and return so the signal can be 
> processed.

NFS does this (wait in D state) by default in order to prevent naive
applications from getting timeout errors that they're not equipped to
handle--the idea being that, if an NFS server goes down, programs
using it will simply freeze and recover once it returns, rather than
getting a timeout error and possibly becoming confused.

If you don't like this behavior, mount with 'soft' and/or 'intr'
options--see the manpage.

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.

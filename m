Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271733AbRICQB0>; Mon, 3 Sep 2001 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271742AbRICQBQ>; Mon, 3 Sep 2001 12:01:16 -0400
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:13744 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S271741AbRICQA5>; Mon, 3 Sep 2001 12:00:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Phillip Susi <psusi@cfl.rr.com>
Reply-To: psusi@cfl.rr.com
To: Doug McNaught <doug@wireboard.com>
Subject: Re: [bug report] NFS and uninterruptable wait states
Date: Mon, 3 Sep 2001 11:55:32 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <01090310483100.26387@faldara> <m3zo8cp93a.fsf@belphigor.mcnaught.org>
In-Reply-To: <m3zo8cp93a.fsf@belphigor.mcnaught.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01090311553201.26387@faldara>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's all well and good that the process won't get an error back, but imho, 
a process should *NEVER* be beyond the reach of a SIGKILL.  I mean, an 
unkillable process prevents a clean shutdown, doesn't it?  ( can't kill the 
process, can't unmount the filesystem ).  

On Monday 03 September 2001 03:50 pm, Doug McNaught wrote:
> Phillip Susi <psusi@cfl.rr.com> writes:
> > The other day I was trying to set up an NFS mount to my room mate's
> > system, and ran into what I at least, call a bug.  When I tried to mount
> > his NFS export, the mount command locked up, and would not die.  Not even
> > a SIGKILL would do any good.  According to ps, the mount process was in
> > the 'D' - uninterruptable wait state.  It also looked like the WCHAN was
> > rpc_ something.  I think it was waiting for an rpc call to return in the
> > D state, and it never did return.  The bug here is that it should NOT be
> > waiting in the D state for something that could never happen.  For that
> > matter, why should anything ever need to wait in an uninterruptable
> > state?  Whenever you wait, you should expect the possibility of being
> > interrupted, check for that when you wake up, and if you were, clean up
> > and return so the signal can be processed.
>
> NFS does this (wait in D state) by default in order to prevent naive
> applications from getting timeout errors that they're not equipped to
> handle--the idea being that, if an NFS server goes down, programs
> using it will simply freeze and recover once it returns, rather than
> getting a timeout error and possibly becoming confused.
>
> If you don't like this behavior, mount with 'soft' and/or 'intr'
> options--see the manpage.
>
> -Doug

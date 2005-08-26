Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVHZGrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVHZGrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVHZGrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:47:03 -0400
Received: from imap.gmx.net ([213.165.64.20]:32224 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932528AbVHZGrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:47:02 -0400
X-Authenticated: #2864774
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 26 Aug 2005 08:46:29 +0200
MIME-Version: 1.0
Subject: Re: Add pselect, ppoll system calls.
CC: drepper@redhat.com, jakub@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, michael.kerrisk@gmx.net,
       mtk-lkml@gmx.net
Message-ID: <430ED6E5.29250.328C39C@localhost>
In-reply-to: <1124928289.7316.92.camel@baythorne.infradead.org>
References: <25911.1123246168@www3.gmx.net>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

> On Fri, 2005-08-05 at 14:49 +0200, Michael Kerrisk wrote:
> > If I change your program to do something like the above, I also
> > do not see a message from the handler -- i.e., it is not being
> > called, and I'm pretty sure it should be.
> 
> Hm, yes. What happens is we come back out of the select() immediately
> because of the pending signal, but on the way back to userspace we put the
> old signal mask back... so by the time we check for it, there _is_ no
> (unblocked) signal pending. 
> 
> If it's mandatory that we actually call the signal handler, 

I'm just about to go off on holiday, and don't have a chance to pull up 
all the relevant standards details at them moment.  However, I'm fairly 
sure that the signal handler should be called.  (Try running a modified 
version of my program on Solaris 10 or the Unix-03 conversion of AIX 
(5.3?).)

> then we need to
> play tricks like sigsuspend() does to leave the old signal mask on the
> stack frame. That's a bit painful atm because do_signal is different
> between architectures. 

Yes, I'd say the behaviour should in fact be like what sigsuspend() does.

Cheers,

Michael

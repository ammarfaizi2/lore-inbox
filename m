Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUKETkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUKETkx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbUKETiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:38:04 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:38294 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261163AbUKETga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:36:30 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: Synchronization primitives in UML (was: Re: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty sighandler)
Date: Fri, 5 Nov 2004 20:36:55 +0100
User-Agent: KMail/1.7.1
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, cw@f00f.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411052036.55541.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 November 2004 06:48, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > I had a doubt on this, but I was not getting much feedback from you...

> Yeah, sorry.
Jeff, please read this one - I have a number of important things in it. Also, 
I'd like comments from everyone else interested.

I can understand you, so I'll try to reduce my mails to you to increase the 
signal/noise ratio.

I'll still send what needed to the list, but CC you just when requesting your 
attention (not for trivial fixlet, yes for things as this one, which smelt 
like being an hack done on purpose).

> > Also, if you reject this, I'd require a comment-only patch for it: "as
> > soon as I remember why" makes me think back to my yesterday's class,
> > when  the teacher said "put comments in your code or you'll soon
> > forget what it  does!" 8-O (yes, 1st year University student :-( ).

> The thing is, you often don't realize what's going to be mysterious until
> it actually is, and then it's too late for the comment :-)

> In this case, it wants to be bounced out
You mean it failing with EINTR, right?
> of sigprocmask when a SIGWINCH 
> arrives.
Also, why shouldn't sigprocmask be restartable with the -ERESTART* mechanism? 
Wouldn't your kludge break?

Also, a nicer way to code this could be to have an explicit sighandler setting 
a flag (to get the syscall interrupted if the signal arrives before being 
blocked) and to call sigpending() (to test if the signal arrived just after 
setting it). After the syscall, that could become SIG_IGN.

Also, (optional answer), why is this needed? A comment about such issues would 
be better than an answer email.

> In order to do so, it must have a handler registered, even if 
> it does nothing.

Ok. However, I have a general question about all this whole code: why do you 
use pipes as synchronization primitives? Did you avoid semaphores for 
portability issues, or for persistency ones? Both can be solved (with the os_ 
layer and the IPC_PRIVATE key).

This would especially help during context switching, I think. I have just a 
rough idea of what switch_pipe is for, but calling the network layer (what 
you call os_pipe() is actually socketpair(), which is very confusing) to rely 
on the semaphores / wait queues it uses seems suboptimal and ugly.

What are your ideas about this?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265241AbUF1WNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbUF1WNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUF1WNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:13:55 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:54742 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265241AbUF1WNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:13:52 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Jun 2004 15:13:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] signal handler defaulting fix ...
In-Reply-To: <Pine.LNX.4.58.0406281507090.28764@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406281509100.18879@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com>
 <20040628144003.40c151ff.akpm@osdl.org> <Pine.LNX.4.58.0406281446460.28764@ppc970.osdl.org>
 <Pine.LNX.4.58.0406281453250.18879@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0406281507090.28764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Linus Torvalds wrote:

> On Mon, 28 Jun 2004, Davide Libenzi wrote:
> > 
> > It's not that the program try to block the signal. It's the kernel that 
> > during the delivery disables the signal. Then when the signal handler 
> > longjmp(), the signal remains disabled. The next time the signal is raised 
> > again, the kernel does not honor the existing handler, but it reset to 
> > SIG_DFL.
> 
> So? That program is buggy. Setting the signal handler to SIG_DFL causes it 
> to be killed with a nice "killed by SIGFPE" message, and now the bug is 
> visible, and can be fixed.
> 
> Hint: it should have done a siglongjmp().

That's what I posted him. Three examples on how to make the thing work 
w/out kernel fixes. Then Andries investigated about POSIX compliancy and 
noticed that basically it is undefined the behaviour a program will get. 
Let's leave as is then.



- Davide


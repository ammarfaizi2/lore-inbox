Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbUKUVdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbUKUVdB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUKUVdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:33:01 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:17077 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261814AbUKUVc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:32:59 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Nov 2004 13:32:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Daniel Jacobowitz <dan@debian.org>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <20041120214915.GA6100@tesore.ph.cox.net>
Message-ID: <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 01:53:38PM -0800, Linus Torvalds wrote:
> 
> On Fri, 19 Nov 2004, Daniel Jacobowitz wrote:
> > 
> > I'm getting the feeling that the question of whether to step into
> > signal handlers is orthogonal to single-stepping; maybe it should be a
> > separate ptrace operation.
> 
> I really don't see why. If a controlling process is asking for 
> single-stepping, then it damn well should get it. It it doesn't want to 
> single-step through a signal handler, then it could decide to just put a 
> breakpoint on the return point (possibly by modifying the signal handler 
> save area).

I'd agree with Linus here. A signal handler is part of the application, so 
it should be single stepped in the same way other application code does. 
My original patch simply reenabled the flag before returning to userspace, 
and this had the consequence to single step into signal handlers too.



PS: I still cannot find the beginning this thread on lkml.


- Davide


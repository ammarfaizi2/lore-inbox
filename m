Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbULaPQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbULaPQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbULaPQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:16:12 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:44267 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262105AbULaPQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 10:16:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 31 Dec 2004 07:16:00 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andi Kleen <ak@muc.de>
cc: Linus Torvalds <torvalds@osdl.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <20041231123538.GA18209@muc.de>
Message-ID: <Pine.LNX.4.58.0412310654280.10484@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <m1mzvvjs3k.fsf@muc.de>
 <Pine.LNX.4.58.0412301628580.2280@ppc970.osdl.org> <20041231123538.GA18209@muc.de>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004, Andi Kleen wrote:

> >  - you couldn't even debug signal handlers, because they were _really_ 
> >    hard to get into unless you knew where they were and put a breakpoint 
> >    on them.
> 
> Ok I see this as being a problem. But I bet it could be fixed
> much simpler without doing all this complicated and likely-to-be-buggy
> popf parsing you added.

I don't think that the Wine problem resolution is due to the POPF 
instruction handling. Basically Linus patch does a nice cleanup plus POPF 
handling, so maybe the patch can be split.



> >  - you couldn't see the instruction after a system call.
> 
> Are you sure? 

Yes, this was true with 2.4. Than it has been fixed some time ago. But 
handling that revealed a fragile handling of ptrace event delivery we had 
in do_syscall_trace(). Part of the Linus patch tries to solve the fact 
that on one side strace wants things to happen in a certain way, way that 
seem to break Wine. I think Linus cleanup of the ptrace event delivery can 
get strace, Wine and single-step-after-syscall right, w/out POPF handling. 
Then you guys can flame each other over the POPF handling ;)



- Davide


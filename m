Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbULaRUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbULaRUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbULaRUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:20:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:54961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbULaRUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:20:11 -0500
Date: Fri, 31 Dec 2004 09:19:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Jesse Allen <the3dfxdude@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <20041231151045.GA3405@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0412310915390.2280@ppc970.osdl.org>
References: <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <20041230230046.GA14843@nevyn.them.org>
 <Pine.LNX.4.58.0412301513200.22893@ppc970.osdl.org> <20041231053618.GA25850@nevyn.them.org>
 <Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org> <20041231151045.GA3405@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Dec 2004, Daniel Jacobowitz wrote:
> 
> Lots, I like it.  The syscall trap will always be delivered before the
> single-step trap, right, because signal delivery won't run until we
> return to userspace?

Yes. Although I've not actually tested it.

Before, it used to show up as one event, and basically the "0x80" marker 
got lost, so effectively the "system call exit" part would have got lost. 
Now, it _may_ DTRT, with the caveat that the system call ptrace_notify() 
thing still has the same problem with restarting-with-a-signal.

That's basically a "don't do that then", and is the status quo, of course,
so this is at least not a regression. It's still pretty ugly, but 
apparently nobody really cares ;)

		Linus

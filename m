Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVAAXVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVAAXVC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 18:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVAAXVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 18:21:02 -0500
Received: from nevyn.them.org ([66.93.172.17]:2787 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261197AbVAAXUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 18:20:55 -0500
Date: Sat, 1 Jan 2005 18:20:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Allen <the3dfxdude@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20050101232022.GA1987@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jesse Allen <the3dfxdude@gmail.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Roland McGrath <roland@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
References: <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com> <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <20041230230046.GA14843@nevyn.them.org> <Pine.LNX.4.58.0412301513200.22893@ppc970.osdl.org> <20041231053618.GA25850@nevyn.them.org> <Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org> <20041231151045.GA3405@nevyn.them.org> <Pine.LNX.4.58.0412310915390.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412310915390.2280@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 09:19:48AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 31 Dec 2004, Daniel Jacobowitz wrote:
> > 
> > Lots, I like it.  The syscall trap will always be delivered before the
> > single-step trap, right, because signal delivery won't run until we
> > return to userspace?
> 
> Yes. Although I've not actually tested it.
> 
> Before, it used to show up as one event, and basically the "0x80" marker 
> got lost, so effectively the "system call exit" part would have got lost. 
> Now, it _may_ DTRT, with the caveat that the system call ptrace_notify() 
> thing still has the same problem with restarting-with-a-signal.
> 
> That's basically a "don't do that then", and is the status quo, of course,
> so this is at least not a regression. It's still pretty ugly, but 
> apparently nobody really cares ;)

Yes.  At some point, I'd like to make that an error - if you want to
restart with a signal, don't do it from the notification points where
it doesn't make sense (exit, fork, vfork-done, syscall).  Send a signal
by hand, and then resume, and if you want to fudge the siginfo you can
do that when stopped in the signal delivery path.

-- 
Daniel Jacobowitz

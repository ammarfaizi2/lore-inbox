Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbULaPLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbULaPLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbULaPLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:11:04 -0500
Received: from nevyn.them.org ([66.93.172.17]:18892 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262104AbULaPLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 10:11:00 -0500
Date: Fri, 31 Dec 2004 10:10:45 -0500
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
Message-ID: <20041231151045.GA3405@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jesse Allen <the3dfxdude@gmail.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Roland McGrath <roland@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
References: <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com> <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <20041230230046.GA14843@nevyn.them.org> <Pine.LNX.4.58.0412301513200.22893@ppc970.osdl.org> <20041231053618.GA25850@nevyn.them.org> <Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 09:47:42PM -0800, Linus Torvalds wrote:
> So I looked at just sharing the code with the debug trap handler, and the
> result is appended. strace works, as does all the TF tests I've thrown at
> it, and the code actually looks better anyway (the old do_debug code looks
> like it got the EIP wrong in VM86 mode, for example, this just cleans 
> that up too). Just use a common "send_sigtrap()" routine.
> 
> Does this look saner?

Lots, I like it.  The syscall trap will always be delivered before the
single-step trap, right, because signal delivery won't run until we
return to userspace?

-- 
Daniel Jacobowitz

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbULaFFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbULaFFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 00:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbULaFFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 00:05:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:61144 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbULaFFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 00:05:33 -0500
Date: Thu, 30 Dec 2004 21:05:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesse Allen <the3dfxdude@gmail.com>
cc: Davide Libenzi <davidel@xmailserver.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <5304685704123020553f0ef982@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0412302100320.2280@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com> 
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com> 
 <53046857041230112742acccbe@mail.gmail.com>  <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
  <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
 <5304685704123020553f0ef982@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Dec 2004, Jesse Allen wrote:
> 
> Well I tried this patch and it works. 

Goodie. Are there other known problems with silly copy-protection 
schemes?  It migth be worth testing.

However:

> Since I cannot spot any issue, the patch looks good.  Are there any
> other test cases?

Yes. It seems I broke "strace" with it. Probably the difference in system
call trace reporting that Dan Jacobowitz already pointed out.

Now, that should be easily handled by just separating out the cases of 
system call tracing and debug trap handling, and using the old silly code 
for system calls. I'd prefer a cleaner approach, but that seems to be the 
sane thing to do for now.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbUL3TfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbUL3TfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 14:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUL3TfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 14:35:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:44429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261702AbUL3Te6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 14:34:58 -0500
Date: Thu, 30 Dec 2004 11:34:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesse Allen <the3dfxdude@gmail.com>
cc: Davide Libenzi <davidel@xmailserver.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <53046857041230112742acccbe@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <530468570412291343d1478cf@mail.gmail.com>  <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
  <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com> 
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com> 
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Dec 2004, Jesse Allen wrote:
> 
> Using the latest version of the patch on do_syscall_trace(), it still
> doesn't work unless I remove this test.  If indeed it's supposed to
> fall through to receive the proper signal, (ie to single step properly
> after an int op), then removing it is wrong, and I won't consider it
> anymore.  I also have to use the patch shown below, with a typo-fixed,
> to fix the other problem.  I broke it apart from the other because we
> might want to consider it seperately right now.

I'm actually able to now re-create some problems with TF handling with a 
simple non-wine test, and I think I'm zeroing in on the reason for Wine 
breaking. And I think it just happened to work by luck before.

Not only do we have problems single-stepping over a system call, we _also_ 
have problems single-stepping over a "popf" - we'll set TF (to 
single-step), and then afterwards we'll _clear_ TF, even if the "popf" 
also was supposed to set it. 

Working on a patch for this right now, I'll send something out soonish 
(and I'll test it on my test-case before sending it, so that it at least 
has some chance of working).

		Linus

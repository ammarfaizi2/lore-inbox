Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbUL3XPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUL3XPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUL3XPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:15:20 -0500
Received: from one.firstfloor.org ([213.235.205.2]:64435 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261743AbUL3XPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:15:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	<530468570412291343d1478cf@mail.gmail.com>
	<Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
	<Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
	<Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
	<Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
	<Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
	<Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
	<Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
	<Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
	<53046857041230112742acccbe@mail.gmail.com>
	<Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
	<Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Fri, 31 Dec 2004 00:15:11 +0100
In-Reply-To: <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 30 Dec 2004 14:46:17 -0800 (PST)")
Message-ID: <m1mzvvjs3k.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> It's a bit more involved than I'd like, since especially the "popf" case 
> just is pretty complex, but I'd love to hear whether it works.
>
> NOTE NOTE NOTE! I've tested it, but only on one small test-case, so it 
> might be totally broken in many ways. I'd love to have people who are x86 
> and ptrace-aware give this a second look, and I'm confident Jesse will 
> find that it won't work, but can hopefully try to debug it a bit with 
> this..

Just looking at all this complexiy and thinking about
making it work on x86-64 too doesn't exactly give a good
feeling in my spine.

Not to belittle your archivement Linus but it all looks
very overengineered to me.

I think such complex instruction emulation games will be 
hard to maintain and there are very surely bugs in so 
much subtle code. 

Can someone repeat again what was wrong with the old ptrace
semantics before the initial change that caused all these complex
changes?  It seemed to work well for years. How about we just
go back to the old state, revert all the recent ptrace changes 
and skip all that?

e.g. reporting TF after popf in ptrace doesnt really seem like a big
issue to me that is worth fixing with that much code.  It is more an
unimportant corner case, isnt it? Same thing with forcing TF after
popf.  I bet most debuggers in existence get this special case wrong
and so far the world hasn't collapsed because of that.

I would love to skip this all on x86-64, but I would prefer
to not make the behaviour incompatible to i386.

-Andi


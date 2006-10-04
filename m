Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161213AbWJDPMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161213AbWJDPMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbWJDPMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:12:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161213AbWJDPMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:12:24 -0400
Date: Wed, 4 Oct 2006 08:12:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Beulich <jbeulich@novell.com>
cc: Ingo Molnar <mingo@elte.hu>, Eric Rannaud <eric.rannaud@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nagar@watson.ibm.com
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <45239953.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.64.0610040809070.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org> <200609302230.24070.ak@suse.de>
 <Pine.LNX.4.64.0609301344231.3952@g5.osdl.org> <20060930204900.GA576@elte.hu>
 <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org> <45239953.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2006, Jan Beulich wrote:
> 
> Again, a corrupt stack will not allow you getting reliable data out of the
> old unwinder either. Even worse when you consider a stack overflow and
> your request for range checks (or pointers into the stack) - you might not
> get a stack trace then at all.

Who cares?

Not getting data out of a corrupt stack isn't the problem.

Getting an OOPS is the problem.

Jan, did you follow the actual thread at all?

This is _not_ about getting "perfect data". This is about a dead machine 
that was killed not by the original bug, but by the DEBUGGING CODE it 
triggered.

In other words, in this case the debugging code made things harder to 
debug. That's bad, bad, bad. That negates the whole point of having 
debugging code in the first place.

In contrast, the old x86 (32-bit) stack dumper was damn safe. If the 
original %esp was at all a valid pointer (and it had to be, since 
otherwise you'd have gotten a double fault!), it would print out something 
_without_ crapping all over the machine. Maybe it wouldn't print out 
anything nice, but it would never make things WORSE.

See the difference?

			Linus

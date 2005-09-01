Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbVIAILE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVIAILE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVIAILE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:11:04 -0400
Received: from mx1.suse.de ([195.135.220.2]:26500 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965084AbVIAILC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:11:02 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: MAX_ARG_PAGES has no effect?
Date: Thu, 1 Sep 2005 09:26:51 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <4314F761.2050908@kundor.org> <p73psrtr8ho.fsf@verdi.suse.de> <20050901065710.GB5179@elte.hu>
In-Reply-To: <20050901065710.GB5179@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509010926.51749.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 September 2005 08:57, Ingo Molnar wrote:

> the whole thing should be reworked, so that there is no artificial limit
> like MAX_ARG_PAGES. (it is after all just another piece of memory, in
> theory)

Yes, a sysctl would probably lead to fragmentation problems and then
people would do ugly linked lists of buffers like poll.

> If we do unconditional page-flipping then we fragment the argument
> space, if we do both page-flipping if things are unfragmented and
> well-aligned, and 'compact' the layout otherwise, we havent solved the
> problem and have introduced a significant extra layer of complexity to
> an already security-sensitive and fragile piece of code.

Page flipping = COW like fork would do?

Not sure how this would work - the arguments of execve can be anywhere
in the address space and would presumably be often be in a inconvenient
place like in the middle of the stack of the new executable.

> The best method i found was to get rid of bprm->pages[] and to directly
> copy strings into the new mm via kmap (and to follow whatever RAM
> allocation policies/limits there are for the new mm), but that's quite
> ugly.

That sounds better.

-Andi

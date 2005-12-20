Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVLTEtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVLTEtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 23:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLTEtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 23:49:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40620 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750794AbVLTEtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 23:49:06 -0500
Date: Tue, 20 Dec 2005 05:48:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 10/15] Generic Mutex Subsystem, mutex-migration-helper-core.patch
Message-ID: <20051220044823.GA567@elte.hu>
References: <20051219013837.GF28038@elte.hu> <20051219150007.GA9809@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219150007.GA9809@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Dec 19, 2005 at 02:38:37AM +0100, Ingo Molnar wrote:
> > 
> > introduce the mutex_debug type, and switch the semaphore APIs to it in a 
> > type-sensitive way. Plain semaphores will still use the proper 
> > arch-semaphore calls.
> 
> I think we shouldn't introduce this one.  It just encourages people to do
> really things.
        ^---("weird" ?)

ok. I can keep it a separate patch - it's needed for -rt, and it's also 
a good debugging tool to test-drive the mutex implementation.  

historically, i found 90% of the mutex.c bugs by stress-testing it from 
userspace, but a crutial 10% did come from the DEBUG_MUTEX_FULL mode, 
where almost all of the 7000+ semaphore users are switched over to 
mutexes.

but in terms of keeping the upstream kernel code base clean, i agree 
with a clean and separate set of mutex APIs that are introduced into 
subsystems gradually.

>  Everything else in the patchseries looks sensible to me.

great!

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758762AbWLFAYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762AbWLFAYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758614AbWLFAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:24:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42333 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758543AbWLFAYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:24:10 -0500
Date: Wed, 6 Dec 2006 00:24:03 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061206002403.GA4587@ftp.linux.org.uk>
References: <20061204114851.GA25859@elte.hu> <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain> <20061202140521.GJ3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain> <20061202160252.GQ14076@parisc-linux.org> <1165082803.24604.54.camel@localhost.localdomain> <20061202181957.GK3078@ftp.linux.org.uk> <28665.1165234964@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28665.1165234964@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 12:22:44PM +0000, David Howells wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > the question is: which is more important, the type safety of a 
> > container_of() [or type cast], which if we get it wrong produces a 
> > /very/ trivial crash that is trivial to fix

The hell it is.  You get wrong fields of a big struct read and modified.
Silently.

Besides, I can show you fsckloads of cases when we do *NOT* pass a
pointer to struct the timer is embedded into.  Some of them called directly
(and no, the thing they get as argument doesn't point to anything that
would contain a timer_list).

> > structure size all around the kernel? I believe the latter is more 
> > important.
> 
> Indeed yes.

Guys, please, look at actual users of that stuff.

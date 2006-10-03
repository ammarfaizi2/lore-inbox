Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWJCKB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWJCKB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWJCKB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:01:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964854AbWJCKB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:01:58 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061002201836.GB31365@elte.hu> 
References: <20061002201836.GB31365@elte.hu>  <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <20061002132116.2663d7a3.akpm@osdl.org> 
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 03 Oct 2006 11:01:14 +0100
Message-ID: <10243.1159869674@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> i agree that we should do this in one go and in Linus' tree. I suspect 
> David has a script for this, so we can do it anytime for any tree, 
> right?

I wish.  No, it's not simple enough to script.  All the usages of struct
pt_regs have to be eyeballed and have to be poked with the compiler.  The
problem is when an interrupt handler passes regs down to someone else - that I
can't find.

However, I'm now in a position that I can just keep pulling Linus's GIT tree
with StGIT and fixing up the wibbly bits and grepping for new instances of
pt_regs and of course compile testing on a bunch of arches for which I have
compilers.

> the amount of code that truly relies on regs being present is very low. 

The same goes for the IRQ number itself too.  Very few things actually use
that, mostly they just use the arbitrary data argument.  I'm not sure we want
to do the same to that, though, since it makes cascaded PIC processing more
interesting as the IRQ number changes.

David


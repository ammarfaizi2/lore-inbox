Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUCXHbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUCXHbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:31:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63681 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263007AbUCXHbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:31:01 -0500
Date: Wed, 24 Mar 2004 02:28:40 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: davidm@hpl.hp.com
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
Message-ID: <20040324072840.GK31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040323231256.GP4677@tpkurt.garloff.de> <20040323154937.1f0dc500.akpm@osdl.org> <20040324002149.GT4677@tpkurt.garloff.de> <16480.55450.730214.175997@napali.hpl.hp.com> <4060E24C.9000507@redhat.com> <16480.59229.808025.231875@napali.hpl.hp.com> <20040324070020.GI31589@devserv.devel.redhat.com> <16481.13780.673796.20976@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16481.13780.673796.20976@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 11:16:36PM -0800, David Mosberger wrote:
> I'm not following you on the "get ld.so handling free" part.  How is
> that handling free?

What I meant is that it is already written and tested.

> Actually, that's something that worries me.  Somebody just needs to
> succeed in loading any shared object with the right PT_GNU_STACK
> header and then the entire program will be exposed to the risk of a
> writable stack.  On ia64, I just don't see any need to ever implicitly
> turn on execute-permission on the stack, so why allow this extra
> backdoor?

What kind of backdoor is it?  If you dlopen untrusted shared libraries
into your program you have far bigger problem than executable
stack (you can execute any code it wants in its constructors).

If there is a shared library which needs executable stack for its use
(on !IA64 !PPC64 this is e.g. any library which takes address of
a nested function and passes it to some other function and/or stores
it into some variable which cannot be optimized out, on IA64 or PPC64
this is of course much rarer, but it is still possible some language
interpreter or something builds code on the fly on the stack).

	Jakub

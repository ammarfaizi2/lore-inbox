Return-Path: <linux-kernel-owner+w=401wt.eu-S1751215AbWLLKht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWLLKht (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWLLKhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:37:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58800 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbWLLKhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:37:47 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061212032456.23036.qmail@science.horizon.com> 
References: <20061212032456.23036.qmail@science.horizon.com> 
To: linux@horizon.com
Cc: nickpiggin@yahoo.com.au, linux-arch@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Dec 2006 10:37:15 +0000
Message-ID: <13639.1165919835@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:

> do {
> 	oldvalue = ll(addr)
> 	newvalue = ... oldvalue ...
> } while (!sc(addr, oldvalue, newvalue))
> 
> Where sc() could be a cmpxchg.  But, more importantly, if the
> architecture did implement LL/SC, it could be a "try plain SC; if
> that fails try CMPXCHG built out of LL/SC; if that fails, loop"

If sc() is implemented with cmpxchg(), then this is a very silly piece of
code.  cmpxchg() returns the current value if it fails, rendering a repetition
of ll() pointless.  In some circumstances, you should really do it by putting
the cmpxchg() up front with what you expect the most likely substitution to
be, and that then doesn't require the initial load.

David

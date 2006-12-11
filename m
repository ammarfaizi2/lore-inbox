Return-Path: <linux-kernel-owner+w=401wt.eu-S1759658AbWLKCa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759658AbWLKCa5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 21:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762278AbWLKCa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 21:30:57 -0500
Received: from science.horizon.com ([192.35.100.1]:15916 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762265AbWLKCa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 21:30:56 -0500
Date: 10 Dec 2006 21:30:54 -0500
Message-ID: <20061211023054.2622.qmail@science.horizon.com>
From: linux@horizon.com
To: nickpiggin@yahoo.com.au, torvalds@osdl.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an
Cc: linux@horizon.com, linux-arch@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even if ARM is able to handle any arbitrary C code between the
> "load locked" and store conditional API, other architectures can not
> by definition.

Maybe so, but I think you and Linus are missing the middle ground.

While I agree that LL/SC can't be part of the kernel API for people to
get arbitrarily clever with in the device driver du jour, they are *very*
nice abstractions for shrinking the arch-specific code size.

The semantics are widely enough shared that it's quite possible in
practice to write a good set of atomic primitives in terms of LL/SC
and then let most architectures define LL/SC and simply #include the
generic atomic op implementations.

If there's a restriction that would pessimize the generic implementation,
that function can be implemented specially for that arch.

Then implementing things like backoff on contention can involve writing
a whole lot less duplicated code.


Just like you can write a set of helpers for, say, CPUs with physically
addressed caches, even though the "real" API has to be able to handle the
virtually addressed ones, you can write a nice set of helpers for machines
with sane LL/SC.

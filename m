Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVCJNOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVCJNOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 08:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVCJNOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 08:14:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28053 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262257AbVCJNOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 08:14:33 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050310050209.1d95a5dc.akpm@osdl.org> 
References: <20050310050209.1d95a5dc.akpm@osdl.org>  <20050310042217.3ba5b9bc.akpm@osdl.org> <4181.1110456111@redhat.com> <5005.1110459008@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Discard key spinlock and use RCU for key payload [try #3] 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 10 Mar 2005 13:14:14 +0000
Message-ID: <12591.1110460454@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > Do you want me to redo the patch?
> > 
> 
> That, or a delta.  At your convenience.

A new patch is just as easy. There'll be one with you shortly.

> What's your feeling on the stability

Well... it boots:-) That involves creating and destroying keyrings and linking
keyrings into keyrings when knowledge about users other than uid 0 is added to
or removed from the kernel. No other key management code is touched except by
explicit invocation by syscall or from its in-kernel APIs, and no code in the
kernel does that yet.

I've also prodded it with my key utilities; adding keys, requesting keys,
linking keys, unlinking keys, finding keys, revoking keys, expiring keys,
reading keys, listing/describing keys, joining sessions. I've also checked that
user-defined keys work using that same set of tools. These tools can be found
at:

	http://people.redhat.com/~dhowells/keys/key-utils.tar.bz2

I've worked them into a form more suitable for release. I still need to write
documentation/manual pages and a spec file, and to get it to run on more than
just i386, ppc and ppc64.

> &&priority of this work?

Well... this changes the API for key type implementations, if only in the way
locking is used. Various people are looking at using keys for various things,
and this change will affect all of them.

David

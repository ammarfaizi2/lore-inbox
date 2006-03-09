Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWCILlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWCILlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbWCILlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:41:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54948 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751831AbWCILlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:41:24 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1141855305.10606.6.camel@localhost.localdomain> 
References: <1141855305.10606.6.camel@localhost.localdomain>  <20060308161829.GC3669@elf.ucw.cz> <31492.1141753245@warthog.cambridge.redhat.com> <24309.1141848971@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 09 Mar 2006 11:41:02 +0000
Message-ID: <24280.1141904462@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > The LOCK and UNLOCK functions presumably make at least one memory write apiece
> > to manipulate the target lock (on SMP at least).
> 
> No they merely perform the bus transactions neccessary to perform an
> update atomically. They are however "serializing" instructions which
> means they do cause a certain amount of serialization (see the intel
> architecture manual on serializing instructions for detail).
> 
> Athlon and later know how to turn it from locked memory accesses into
> merely an exclusive cache line grab.

So, you're saying that the LOCK and UNLOCK primitives don't actually modify
memory, but rather simply pin the cacheline into the CPU's cache and refuse to
let anyone else touch it?

No... it can't work like that. It *must* make a memory modification - after
all, the CPU doesn't know that what it's doing is a spin_unlock(), say, rather
than an atomic_set().

David

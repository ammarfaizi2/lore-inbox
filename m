Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWCIMXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWCIMXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWCIMXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:23:51 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5326 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751846AbWCIMXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:23:50 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <24280.1141904462@warthog.cambridge.redhat.com>
References: <1141855305.10606.6.camel@localhost.localdomain>
	 <20060308161829.GC3669@elf.ucw.cz>
	 <31492.1141753245@warthog.cambridge.redhat.com>
	 <24309.1141848971@warthog.cambridge.redhat.com>
	 <24280.1141904462@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Mar 2006 12:28:59 +0000
Message-Id: <1141907339.16745.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-09 at 11:41 +0000, David Howells wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> So, you're saying that the LOCK and UNLOCK primitives don't actually modify
> memory, but rather simply pin the cacheline into the CPU's cache and refuse to
> let anyone else touch it?

Basically yes

> No... it can't work like that. It *must* make a memory modification 

Then you'll have to argue with the chip designers because it doesn't.

Its all built around the cache coherency. To make a write to a cache
line I must be the sole owner of the line. Look up "MESI cache" in a
good book on the subject.

If we own the affected line then we can update just the cache and be
sure that since we own the cache line and we will write it back if
anyone else asks for it (or nowdays on some systems transfer it direct
to the other cpu) that we get locked semantics


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWCHWK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWCHWK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWCHWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:10:59 -0500
Received: from ozlabs.org ([203.10.76.45]:9098 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932464AbWCHWK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:10:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.21589.385336.68518@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 09:01:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@redhat.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
In-Reply-To: <20060308145506.GA5095@devserv.devel.redhat.com>
References: <31492.1141753245@warthog.cambridge.redhat.com>
	<29826.1141828678@warthog.cambridge.redhat.com>
	<20060308145506.GA5095@devserv.devel.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> On Wed, Mar 08, 2006 at 02:37:58PM +0000, David Howells wrote:
> > + (*) reads can be done speculatively, and then the result discarded should it
> > +     prove not to be required;
> 
> That might be worth an example with an if() because PPC will do this and if 
> its a read with a side effect (eg I/O space) you get singed..

On PPC machines, the PTE has a bit called G (for Guarded) which
indicates that the memory mapped by it has side effects.  It prevents
the CPU from doing speculative accesses (i.e. the CPU can't send out a
load from the page until it knows for sure that the program will get
to that instruction) and from prefetching from the page.

The kernel sets G=1 on MMIO and PIO pages in general, as you would
expect, although you can get G=0 mappings for framebuffers etc. if you
ask specifically for that.

Paul.

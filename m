Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWCHWLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWCHWLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWCHWLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:11:00 -0500
Received: from ozlabs.org ([203.10.76.45]:9354 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932603AbWCHWK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:10:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.22121.254026.487964@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 09:10:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
In-Reply-To: <10095.1141838381@warthog.cambridge.redhat.com>
References: <20060308154157.GI7301@parisc-linux.org>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<29826.1141828678@warthog.cambridge.redhat.com>
	<20060308145506.GA5095@devserv.devel.redhat.com>
	<10095.1141838381@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> > # define smp_read_barrier_depends()     do { } while(0)
> 
> What's this one meant to do?

On most CPUs, if you load one value and use the value you get to
compute the address for a second load, there is an implicit read
barrier between the two loads because of the dependency.  That's not
true on alpha, apparently, because of the way their caches are
structured.  The smp_read_barrier_depends is a read barrier that you
use between two loads when there is already a dependency between the
loads, and it is a no-op on everything except alpha (IIRC).

Paul.

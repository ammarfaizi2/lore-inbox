Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751724AbWCCWWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWCCWWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWCCWWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:22:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751724AbWCCWWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:22:19 -0500
Date: Fri, 3 Mar 2006 14:21:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin LaHaise <bcrl@linux.intel.com>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, mingo@redhat.com, jblunck@suse.de, matthew@wil.cx,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <20060303215114.GA13893@linux.intel.com>
Message-ID: <Pine.LNX.4.64.0603031415330.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>
 <32518.1141401780@warthog.cambridge.redhat.com> <1146.1141404346@warthog.cambridge.redhat.com>
 <5041.1141417027@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603031332140.22647@g5.osdl.org>
 <20060303215114.GA13893@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Mar 2006, Benjamin LaHaise wrote:
> 
> Actually, no.  At least in testing an implementation of Dekker's and 
> Peterson's algorithms as a replacement for the locked operation in 
> our spinlocks, it is absolutely necessary to have an sfence in the lock 
> to ensure the lock is visible to the other CPU before proceeding.

I suspect you have some bug in your implementation. I think Dekker's 
algorithm depends on the reads and writes being ordered, and you don't 
seem to do that.

The thing is, you pretty much _have_ to be wrong, because the x86-64 
memory ordering rules are _exactly_ the same as for x86, and we've had 
that simple store as an unlock for a long long time.

		Linus

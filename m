Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268087AbUHFE7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268087AbUHFE7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUHFE7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:59:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:11912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268087AbUHFE7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:59:35 -0400
Date: Thu, 5 Aug 2004 21:58:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Halcrow <lkml@halcrow.us>
cc: James Morris <jmorris@redhat.com>, Jean-Luc Cooke <jlcooke@certainkey.com>,
       "David S. Miller" <davem@redhat.com>, cryptoapi@lists.logix.cz,
       Michal Ludvig <mludvig@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
In-Reply-To: <20040806020313.GA21309@halcrow.us>
Message-ID: <Pine.LNX.4.58.0408052155180.24588@ppc970.osdl.org>
References: <20040805194914.GC23994@certainkey.com>
 <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com>
 <20040806020313.GA21309@halcrow.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2004, Michael Halcrow wrote:
> 
> I often have a virtual address to work with in the first place, and
> the data that I hash usually occupies less than one page (passphrases,
> keys, etc.).

Ehh. A lot of encryption algorithms are not re-entrant, which means that 
you can't take page faults in the middle without serious trouble.

And if the data is smaller than a page, then it's cheaper to just copy it
into kernel memory than it is to try to follow the page tables by hand.  
One is usually nice cached accesses, the other one is nasty code with
locking and often totally uncached.

So I'd strongly suggest against doing any "raw crypto access". Zero-copy
is often just a complicated way of doing things slowly, all in the name of
some benchmark performance.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbUK3WuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbUK3WuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUK3WuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:50:09 -0500
Received: from waste.org ([209.173.204.2]:48548 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262383AbUK3Wtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:49:40 -0500
Date: Tue, 30 Nov 2004 14:48:51 -0800
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130224851.GH8040@waste.org>
References: <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <1101828924.26071.172.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org> <1101832116.26071.236.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org> <1101837135.26071.380.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 10:21:52AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 30 Nov 2004, David Woodhouse wrote:
> > 
> > The idea in the proposal which David posted, which seemed perfectly
> > specific enough to me, was to move all the user-visible parts to
> > separate header files in a separate directory.
> 
> You call _that_ specific?
> 
> Hell no. You need to do it without breaking existing uses, as noted 
> earlier, and it's not specific at all. "all user visible parts" is a big 
> undertaking, if you can't make it smaller than that, then forget about it.

So we follow dhowell's plan with the following additions:

a) during the transition, include/linux/foo.h includes
include/user/foo.h if it exists and similarly for asm-*
b) when include/user is deemed sufficiently populated, a flag day is
declared and links from /usr/include are switched to them
c) #define __KERNEL__ is dropped from the compile
d) extraneous include/user/* includes are removed from include/linux
(though they'll often make perfect sense)

Step b) may be a long time in coming, but for interfaces where kernel
headers are frequently abused, we can start feeling benefits.

> Basic rule in kernel engineering: you don't just rewrite the world. You do
> it in incremental independent steps.

Even so, it's sometimes important for everyone to agree on a
destination before they set out..

--
Mathematics is the supreme nostalgia of our time.

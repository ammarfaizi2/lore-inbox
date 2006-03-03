Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWCCVen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWCCVen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWCCVen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:34:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751314AbWCCVel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:34:41 -0500
Date: Fri, 3 Mar 2006 13:31:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: Memory barriers and spin_unlock safety 
In-Reply-To: <5001.1141416935@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603031329350.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org> 
 <32518.1141401780@warthog.cambridge.redhat.com>  <5001.1141416935@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Mar 2006, David Howells wrote:
> 
> So in the example I gave, a read after the spin_unlock() may actually get
> executed before the store in the spin_unlock(), but a read before the unlock
> will not get executed after.

Yes.

> > No. Issuing a read barrier on one CPU will do absolutely _nothing_ on the 
> > other CPU.
> 
> Well, I think you mean will guarantee absolutely _nothing_ on the other CPU for
> the Linux kernel.  According to the IBM powerpc book I have, it does actually
> do something on the other CPUs, though it doesn't say exactly what.

Yeah, Power really does have some funky stuff in their memory ordering. 
I'm not quite sure why, though. And it definitely isn't implied by any of 
the Linux kernel barriers.

(They also do TLB coherency in hw etc strange things).

		Linus

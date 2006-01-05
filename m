Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWAECwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWAECwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWAECwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:52:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750852AbWAECwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:52:46 -0500
Date: Wed, 4 Jan 2006 18:51:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolas Pitre <nico@cam.org>
cc: Joel Schopp <jschopp@austin.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
In-Reply-To: <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com>
 <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Jan 2006, Nicolas Pitre wrote:

> On Wed, 4 Jan 2006, Joel Schopp wrote:
> 
> > > this is version 14 of the generic mutex subsystem, against v2.6.15.
> > > 
> > > The patch-queue consists of 21 patches, which can also be downloaded from:
> > > 
> > >   http://redhat.com/~mingo/generic-mutex-subsystem/
> > > 
> > 
> > Took a glance at this on ppc64.  Would it be useful if I contributed an arch
> > specific version like arm has?  We'll either need an arch specific version or
> > have the generic changed.
> 
> Don't change the generic version.  You should provide a ppc specific 
> version if the generic ones don't look so good.

Well, if the generic one generates _buggy_ code on ppc64, that means that 
either the generic version is buggy, or one of the atomics that it uses is 
buggily implemented on ppc64.

And I think it's the generic mutex stuff that is buggy. It seems to assume 
memory barriers that aren't valid to assume.

A mutex is more than just updating the mutex count properly. You also have 
to have the proper memory barriers there to make sure that the things that 
the mutex _protects_ actually stay inside the mutex.

So while a ppc64-optimized mutex is probably a good idea per se, I think 
the generic mutex code had better be fixed first and regardless of any 
optimized version.

On x86/x86-64, the locked instructions automatically imply the proper 
memory barriers, but that was just lucky, I think.

			Linus

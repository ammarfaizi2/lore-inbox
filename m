Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWCGR4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWCGR4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWCGR4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:56:50 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:1971 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1751302AbWCGR4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:56:49 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Memory barriers and spin_unlock safety
Date: Tue, 7 Mar 2006 09:56:16 -0800
User-Agent: KMail/1.9.1
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, ak@suse.de, mingo@redhat.com, jblunck@suse.de,
       bcrl@linux.intel.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <5041.1141417027@warthog.cambridge.redhat.com> <31420.1141753019@warthog.cambridge.redhat.com> <20060307174057.GD7301@parisc-linux.org>
In-Reply-To: <20060307174057.GD7301@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603070956.16763.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 7, 2006 9:40 am, Matthew Wilcox wrote:
> On Tue, Mar 07, 2006 at 05:36:59PM +0000, David Howells wrote:
> > David Howells <dhowells@redhat.com> wrote:
> > > I suspect, then, that x86_64 should not have an SFENCE for
> > > smp_wmb(), and that only io_wmb() should have that.
> >
> > Hmmm... We don't actually have io_wmb()... Should the following be
> > added to all archs?
> >
> > 	io_mb()
> > 	io_rmb()
> > 	io_wmb()
>
> it's spelled mmiowb(), and reads from IO space are synchronous, so
> don't need barriers.

To expand on willy's note, the reason it's called mmiowb as opposed to 
iowb is because I/O port acccess (inX/outX) are inherently synchronous 
and don't need barriers.  mmio writes, however (writeX) need barrier 
operations to ensure ordering on some platforms.

This raises the question of what semantics the unified I/O mapping 
routines have... are ioreadX/iowriteX synchronous or should we define 
the barriers you mention above for them?  (IIRC ppc64 can use an io read 
ordering op).

Jesse

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUG2SWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUG2SWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUG2SUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:20:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:10399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264937AbUG2STL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:19:11 -0400
Date: Thu, 29 Jul 2004 11:17:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ebiederm@xmission.com, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-Id: <20040729111728.5d2bb5c8.akpm@osdl.org>
In-Reply-To: <1091109427.865.1.camel@localhost.localdomain>
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<1091055311.31923.3.camel@localhost.localdomain>
	<20040728172204.2ecc5cdd.akpm@osdl.org>
	<1091109427.865.1.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Iau, 2004-07-29 at 01:22, Andrew Morton wrote:
> > eh?  People do care.  The point here is that we should stop the DMA in the
> > dump kernel, not from within the broken kernel.
> 
> And pray just how do you expect to prove that the dump kernel isnt
> being overwritten *as* it is being loaded.

It was preloaded.

Of course, there's an assumption here that the dead kernel doesn't scribble
on pages which were never available to its page allocator.  If DMA somehow
goes off and scribbles on the dump kernel we lose.

> > btw, if we simply insert a five-second-pause, what problems does that
> > leave?  Network Rx, which is OK.  Disk writes will have completed (?). 
> > What remains?
> 
> Network RX is the obvious one since we've no idea where the DMA is
> going in memory.

See above.  We assume that network RX DMA won't be scribbling in the 16MB
which was pre-reserved.  That's reasonable.  We _have_ to assume that.

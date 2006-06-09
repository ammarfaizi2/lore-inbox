Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWFIR6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWFIR6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWFIR6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:58:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:659 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030289AbWFIR6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:58:48 -0400
Message-ID: <4489B6D1.1030600@garzik.org>
Date: Fri, 09 Jun 2006 13:58:41 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609174405.GA10524@thunk.org>
In-Reply-To: <20060609174405.GA10524@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> And in any case, this is why we have to think very carefully before
> forking the codebase between ext3 and "ext4".  The work that we might
> use to slim down ext4_inode_info would also have to be backported to
> ext3_inode_info before ext3 users see the benefit.  And there may also

No, the entire point is that you stop backporting all the junk, and just 
leave ext3 as is.  Let it sit, let it stabilize.

New development -- including inode slimming work -- can be best done in 
ext4.  With ext3, you are fighting all those old back-compat features 
and associated code paths bloating up the in-core inode [code].

_Obviously_ there may be bugs found in three codebases, rather than two. 
  But over time those will trickle off, particularly when developers 
successfully resist the urge to continue modifying ext[23].

There will always newer, bigger storage situations and arrays, and I 
think it's a mistake to continue modifying the same Linux filesystem to 
support all these situations.  The logical end result is a big, unwieldy 
codebase that supports $N metadata, data, and journal formats.

In the same way we don't stuff support for all PCI ethernet or SATA 
drivers into the same .o file, we shouldn't keep stuffing support for 
all these varying filesystem formats into ext3.o.  That creates (and 
extents exacerbate) the "what ext3 fs am I mounting, today?" support 
problem.

	Jeff



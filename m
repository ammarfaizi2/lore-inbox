Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVDLNC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVDLNC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVDLNBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:01:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38636 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262420AbVDLMvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:51:01 -0400
Subject: Re: [Ext2-devel] Re: OOM problems on 2.6.12-rc1 with many fsx tests
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mingming Cao <cmm@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       mjbligh@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       janetinc@us.ibm.com, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050405182325.5297ff87.akpm@osdl.org>
References: <20050315204413.GF20253@csail.mit.edu>
	 <20050316003134.GY7699@opteron.random>
	 <20050316040435.39533675.akpm@osdl.org>
	 <20050316183701.GB21597@opteron.random>
	 <1111607584.5786.55.camel@localhost.localdomain>
	 <20050403183544.7c31f85c.akpm@osdl.org>
	 <1112633417.3703.8.camel@dyn318043bld.beaverton.ibm.com>
	 <20050404130441.53ab480b.akpm@osdl.org>
	 <1112720671.3522.6.camel@dyn9047017080.beaverton.ibm.com>
	 <20050405182325.5297ff87.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113310228.2404.48.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 12 Apr 2005 13:50:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-06 at 02:23, Andrew Morton wrote:

> Nobody has noticed the now-fixed leak since 2.6.6 and this one appears to
> be 100x slower.  Which is fortunate because this one is going to take a
> long time to fix.  I'll poke at it some more.

OK, I'm now at the stage where I can kick off that fsx test on a kernel
without your leak fix, kill it, umount and get

Whoops: found 43 unfreeable buffers still on the superblock debug list
for sb 00000100296b2d48.  Tracing one...
buffer trace for buffer at 0x000001003edaa9c8 (I am CPU 0)
...

with a trace pointing to journal_unmap_buffer().  I'll try with the fix
in place to see if there are any other cases showing up with the same
problem.

--Stephen


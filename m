Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424278AbWKPQZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424278AbWKPQZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424276AbWKPQZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:25:48 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:4301 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1424278AbWKPQZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:25:47 -0500
X-AuditID: 7f000001-a3337bb000002674-ac-455c910a2a03 
Date: Thu, 16 Nov 2006 16:26:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: cmm@us.ibm.com, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <20061116011351.1401a00f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611161610050.19040@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
 <20061114113120.d4c22b02.akpm@osdl.org> <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
 <20061115232228.afaf42f2.akpm@osdl.org> <1163666960.4310.40.camel@localhost.localdomain>
 <20061116011351.1401a00f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Nov 2006 16:25:46.0272 (UTC) FILETIME=[DE9C6200:01C7099B]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Andrew Morton wrote:
> On Thu, 16 Nov 2006 00:49:20 -0800
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> > That does not explain the repeated reservation window add and remove
> > behavior Huge has reported. 
> 
> I spent quite some time comparing with ext3.  I'm a bit stumped and I'm
> suspecting that the simplistic porting the code is now OK, but something's
> just wrong.
> 
> I assume that the while (1) loop in ext3_try_to_allocate_with_rsv() has
> gone infinite.  I don't see why, but more staring is needed.

Just to report that similar tests on three machines have each run
for 20 hours so far without any such infinite loop reoccurring.

Well, I broke off the x86_64 for a couple of hours: wondered if I'd got
confused, forgotten to "rmmod ext2" at one stage, and saw that behaviour
with my simple "ext2fs_blk_t ret_block" patch, rather than your more
extensive patch to ext2_new_blocks() that I'd believed I was testing.
I didn't give it long enough to be conclusive, but the problem didn't
show up with that either, so I've gone back to testing with yours.

I'd have kept the hang around for longer if I'd guessed it would be
hard to reproduce, and that it would be puzzling even to you: sorry.
kdb is in, if it comes again I can peer at it more closely.

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936064AbWK1TgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936064AbWK1TgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936065AbWK1TgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:36:19 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:47303 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S936064AbWK1TgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:36:18 -0500
Subject: Re: [PATCH 2/6] ext2 balloc: reset windowsz when full
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611281740110.29701@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
	 <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
	 <20061116132724.1882b122.akpm@osdl.org>
	 <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
	 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
	 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611281740110.29701@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 28 Nov 2006 11:36:14 -0800
Message-Id: <1164742574.3769.35.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 17:40 +0000, Hugh Dickins wrote:
> ext2_new_blocks should reset the reservation window size to 0 when squeezing
> the last blocks out of an almost full filesystem, so the retry doesn't skip
> any groups with less than half that free, reporting ENOSPC too soon.
> 

I realize this is a bug when I was looking at the code as well. I was
thinking we should not check for whether the window size is less than
the free blocks counter at all, when the allocation is fall back to non
reservation allocation. But your fix works as well.


Mingming




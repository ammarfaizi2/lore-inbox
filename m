Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965928AbWKNVT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965928AbWKNVT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965997AbWKNVT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:19:58 -0500
Received: from dvhart.com ([64.146.134.43]:16263 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965928AbWKNVT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:19:57 -0500
Message-ID: <455A32FC.4000409@mbligh.org>
Date: Tue, 14 Nov 2006 13:19:56 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie> <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> <20061114113120.d4c22b02.akpm@osdl.org> <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 14 Nov 2006, Andrew Morton wrote:
>> The below might help.
> 
> Indeed it does (with Martin's E2FSBLK warning fix),
> seems to be running well on all machines now.
> 
> (Of course, my ext2_fsblk_t ext2_new_blocks() notion did not pan out,
> for same reason as the original: that ret_block was expected signed.)

Whilst I've got all the smart people looking at this ...

/*max window size: 1024(direct blocks) + 3([t,d]indirect blocks) */
#define EXT2_MAX_RESERVE_BLOCKS         1027

Is that wrong? If it's meaning one triple, one double, and one single
indirect block, surely it can span a boundary, so we need (potentially)
two of each?

M.

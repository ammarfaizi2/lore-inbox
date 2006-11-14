Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933493AbWKNTLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933493AbWKNTLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933494AbWKNTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:11:07 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:37845 "EHLO
	extu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S933493AbWKNTLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:11:04 -0500
X-AuditID: d80ac287-a276ebb000002ee7-13-455a14c8450a 
Date: Tue, 14 Nov 2006 19:11:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mel Gorman <mel@skynet.ie>
cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <20061114184919.GA16020@skynet.ie>
Message-ID: <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Nov 2006 19:11:03.0628 (UTC) FILETIME=[A0FD50C0:01C70820]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, Mel Gorman wrote:
> 2.6.19-rc5-mm2
> 
> Am seeing errors with systems using ext2. First machine is a plan old x86
> using initramfs. Console output looks like;
> ...
> Configuring network interfaces...BUG: soft lockup detected on CPU#3!
> ...
>  [<c01b3b80>] ext2_try_to_allocate+0xdb/0x152
>  [<c01b3e72>] ext2_try_to_allocate_with_rsv+0x4b/0x1b2
> 
> I've not investigated yet what patches might be at fault.

I expect you'll find it's
ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3.patch
which gets stuck in a loop there for me too: back it out and all seems fine.

It's not obvious which part of the patch is to blame: mostly it's
cleanup, but a few variables do change size: I'm currently narrowing
down to where a fix is needed.

Hugh

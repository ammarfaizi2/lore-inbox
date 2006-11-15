Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbWKOOQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbWKOOQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWKOOQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:16:44 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:21482 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1030490AbWKOOQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:16:43 -0500
X-AuditID: 7f000001-a4739bb000002674-50-455b214b79ea 
Date: Wed, 15 Nov 2006 14:17:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
 <20061114113120.d4c22b02.akpm@osdl.org> <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Nov 2006 14:16:43.0183 (UTC) FILETIME=[ACF503F0:01C708C0]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, Hugh Dickins wrote:
> On Tue, 14 Nov 2006, Andrew Morton wrote:
> > 
> > The below might help.
> 
> Indeed it does (with Martin's E2FSBLK warning fix),
> seems to be running well on all machines now.

i386 and ppc64 still doing builds, but after an hour on x86_64,
an ld got stuck in a loop under ext2_try_to_allocate_with_rsv,
alternating between ext2_rsv_window_add and rsv_window_remove.
Send me a patch and I'll try it...

ext2_try_to_allocate_with_rsv+0x288
ext2_new_blocks+0x21e
ext2_get_blocks+0x398
ext2_get_block+0x46
__block_prepare_write+0x171
block_prepare_write+0x39
ext2_prepare_write+0x2c
generic_file_buffered_write+0x2b0
__generic_file_aio_write_nolock+0x4bc
generic_file_aio_write+0x6d
do_sync_write+0xf9
vfs_write+0xc8
sys_write+0x51

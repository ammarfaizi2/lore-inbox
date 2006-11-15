Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030588AbWKOPec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbWKOPec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbWKOPec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:34:32 -0500
Received: from dvhart.com ([64.146.134.43]:42899 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030588AbWKOPeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:34:31 -0500
Message-ID: <455B330F.7050102@mbligh.org>
Date: Wed, 15 Nov 2006 07:32:31 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie> <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> <20061114113120.d4c22b02.akpm@osdl.org> <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com> <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 14 Nov 2006, Hugh Dickins wrote:
>> On Tue, 14 Nov 2006, Andrew Morton wrote:
>>> The below might help.
>> Indeed it does (with Martin's E2FSBLK warning fix),
>> seems to be running well on all machines now.
> 
> i386 and ppc64 still doing builds, but after an hour on x86_64,
> an ld got stuck in a loop under ext2_try_to_allocate_with_rsv,
> alternating between ext2_rsv_window_add and rsv_window_remove.

Ugh. What test are you doing? kernel compile in a tight loop forever?

Andrew, do you want to drop the set for now, and we can try and
debug it outside of -mm? No reason to break your tree if we don't
have to ...

> Send me a patch and I'll try it...
> 
> ext2_try_to_allocate_with_rsv+0x288
> ext2_new_blocks+0x21e
> ext2_get_blocks+0x398
> ext2_get_block+0x46
> __block_prepare_write+0x171
> block_prepare_write+0x39
> ext2_prepare_write+0x2c
> generic_file_buffered_write+0x2b0
> __generic_file_aio_write_nolock+0x4bc
> generic_file_aio_write+0x6d
> do_sync_write+0xf9
> vfs_write+0xc8
> sys_write+0x51


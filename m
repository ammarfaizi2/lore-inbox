Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVK0HZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVK0HZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 02:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVK0HZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 02:25:14 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:13447 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750918AbVK0HZM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 02:25:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=liBpkmao3UhcyVCo/tFJwBlcRKZvBT8lMicdMYnyPhiRchMq47+juyeyNWGss2kXn3roraADbO3dOiJZrKRGxJ27GUcBK0V7xrs0Gs9fGkQU5JGgePYDivwchMGpU93BaZtkvqVdhoUa8XhIpubZa+zInhrn8VL34xa1vQHxkjQ=
Message-ID: <a44ae5cd0511262325p43ba1fcbxfea0ac698824403d@mail.gmail.com>
Date: Sat, 26 Nov 2005 23:25:11 -0800
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: 2.6.15-rc2-git6 + ipw2200 1.0.8 -- Slab corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[4295910.815000] ipw2200: Firmware error detected.  Restarting.
[4295910.815000] ipw2200: Sysfs 'error' log captured.
[4295938.038000] Slab corruption: start=ed68ebf8, len=2048
[4295938.038000] Redzone: 0x5a2cf071/0x3c07fbbe.
[4295938.038000] Last user: [<52065000>](0x52065000)
[4295938.038000] 760: 8c 00 00 00 76 fb 07 3c 92 03 00 00 88 00 00 00
[4295938.039000] 770: 7f fb 07 3c 01 00 00 00 8a 00 00 00 82 fb 07 3c
[4295938.039000] 780: 9c 02 00 00 8a 00 00 00 88 fb 07 3c 01 02 00 00
[4295938.039000] 790: 54 00 00 00 8c fb 07 3c 77 01 00 00 51 00 00 00
[4295938.039000] 7a0: 98 fb 07 3c 07 00 00 00 52 00 00 00 9b fb 07 3c
[4295938.039000] 7b0: 05 00 00 00 53 00 00 00 9e fb 07 3c 05 00 00 00
[4295938.039000] Prev obj: start=ed68e3ec, len=2048
[4295938.039000] Redzone: 0x170fc2a5/0x170fc2a5.
[4295938.039000] Last user:
[<f92a40a6>](ipw_alloc_error_log+0x114/0x208 [ipw2200])
[4295938.039000] 000: 9f 65 0e 00 e0 00 00 80 46 03 00 00 05 00 00 00
[4295938.039000] 010: 80 00 00 00 08 e4 68 ed 58 f3 68 ed 06 00 00 00
[4295938.039000] Next obj: start=ed68f404, len=2048
[4295938.039000] Redzone: 0x8b/0x170fc2a5.
[4295938.039000] Last user: [<c02835ae>](tty_write+0xf6/0x21e)
[4295938.039000] 000: c3 fb 07 3c 62 00 00 00 20 00 00 00 06 fc 07 3c
[4295938.039000] 010: 08 00 00 00 23 00 00 00 11 fc 07 3c 06 00 00 00
[4295938.039000] slab error in cache_alloc_debugcheck_after(): cache
`size-2048': double free, or memory outside object was overwritten
[4295938.039000]  [<c0103f06>] dump_stack+0x1e/0x20
[4295938.039000]  [<c014bc9d>] __slab_error+0x2f/0x31
[4295938.039000]  [<c014df78>] cache_alloc_debugcheck_after+0xe2/0x159
[4295938.039000]  [<c014e432>] __kmalloc+0xae/0xfe
[4295938.039000]  [<c030385c>] __alloc_skb+0x52/0x153
[4295938.039000]  [<c03022e5>] sock_alloc_send_pskb+0xfb/0x229
[4295938.039000]  [<c0302441>] sock_alloc_send_skb+0x2e/0x30
[4295938.039000]  [<c03649ef>] unix_stream_sendmsg+0x1ed/0x3e0
[4295938.039000]  [<c02ff0dc>] sock_aio_write+0xeb/0x12a
[4295938.039000]  [<c0164421>] do_sync_write+0xae/0xfd
[4295938.039000]  [<c0164604>] vfs_write+0x194/0x19b
[4295938.039000]  [<c01646c0>] sys_write+0x47/0x6e
[4295938.039000]  [<c010304b>] sysenter_past_esp+0x54/0x75
[4295938.039000] ed68ebf4: redzone 1: 0x5a2cf071, redzone 2: 0x3c07fbbe.

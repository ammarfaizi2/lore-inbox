Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTLBECv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 23:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTLBECv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 23:02:51 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:43700 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S264303AbTLBECr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 23:02:47 -0500
Message-ID: <3FCC0EE0.9010207@backtobasicsmgmt.com>
Date: Mon, 01 Dec 2003 21:02:40 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de> <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de>
In-Reply-To: <20031201155143.GF12211@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> Alright, so no bouncing should be happening. Could you boot with
> mem=800m (and reproduce) just to rule it out completely?

Tested with mem=800m, problem still occurs. Additional test was done 
without device-mapper in place, though, and I could not reproduce the 
problem! I copied > 500MB of stuff to the XFS filesystem created using 
the entire /dev/md/0 device without a single unusual message. I then 
unmounted the filesystem and used pvcreate/vgcreate/lvcreate to make a 
3G volume on the array, made an XFS filesystem on it, mounted it, and 
tried copying data over. The oops message came back.

I'm copying this message to linux-lvm; the original oops message is 
repeated below for the benefit of those list readers. I've got one more 
round of testing to do (after the array resyncs itself), which is to try 
a filesystem other than XFS.

----

kernel BUG at fs/bio.c:177!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014db9a>]    Not tainted
EFLAGS: 00010246
EIP is at bio_put+0x2c/0x36
eax: 00000000   ebx: f6221080   ecx: c1182180   edx: edcbf780
esi: c577b998   edi: 00000002   ebp: edcbf780   esp: f78ffeb0
ds: 007b   es: 007b   ss: 0068
Process md0_raid5 (pid: 65, threadinfo=f78fe000 task=f7924080)
Stack: c71e2640 c021d88d edcbf780 00000000 00000001 c1182180 00000009 
0001000
        edcbf780 00000000 00000000 00000000 c014e2fc edcbf780 00000000 
00000000
        f23a0ff0 f23a0ff0 edcbf7c0 c02ca51d edcbf780 00000000 00000000 
00000000
Call Trace:
  [<c021d88d>] bio_end_io_pagebuf+0x9a/0x138
  [<c014e2fc>] bio_endio+0x59/0x7e
  [<c02ca51d>] clone_endio+0x82/0xb5
  [<c02c0dc3>] handle_stripe+0x8f2/0xec0
  [<c02c17d1>] raid5d+0x71/0x105
  [<c02c898c>] md_thread+0xde/0x15c
  [<c011984b>] default_wake_function+0x0/0x12
  [<c02c88ae>] md_thread+0x0/0x15c
  [<c0107049>] kernel_thread_helper+0x5/0xb

Code: 0f 0b b1 00 bc 94 34 c0 eb d8 56 53 83 ec 08 8b 44 24 18 8b



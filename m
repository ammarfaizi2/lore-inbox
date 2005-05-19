Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVESOLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVESOLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVESOLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:11:03 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:54830 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262506AbVESOKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:10:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SBv8/xgqQRV8xzKQwmu/dlJ1MRbP3ByiAk5fRP/uRqs3EsFaAEx0+7CuE5CcgcmRqM5pGgibR7bYfiKzGgTBqxhF5K18BBiMWLN8y6IX/03XJputwmUhmKiKhYMkCqH65Va3TY0crXPyPcFLbfFYtfmwq3zij8zzqYSwoSWbt8w=
Message-ID: <428C9E64.4010905@gmail.com>
Date: Thu, 19 May 2005 09:10:44 -0500
From: "Berck E. Nash" <flyboy@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Saveliev <vs@namesys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Scheduling while atomic lockups, Reiser4, DAC960
References: <428A40EC.8050206@gmail.com>  <428A68BC.1020303@namesys.com> <1116483531.13501.276.camel@tribesman.namesys.com>
In-Reply-To: <1116483531.13501.276.camel@tribesman.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev wrote:

> Please try to patch -R the patch 
> ftp://ftp.ru.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/broken-out/reiser4-sb_sync_inodes-cleanup.patch
> or use 2.6.12-rc4-mm2

Been using rc-mm2 since yesterday and it all seems good.  Thank you!

> 
>>>Debian unstable, AMD Athlon
>>>
>>>The error seems to occur with my reiser4 partition.   The physical
>>>device is  an 8-disk RAID-0 array on a Mylex Extreme RAID 1100 using the
>>>DAC960 driver.  The error is sometimes followed by a lockup, but not always.
>>>
>>>Not sure if it's a hardware problem or kernel problem.
>>>
>>>There's pages and pages of errors that look like this.  If there's
>>>anything I can do to provide more information, I will gladly do so.
>>>
>>>Just a user, not a hacker.  I'm not subscribed to the list, so cc's on
>>>reply would be appreciated.
>>>
>>>Thanks,
>>>Berck
>>>
>>>scheduling while atomic: pdflush/0xffffffff/92
>>>May 16 03:36:43 luna kernel:  [<c02f6ac4>] schedule+0x604/0x610
>>>May 16 03:36:43 luna kernel:  [<c02f6265>] __down+0x85/0x120
>>>May 16 03:36:43 luna kernel:  [<c0115020>] default_wake_function+0x0/0x10
>>>May 16 03:36:43 luna kernel:  [<c02f645f>] __down_failed+0x7/0xc
>>>May 16 03:36:43 luna kernel:  [<c024b420>] blk_backing_dev_unplug+0x0/0x10
>>>May 16 03:36:43 luna kernel:  [<c01c5ca3>] .text.lock.flush_queue+0x8/0x25
>>>May 16 03:36:43 luna kernel:  [<c01c5524>] finish_fq+0x14/0x40
>>>May 16 03:36:43 luna kernel:  [<c01c55ae>] finish_all_fq+0x5e/0xa0
>>>May 16 03:36:43 luna kernel:  [<c01c560e>]
>>>current_atom_finish_all_fq+0x1e/0x70
>>>May 16 03:36:43 luna kernel:  [<c01c167c>] reiser4_write_logs+0x20c/0x2b0
>>>May 16 03:36:43 luna kernel:  [<c01ba599>] commit_current_atom+0x109/0x1e0
>>>May 16 03:36:43 luna kernel:  [<c01c5957>] release_prepped_list+0xf7/0x130
>>>May 16 03:36:43 luna kernel:  [<c01bae23>] try_commit_txnh+0x113/0x190
>>>May 16 03:36:43 luna kernel:  [<c01baec8>] commit_txnh+0x28/0xa0
>>>May 16 03:36:43 luna kernel:  [<c01b9d7c>] txn_end+0x2c/0x30
>>>May 16 03:36:43 luna kernel:  [<c01bab2b>] flush_some_atom+0x1fb/0x290
>>>May 16 03:36:43 luna kernel:  [<c01c9368>] writeout+0x68/0xb0
>>>May 16 03:36:43 luna kernel:  [<c01c940b>] reiser4_sync_inodes+0x5b/0xa0
>>>May 16 03:36:43 luna kernel:  [<c01c93b0>] reiser4_sync_inodes+0x0/0xa0
>>>May 16 03:36:43 luna kernel:  [<c0174a59>] sync_sb_inodes+0x19/0x20
>>>May 16 03:36:43 luna kernel:  [<c0174b1e>] writeback_inodes+0xbe/0xd0
>>>May 16 03:36:43 luna kernel:  [<c013be15>] background_writeout+0x65/0xa0
>>>May 16 03:36:43 luna kernel:  [<c013c748>] __pdflush+0xc8/0x1c0
>>>May 16 03:36:43 luna kernel:  [<c013c840>] pdflush+0x0/0x20
>>>May 16 03:36:43 luna kernel:  [<c013c85a>] pdflush+0x1a/0x20
>>>May 16 03:36:43 luna kernel:  [<c013bdb0>] background_writeout+0x0/0xa0
>>>May 16 03:36:43 luna kernel:  [<c013c840>] pdflush+0x0/0x20
>>>May 16 03:36:43 luna kernel:  [<c012bb44>] kthread+0x94/0xa0
>>>May 16 03:36:43 luna kernel:  [<c012bab0>] kthread+0x0/0xa0
>>>May 16 03:36:43 luna kernel:  [<c0100f1d>] kernel_thread_helper+0x5/0x18
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
>>> 
>>>
>>
>>
> 


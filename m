Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967790AbWK3BWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967790AbWK3BWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967791AbWK3BWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:22:45 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:26622
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S967790AbWK3BWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:22:44 -0500
Message-ID: <004901c7141e$15e6cc50$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Igmar Palsenberg" <i.palsenberg@jdi-ict.nl>
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
Date: Thu, 30 Nov 2006 09:23:01 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.2663
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2757
X-OriginalArrivalTime: 30 Nov 2006 01:12:58.0000 (UTC) FILETIME=[ABF5C900:01C7141C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Igmar Palsenberg,

If you are working on arcmsr 1.20.00.13 for official kernel version.
This is the last version.
Could you check your RAID controller event and tell someting to me?
You can check "MBIOS"=>"Physical Drive Information"=>"View Drive 
Information"=>"Select The Drive"=>"Timeout Count"......
It could tell you which disk had bad behavior cause your RAID volume 
offline.
About the message dump from arcmsr, it said that your RAID volume had 
something wrong and kicked out from the system.
How about your RAID config?
Areca had new firmware released (1.42).
If you are working on "sg" device with scsi passthrough ioctl method to feed 
data into Areca's RAID volume.
You need to limit your data under 512 blocks (256K) each transfer.
The new firmware will enlarge it into 4096 blocks (2M) each transfer.
The firmware version 1.42 is on releasing procedure but not yet put it on 
Areca ftp site.
If you need it, please tell me again.

Best Regards
Erich Chen


----- Original Message ----- 
From: "Igmar Palsenberg" <i.palsenberg@jdi-ict.nl>
To: <linux-kernel@vger.kernel.org>
Cc: <erich@areca.com.tw>
Sent: Wednesday, November 29, 2006 8:41 PM
Subject: 2.6.16.32 stuck in generic_file_aio_write()


>
> Hi,
>
> I've got a machine which occasionally locks up. I can still sysrq it from
> a serial console, so it's not entirely dead.
>
> A sysrq-t learns me that it's got a large number of httpd processes stuck
> in D state :
>
> httpd         D F7619440  2160 11635   2057         11636       (NOTLB)
> dbb7ae14 cc9b0550 c33224a0 f7619440 de187604 00000000 000000b3 00000001
>       000000b3 00000000 ffffffff d374a550 c33224a0 0005b8d8 f04af800
> 000f75e7
>       d374a550 cc9b0550 cc9b0678 ef7d33ec ef7d33e8 cc9b0550 ef7d33fc
> c041bf70
> Call Trace:
> [<c041bf70>] __mutex_lock_slowpath+0x92/0x43e
> [<c0148f29>] generic_file_aio_write+0x5c/0xfa
> [<c0148f29>] generic_file_aio_write+0x5c/0xfa
> [<c0148f29>] generic_file_aio_write+0x5c/0xfa
> [<c01746c9>] permission+0xad/0xcb
> [<c01d9c4a>] ext3_file_write+0x3b/0xb0
> [<c0166777>] do_sync_write+0xd5/0x130
> [<c041d1bf>] _spin_unlock+0xb/0xf
> [<c0135c13>] autoremove_wake_function+0x0/0x4b
> [<c0166975>] vfs_write+0x1a3/0x1a8
> [<c0166a39>] sys_write+0x4b/0x74
> [<c0102c03>] sysenter_past_esp+0x54/0x75
>
> After this, the machine is rendered useless (probably due to the fact that
> disk IO isn't working anymore).
>
> The lock debugging gives me this :
>
> D           httpd:11635 [cc9b0550, 116] blocked on mutex: [ef7d33e8]
> {inode_init_once}
> .. held by:             httpd:  506 [d67e1000, 121]
> ... acquired at:               generic_file_aio_write+0x5c/0xfa
>
>
> I see similiar things as mentioned in http://lkml.org/lkml/2006/1/10/64,
> with the difference that I'm not running software RAID or SATA (it's an
> Areca ARC-1110).
>
> I can't reproduce it until now, it 'just' happens. Can someone give me a
> pointer where to start looking ?
>
> Erich, I've CC-ed you since the machine is running an Areca RAID config.
> It's also the only used disk subsystem in this machine.
>
>
> Regards,
>
>
> Igmar
> 


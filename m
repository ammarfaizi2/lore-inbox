Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWEMROS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWEMROS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWEMROS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:14:18 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:30157 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1750746AbWEMROR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:14:17 -0400
Date: Sat, 13 May 2006 19:14:14 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might be dm related)
Message-ID: <20060513171414.GA7628@uio.no>
References: <20060426204809.GA15462@uio.no> <20060426135809.10a37ec3.akpm@osdl.org> <20060513134908.GA4480@uio.no> <20060513073344.4fcbc46b.akpm@osdl.org> <20060513144334.GA6013@uio.no> <20060513075147.423d18bd.akpm@osdl.org> <20060513150003.GA6096@uio.no> <20060513082409.4d173ccc.akpm@osdl.org> <20060513153231.GA6277@uio.no> <20060513084317.50356155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060513084317.50356155.akpm@osdl.org>
X-Operating-System: Linux 2.6.16.11 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
X-Spam-Score: -2.6 (--)
X-Spam-Report: Status=No hits=-2.6 required=5.0 tests=AWL,BAYES_00,NO_RELAYS version=3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 08:43:17AM -0700, Andrew Morton wrote:
> Please try it without NUMA - we've had a few problems there of late.  If
> that fixes it then I have patches for you to test ;)

No go:

[ 2364.512764] Unable to handle kernel paging request at ffffffff403ae552 RIP: 
[ 2364.517369] [<ffffffff403ae552>]
[ 2364.526396] PGD 203027 PUD 0 
[ 2364.529385] Oops: 0010 [1] SMP 
[ 2364.532546] CPU 0 
[ 2364.534571] Modules linked in: w83627hf_wdt eeprom ide_generic ide_disk ide_cd cdrom ipv6 psmouse i2c_nforce2 serio_raw pcspkr evdev parport_pc parport i2c_core rtc ext3 jbd mbcache raid6 raid5 xor rai
d10 raid1 raid0 linear md_mod dm_mod sd_mod sata_nv sata_sil libata tg3 scsi_mod forcedeth generic amd74xx ide_core ehci_hcd ohci_hcd thermal processor fan unix
[ 2364.566790] Pid: 3433, comm: md1_resync Not tainted 2.6.17-rc4 #1
[ 2364.572877] RIP: 0010:[<ffffffff403ae552>] [<ffffffff403ae552>]
[ 2364.578612] RSP: 0018:ffff81007d5d3c40  EFLAGS: 00010287
[ 2364.584118] RAX: 0000000000000010 RBX: ffff8100109cce90 RCX: 0000000000000290
[ 2364.591246] RDX: 000000000000000a RSI: 0000000000000282 RDI: ffff81007df604d8
[ 2364.598372] RBP: ffff81007d5d3c68 R08: 0000000000001d4b R09: ffff810076aa9e78
[ 2364.605499] R10: ffff810076aa9e78 R11: 0000000000001000 R12: ffff81007dca7448
[ 2364.612627] R13: ffff81007df60488 R14: ffff81007df73528 R15: ffff81007dca7448
[ 2364.619755] FS:  0000000000000000(0000) GS:ffffffff804c3000(0000) knlGS:00000000f7e968e0
[ 2364.627848] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 2364.633588] CR2: ffffffff403ae552 CR3: 000000007b91c000 CR4: 00000000000006e0
[ 2364.640715] Process md1_resync (pid: 3433, threadinfo ffff81007d5d2000, task ffff81007fcb47d0)
[ 2364.649325] Stack: ffffffff8806a93b ffff8100109cce90 ffff81007dc304c8 ffff81007df60488 
[ 2364.657182]        ffff81007df73528 ffff81007d5d3ca8 ffffffff8807070e 0000000000000001 
[ 2364.665238]        ffff81007df73528 ffff81007dd8b9a8 
[ 2364.670310] Call Trace: <ffffffff8806a93b>{:scsi_mod:scsi_dispatch_cmd+381}
[ 2364.677308]        <ffffffff8807070e>{:scsi_mod:scsi_request_fn+735} <ffffffff802cbdad>{__generic_unplug_device+36}
[ 2364.687790]        <ffffffff802cbed9>{generic_unplug_device+0} <ffffffff802cbef7>{generic_unplug_device+30}
[ 2364.697570]        <ffffffff880d753c>{:dm_mod:dm_table_unplug_all+52} <ffffffff880d51cf>{:dm_mod:dm_unplug_all+35}
[ 2364.707964]        <ffffffff8811272e>{:raid5:unplug_slaves+105} <ffffffff88112a7d>{:raid5:raid5_unplug_device+107}
[ 2364.718350]        <ffffffff880ec66a>{:md_mod:md_do_sync+1300} <ffffffff803acb5d>{thread_return+0}
[ 2364.727361]        <ffffffff880e67e8>{:md_mod:md_thread+0} <ffffffff880e68ed>{:md_mod:md_thread+261}
[ 2364.736542]        <ffffffff880e67e8>{:md_mod:md_thread+0} <ffffffff80239e67>{kthread+207}
[ 2364.744858]        <ffffffff8020a522>{child_rip+8} <ffffffff80239d98>{kthread+0}
[ 2364.752300]        <ffffffff8020a51a>{child_rip+0}
[ 2364.757303] 
[ 2364.757304] Code:  Bad RIP value.
[ 2364.762134] RIP [<ffffffff403ae552>] RSP <ffff81007d5d3c40>
[ 2364.767722] CR2: ffffffff403ae552

This is about the same crash as I used to see with -rc2.

I guess it's time for memtest86, just in case I botched the RAM while moving it...

/* Steinar */
-- 
Homepage: http://www.sesse.net/

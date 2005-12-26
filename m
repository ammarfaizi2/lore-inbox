Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVLZXmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVLZXmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVLZXmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:42:52 -0500
Received: from solarneutrino.net ([66.199.224.43]:27143 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932159AbVLZXmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:42:51 -0500
Date: Mon, 26 Dec 2005 18:42:39 -0500
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051226234238.GA28037@tau.solarneutrino.net>
References: <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com> <20051206204336.GA12248@tau.solarneutrino.net> <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com> <20051212165443.GD17295@tau.solarneutrino.net> <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org> <1134409531.9994.13.camel@mulgrave> <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org> <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net> <1134705703.3906.1.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134705703.3906.1.camel@mulgrave>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 08:01:43PM -0800, James Bottomley wrote:
> On Thu, 2005-12-15 at 14:09 -0500, Ryan Richter wrote:
> > On Mon, Dec 12, 2005 at 12:24:42PM -0600, James Bottomley wrote:
> > > I'll find a fix for the real problem, but this patch isn't the cause.
> > 
> > Is the patch set you posted yesterday supposed to fix this?  If so, is
> > it available in patch form anywhere?
> 
> No, I've been too busin integrating other people's patches to work on
> ones of my own.  Try this.

It was looking good, but...


                   Bad page state at free_hot_cold_page (in process 'taper', page ffff8100040e22e8)
flags:0x010000000000000c mapping:ffff810102bba238 mapcount:2 count:0
Backtrace:

Call Trace:<ffffffff80158a94>{bad_page+116} <ffffffff801595df>{free_hot_cold_page+111}
       <ffffffff80160f2e>{__page_cache_release+158} <ffffffff802b8e05>{sgl_unmap_user_pages+53}
       <ffffffff802b477b>{release_buffering+27} <ffffffff802b4e31>{st_write+1697}
       <ffffffff80179e06>{vfs_write+198} <ffffffff80179f63>{sys_write+83}
       <ffffffff8010db6a>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'taper', page ffff8100040e2320)
flags:0x010000000000000c mapping:ffff810102bba238 mapcount:2 count:0
Backtrace:

Call Trace:<ffffffff80158a94>{bad_page+116} <ffffffff801595df>{free_hot_cold_page+111}
       <ffffffff80160f2e>{__page_cache_release+158} <ffffffff802b8e05>{sgl_unmap_user_pages+53}
       <ffffffff802b477b>{release_buffering+27} <ffffffff802b4e31>{st_write+1697}
       <ffffffff80179e06>{vfs_write+198} <ffffffff80179f63>{sys_write+83}
       <ffffffff8010db6a>{system_call+126}
Trying to fix it up, but a reboot is needed
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/swap.c:49
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in: bonding
Pid: 2202, comm: taper Tainted: G    B 2.6.15-rc5 #2
RIP: 0010:[<ffffffff80160b63>] <ffffffff80160b63>{put_page+99}
RSP: 0018:ffff810105be9e08  EFLAGS: 00010256
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffff8100040e22e8
RDX: ffff8100040e22e8 RSI: 0000000000000001 RDI: ffff8100040e22e8
RBP: 0000000000000008 R08: ffff810105be8000 R09: 0000000000000000
R10: 0000000000008000 R11: 0000000000000200 R12: 0000000000000000
R13: ffff8100f6f9e068 R14: 0000000000008000 R15: ffff810004857510
FS:  00002aaaab53d880(0000) GS:ffffffff804ec880(0000) knlGS:00000000555bc920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 0000000105bdd000 CR4: 00000000000006e0
Process taper (pid: 2202, threadinfo ffff810105be8000, task ffff810169339800)
Stack: 0000000000000000 ffffffff802b8e05 ffff8100f6f1fd48 ffff8100f6f9e000
       0000000000000040 0000000000008000 ffff810004857400 ffffffff802b477b
       ffff8100f6f9e000 ffffffff802b4e31
Call Trace:<ffffffff802b8e05>{sgl_unmap_user_pages+53} <ffffffff802b477b>{release_buffering+27}
       <ffffffff802b4e31>{st_write+1697} <ffffffff80179e06>{vfs_write+198}
       <ffffffff80179f63>{sys_write+83} <ffffffff8010db6a>{system_call+126}


Code: 0f 0b 68 ce e4 3a 80 c2 31 00 66 66 90 f0 83 42 08 ff 0f 98
RIP <ffffffff80160b63>{put_page+99} RSP <ffff810105be9e08>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/rmap.c:486
invalid operand: 0000 [2] SMP
CPU 1
Modules linked in: bonding
Pid: 2202, comm: taper Tainted: G    B 2.6.15-rc5 #2
RIP: 0010:[<ffffffff8016e363>] <ffffffff8016e363>{page_remove_rmap+19}
RSP: 0018:ffff810105be9a80  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff810105be37f0 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 00002aaaaaafe000 RDI: ffff8100040e22e8
RBP: 00002aaaaaafe000 R08: 80000000df77b067 R09: 000000000000001e
R10: 00000000fffffffa R11: 0000000000000001 R12: ffff810105be9ba8
R13: ffff8100040e22e8 R14: ffff810101c25480 R15: 80000000df77b067
FS:  00002aaaab53d880(0000) GS:ffffffff804ec880(0000) knlGS:00000000555bc920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 0000000105bdd000 CR4: 00000000000006e0
Process taper (pid: 2202, threadinfo ffff810105be8000, task ffff810169339800)
Stack: ffffffff80165d0d ffff8101001559b8 ffffffc100000000 ffff81017f0d8e00
       00002aaaaab62000 ffff810105b9d368 00002aaaaab62000 ffff810105be2aa8
       ffff810105be9ba8 00002aaaaab62000
Call Trace:<ffffffff80165d0d>{zap_pte_range+477} <ffffffff80166027>{unmap_page_range+535}
       <ffffffff80166199>{unmap_vmas+265} <ffffffff8016bee7>{exit_mmap+119}
       <ffffffff80130e31>{mmput+49} <ffffffff8013619a>{do_exit+506}
       <ffffffff8010f731>{die+81} <ffffffff8010fa1f>{do_invalid_op+159}
       <ffffffff80160b63>{put_page+99} <ffffffff803870a0>{thread_return+0}
       <ffffffff802a85e2>{sym_setup_data_and_start+402} <ffffffff802a843b>{sym_queue_command+155}
       <ffffffff8010e8a5>{error_exit+0} <ffffffff80160b63>{put_page+99}
       <ffffffff802b8e05>{sgl_unmap_user_pages+53} <ffffffff802b477b>{release_buffering+27}
       <ffffffff802b4e31>{st_write+1697} <ffffffff80179e06>{vfs_write+198}
       <ffffffff80179f63>{sys_write+83} <ffffffff8010db6a>{system_call+126}


Code: 0f 0b 68 d0 e5 3a 80 c2 e6 01 66 66 90 48 c7 c6 ff ff ff ff
RIP <ffffffff8016e363>{page_remove_rmap+19} RSP <ffff810105be9a80>
 <1>Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request at 0000000000100108 RIP:
<ffffffff80159705>{buffered_rmqueue+117}
PGD a7daa067 PUD ca442067 PMD 0
Oops: 0002 [3] SMP
CPU 1
Modules linked in: bonding
Pid: 2775, comm: dump Tainted: G    B 2.6.15-rc5 #2
RIP: 0010:[<ffffffff80159705>] <ffffffff80159705>{buffered_rmqueue+117}
RSP: 0018:ffff8100f4dedd88  EFLAGS: 00010006
RAX: ffff8100040e2348 RBX: ffff81010287a340 RCX: 0000000000200200
RDX: 0000000000100100 RSI: 0000000000000000 RDI: ffff81000000f300
RBP: ffff81000000f300 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: ffff8100040e2320
R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000200d2
FS:  00002aaaab22b090(0000) GS:ffffffff804ec880(0000) knlGS:00000000555bc920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000100108 CR3: 00000000a7da9000 CR4: 00000000000006e0
Process dump (pid: 2775, threadinfo ffff8100f4dec000, task ffff810090a9b880)
Stack: 0000000000000282 ffff810100001c18 0000000000000044 0000000000000000
       0000000000000000 0000000000000002 00000000000200d2 ffffffff801599b9
       ffff810100001c10 ffff810100001c10
Call Trace:<ffffffff801599b9>{get_page_from_freelist+137} <ffffffff80159a40>{__alloc_pages+80}
       <ffffffff801868a2>{pipe_writev+626} <ffffffff80186b7a>{pipe_write+26}
       <ffffffff80179e06>{vfs_write+198} <ffffffff80179f63>{sys_write+83}
       <ffffffff8010db6a>{system_call+126}

Code: 48 89 4a 08 48 89 11 48 c7 40 08 00 02 20 00 48 c7 00 00 01
RIP <ffffffff80159705>{buffered_rmqueue+117} RSP <ffff8100f4dedd88>
CR2: 0000000000100108
 <0>Bad page state at prep_new_page (in process 'dumper', page ffff8100040e22e8)
flags:0x010000000000001c mapping:0000000000000000 mapcount:-1 count:0

-ryan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVBVTpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVBVTpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBVTpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:45:21 -0500
Received: from mailman2.ppco.com ([138.32.33.140]:41415 "EHLO
	mailman2.ppco.com") by vger.kernel.org with ESMTP id S261219AbVBVTlI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:41:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with 2.6.11-rc4, Opteron server and MPTBase
Date: Tue, 22 Feb 2005 13:41:04 -0600
Message-ID: <D821697F08061F4FBB069FA1AAAA92370C44F8@hoexmb7.conoco.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with 2.6.11-rc4, Opteron server and MPTBase
Thread-Index: AcUZFdDw7PjWD/YfQlm4Ac462pxW8AAABAxQ
From: "Weathers, Norman R." <Norman.R.Weathers@conocophillips.com>
To: "Matthias-Christian Ott" <matthias.christian@tiscali.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Feb 2005 19:41:05.0264 (UTC) FILETIME=[729AA700:01C51916]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---------------------Original Post ------------------------
Weathers, Norman R. wrote:

>To all whom it may concern:
>
>
>I am having trouble with several of the 2.6 kernels.  The last one is
>the one that is perhaps most annoying.
>
>I have a dual Opteron based NFS server that keeps crashing when I try
to
>boot up with 2.6.11-rc4.
>
>The node is trying to boot from an mptbase device, and it is also
>loading modules for a qlogic fiber card (module is qla2300, qla2xxx,
and
>the scsi_transport_fc).  Now, as it is scanning the drives, it does a
>perfect impersonation of a dying duck and crashes.  
>
>Here is the output from the crash:'
>
>Fusion MPT base driver 3.01.18
>Loading scsi_modCopyright (c) 1999-2004 LSI Logic Corporation
>.ko module
>Loadmptbase: Initiating ioc0 bringup
>ing sd_mod.ko module
>Loading mptbase.ko module
>ioc0: 53C1030: Capabilities={Initiator}
>Unable to handle kernel paging request at 00000000000025b0 RIP: 
><ffffffff8012064d>{vmalloc_fault+557}
>PGD 821ad067 PUD 2c50067 PMD 0 
>Oops: 0000 [1] SMP 
>CPU 0 
>Modules linked in: mptbase sd_mod scsi_mod
>Pid: 0, comm: swapper Not tainted 2.6.11-rc4
>RIP: 0010:[<ffffffff8012064d>] <ffffffff8012064d>{vmalloc_fault+557}
>RSP: 0000:ffffffff80455230  EFLAGS: 00010212
>RAX: 00000000000fe050 RBX: 0000000000000001 RCX: 0000000000000018
>RDX: 0000000000000000 RSI: 03fffffffffff000 RDI: 00003fffffffffff
>RBP: 0000000000000000 R08: ffff8100fba3c000 R09: 00000000fba3c000
>R10: 0000000000000008 R11: ffff810081b44760 R12: ffffffff80455338
>R13: 0000000000000003 R14: ffffc20000000044 R15: 0000000000000000
>FS:  0000000000000000(0000) GS:ffffffff804c1800(0000)
>knlGS:0000000000000000
>CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
>CR2: 00000000000025b0 CR3: 0000000002c58000 CR4: 00000000000006e0
>Process swapper (pid: 0, threadinfo ffffffff804c8000, task
>ffffffff80358380)
>Stack: ffffffff801207ce 0000000000000001 0000000000000001
>ffffffff80455278 
>       ffffffff80358380 ffffffff80455338 ffffffff80317933
>0000000000000000 
>       0000000b0000000e 0000000000000082 
>Call Trace:<IRQ> <ffffffff801207ce>{do_page_fault+238}
><ffffffff8014c179>{autoremove
>_wake_function+9} 
>       <ffffffff80131d83>{__wake_up_common+67}
><ffffffff8010eddd>{error_exit+0} 
>       <ffffffff8802c02d>{:mptbase:mpt_interrupt+45}
><ffffffff8013fbd9>{update_wall_
>time+9} 
>       <ffffffff8015777c>{handle_IRQ_event+44}
><ffffffff8015788e>{__do_IRQ+222} 
>       <ffffffff80111392>{do_IRQ+66}
<ffffffff8010e981>{ret_from_intr+0}
>
>        <EOI> <ffffffff802f7c4a>{thread_return+42}
><ffffffff8010c420>{default_idle+0
>} 
>       <ffffffff8010c444>{default_idle+36}
><ffffffff8010c58a>{cpu_idle+58} 
>       <ffffffff804ca910>{start_kernel+416}
><ffffffff804ca294>{x86_64_start_kernel+4
>04} 
>       
>
>Code: 48 2b 82 b0 25 00 00 48 8d 34 c5 00 00 00 00 48 29 c6 48 8b 
>RIP <ffffffff8012064d>{vmalloc_fault+557} RSP <ffffffff80455230>
>CR2: 00000000000025b0
> <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
>
>Has anyone seen this in this kernel?  2.6.7 - 2.6.10 has not had a
>problem booting, but there has been other problems that are forcing us
>to move up to a newer kernel (2.6.7 has stability issues, 2.6.9 had
some
>interesting issues with our IBM servers and USB keyboards (complete
>lockups), and I had problems with kswapd on 2.6.7 - 2.6.10).
>
>Thanks for any help you may be able to shed on this problem.  Please CC
>me.  I was on the kernel list, but I think my company has blocked that
>email due to the volume of the traffic.
>
>Norman Weathers
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

-----------------------End Original Post--------------------------

-----------------------Response from Original
Post---------------------------
Hi!
Did you change some configuration options or did add/remove hardware?

Matthias-Christian Ott

-----------------------End Response--------------------------------

>>>>>> My Response <<<<<<<<<

No, nothing has changed on the box outside of trying to get the OS up
and running stable.

I forgot to mention last time that the OS is Fedora Core2, and the
kernel was compiled on that box using the GCC on that box.  I can get
the config and anything else that anyone may need to help solve this
problem.  In the mean time, I am trying to download 2.6.11-rc3 to see if
it will boot correctly on this box.  If it does, than there is some
change between rc3 and rc4 that may have caused the problem.

Norman Weathers


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWC0Prb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWC0Prb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWC0Pra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:47:30 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:32468 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750864AbWC0Pra convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:47:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 19/20] cciss: fix use-after-free in cciss_init_one
Date: Mon, 27 Mar 2006 09:47:25 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10BDE84D0@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 19/20] cciss: fix use-after-free in cciss_init_one
Thread-Index: AcZPxKc9SZofW9oRSiSvHJOB/MMlwQB8QNLA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Greg KH" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <stable@kernel.org>, <torvalds@osdl.org>
Cc: "Justin Forbes" <jmforbes@linuxtx.org>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy Dunlap" <rdunlap@xenotime.net>,
       "Dave Jones" <davej@redhat.com>,
       "Chuck Wolber" <chuckw@quantumlinux.com>, <akpm@osdl.org>,
       <alan@lxorguk.ukuu.org.uk>, <kaber@trash.net>,
       "Chris Wright" <chrisw@sous-sol.org>
X-OriginalArrivalTime: 27 Mar 2006 15:47:27.0072 (UTC) FILETIME=[BF84CE00:01C651B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de] 
> Sent: Friday, March 24, 2006 10:28 PM
> To: linux-kernel@vger.kernel.org; stable@kernel.org; torvalds@osdl.org
> Cc: Justin Forbes; Zwane Mwaikambo; Theodore Ts'o; Randy 
> Dunlap; Dave Jones; Chuck Wolber; akpm@osdl.org; 
> alan@lxorguk.ukuu.org.uk; kaber@trash.net; Miller, Mike (OS 
> Dev); Chris Wright; Greg Kroah-Hartman
> Subject: [patch 19/20] cciss: fix use-after-free in cciss_init_one
> 
> -stable review patch.  If anyone has any objections, please 
> let us know.


ACKed by Mike Miller <mike.miller@hp.com>

> 
> ------------------
> From: Patrick McHardy <kaber@trash.net>
> 
> free_hba() sets hba[i] to NULL, the dereference afterwards 
> results in this crash.  Setting busy_initializing to 0 
> actually looks unnecessary, but I'm not entirely sure, which 
> is why I left it in.
> 
> cciss: controller appears to be disabled Unable to handle 
> kernel NULL pointer dereference at virtual address 00000370  
> printing eip:
> c1114d53
> *pde = 00000000
> Oops: 0002 [#1]
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c1114d53>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.16 #1)
> EIP is at cciss_init_one+0x4e9/0x4fe
> eax: 00000000   ebx: c132cd60   ecx: c13154e4   edx: c27d3c00
> esi: 00000000   edi: c2748800   ebp: c2536ee4   esp: c2536eb8
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=c2536000 task=c2535a30)
> Stack: <0>00000000 00000000 00000000 c13fdba0 c2536ee8 
> c13159c0 c2536f38 f7c74740
>        c132cd60 c132cd60 ffffffed c2536ef0 c10c1d51 c2748800 c2536f04
> c10c1d85
>        c132cd60 c2748800 c132cd8c c2536f14 c10c1db8 c2748848 00000000
> c2536f28
> Call Trace:
>  [<c10031d5>] show_stack_log_lvl+0xa8/0xb0  [<c1003305>] 
> show_registers+0x102/0x16a  [<c10034a2>] die+0xc1/0x13c  
> [<c1288160>] do_page_fault+0x38a/0x525  [<c1002e9b>] 
> error_code+0x4f/0x54  [<c10c1d51>] pci_call_probe+0xd/0x10  
> [<c10c1d85>] __pci_device_probe+0x31/0x43  [<c10c1db8>] 
> pci_device_probe+0x21/0x34  [<c110a654>] 
> driver_probe_device+0x44/0x99  [<c110a73f>] 
> __driver_attach+0x39/0x5d  [<c1109e1c>] 
> bus_for_each_dev+0x35/0x5a  [<c110a777>] 
> driver_attach+0x14/0x16  [<c110a220>] 
> bus_add_driver+0x5c/0x8f  [<c110ab22>] 
> driver_register+0x73/0x78  [<c10c1f6d>] 
> __pci_register_driver+0x5f/0x71  [<c13bf935>] 
> cciss_init+0x1a/0x1c  [<c13aa718>] do_initcalls+0x4c/0x96  
> [<c13aa77e>] do_basic_setup+0x1c/0x1e  [<c10002b1>] 
> init+0x35/0x118  [<c1000cf5>] kernel_thread_helper+0x5/0xb
> Code: 04 b5 e0 de 40 c1 8d 50 04 8b 40 34 e8 3f b7 f9 ff 8b 
> 04 b5 e0 de 40 c1 e8 aa f3 ff ff 89 f0 e8 e8 fa ff ff 8b 04 
> b5 e0 de 40 c1 <c7> 80 70 03 00 00 00 00 00 00 83 c8 ff 8d 65 
> f4 5b 5e 5f 5d c3  <0>Kernel panic - not syncing: Attempted 
> to kill init!
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>
> Cc: <mike.miller@hp.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> 
>  drivers/block/cciss.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.16.orig/drivers/block/cciss.c
> +++ linux-2.6.16/drivers/block/cciss.c
> @@ -3269,8 +3269,8 @@ clean2:
>  	unregister_blkdev(hba[i]->major, hba[i]->devname);
>  clean1:
>  	release_io_mem(hba[i]);
> -	free_hba(i);
>  	hba[i]->busy_initializing = 0;
> +	free_hba(i);
>  	return(-1);
>  }
>  
> 
> --
> 

Return-Path: <linux-kernel-owner+w=401wt.eu-S964862AbWLMAtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWLMAtz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWLMAtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:49:55 -0500
Received: from rgminet02.oracle.com ([148.87.113.119]:41053 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964861AbWLMAty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:49:54 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:49:54 EST
Date: Tue, 12 Dec 2006 16:39:29 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ben Castricum <mail0612@bencastricum.nl>
Cc: linux-kernel@vger.kernel.org, gregkh <greg@kroah.com>
Subject: Re: BUG: unable to handle kernel paging request in 2.6.19-git
Message-Id: <20061212163929.987c6716.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.58.0612120737130.26641@gateway.bencastricum.nl>
References: <Pine.LNX.4.58.0612120737130.26641@gateway.bencastricum.nl>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 07:48:51 +0100 (CET) Ben Castricum wrote:

> 
> This bug started to show up after the release of 2.6.19 (iirc plain 2.6.19
> was still working fine).
> 
> The full dmesg is at
> http://www.bencastricum.nl/lk/bootmessages-2.6.19-g9202f325.log,
> and the .config http://www.bencastricum.nl/lk/config-g9202f325.log
> 
> I haven't tried disabling CONFIG_PCI_MULTITHREAD_PROBE. But if this
> might help in someway I'll give it a shot.

Yes, it appears to be that config option.  Please disable it
and retest and re-report.


> Thanks,
> Ben
> 
> e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
> e100: Copyright(c) 1999-2006 Intel Corporation
> BUG: unable to handle kernel paging request at virtual address d880a000
>  printing eip:
> d880a000
> *pde = 01382067
> *pte = 00000000
> Oops: 0000 [#1]
> Modules linked in: e100 mii ext2 unix
> CPU:    0
> EIP:    0060:[<d880a000>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.19-g9202f325 #15)
> EIP is at 0xd880a000
> eax: c13c9000   ebx: d8876fe0   ecx: d8876470   edx: d8876470
> esi: d8876fe0   edi: ffffffed   ebp: d8877014   esp: d7a15f7c
> ds: 007b   es: 007b   ss: 0068
> Process probe-0000:00:0 (pid: 72, ti=d7a14000 task=d7828560
> task.ti=d7a14000)
> Stack: c01b009a c13c9000 c01b00ec d8876fe0 c13c9000 00000000 c01b0126
> c13c9048
>        d7821560 c0205b27 d7821560 00001fcc 6ab5e081 00004ada d7acded0
> d7821560
>        c0205aa0 fffffffc c0128186 00000001 ffffffff ffffffff c01280d0
> 00000000
> Call Trace:
>  [<c01b009a>] pci_call_probe+0xa/0x10
>  [<c01b00ec>] __pci_device_probe+0x4c/0x60
>  [<c01b0126>] pci_device_probe+0x26/0x50
>  [<c0205b27>] really_probe+0x87/0x100
>  [<c0205aa0>] really_probe+0x0/0x100
>  [<c0128186>] kthread+0xb6/0xc0
>  [<c01280d0>] kthread+0x0/0xc0
>  [<c0103963>] kernel_thread_helper+0x7/0x14
>  =======================
> Code:  Bad EIP value.
> EIP: [<d880a000>] 0xd880a000 SS:ESP 0068:d7a15f7c

---
~Randy

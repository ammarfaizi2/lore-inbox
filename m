Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSLQMmp>; Tue, 17 Dec 2002 07:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSLQMmo>; Tue, 17 Dec 2002 07:42:44 -0500
Received: from services.cam.org ([198.73.180.252]:523 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S264986AbSLQMmn>;
	Tue, 17 Dec 2002 07:42:43 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
To: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@suse.de>, Rusty Russell <rusty@rustcorp.com.au>
Reply-To: tomlins@cam.org
Date: Tue, 17 Dec 2002 07:50:12 -0500
References: <200212162049.16039.tomlins@cam.org> <20021217080626.GE2496@stingr.net>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20021217125013.29A57B63@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr wrote:

> Replying to Ed Tomlinson:
>> I am getting the above message in 2.5.51, 52, and 52+bk current.
>> Pci info follows:
>> What else would help to debug this?  The drm error above is all I find in
>> the logs...
> 
> If you mount devfs somewhere you also don't find misc/agpgart inside ?
> :)))
> 
> And nothing about agp aperture in dmesg?

Not normally.  If I modprobe via-agp modprobe segfaults (a Rusty's bug),
but via_agp and agpgart get loaded (note that - changed to _ when the module 
is loaded - it has dash in file in the directory).  Doing it this time gets 
an oops (52bk as of last night):

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA MVP3 chipset
Unable to handle kernel paging request at virtual address e0db9080
 printing eip:
e0db9080
*pde = 1ed12067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<e0db9080>]    Not tainted
EFLAGS: 00010297
EIP is at 0xe0db9080
eax: 00000000   ebx: c15d5800   ecx: c0291b68   edx: 00000282
esi: 00000000   edi: c15d584c   ebp: c15d5800   esp: d93e5f08
ds: 0068   es: 0068   ss: 0068
Process modprobe (pid: 19122, threadinfo=d93e4000 task=df09aca0)
Stack: e0de816f c15d5800 c15d5800 e0dc81a1 c15d5800 e0dc84a8 c019f5c8 
c15d5800
       e0dcd2ac c15d584c e0dc84a8 ffffffed e0dc84a8 e0dc8480 c01ac0af 
c15d584c
       c15d584c c15d5854 c02bd934 c01ac183 c15d584c e0dc84a8 c02bd840 
e0dc83b8
Call Trace:
 [<e0de816f>] agp_register_driver+0x27/0x9c [agpgart]
 [<e0dc81a1>] agp_via_probe+0x35/0x3c [via_agp]
 [<e0dc84a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
 [<c019f5c8>] pci_device_probe+0x40/0x5c
 [<e0dcd2ac>] agp_via_pci_table+0x0/0x38 [via_agp]
 [<e0dc84a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
 [<e0dc84a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
 [<e0dc8480>] agp_via_pci_driver+0x0/0xa0 [via_agp]
 [<c01ac0af>] bus_match+0x37/0x6c
 [<c01ac183>] driver_attach+0x37/0x60
 [<e0dc84a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
 [<e0dc83b8>] __module_pci_device_size+0x10/0x18 [via_agp]
 [<e0dc84a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
 [<c01ac44c>] bus_add_driver+0xa4/0xc4
 [<e0dc84a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
 [<e0dc84c8>] agp_via_pci_driver+0x48/0xa0 [via_agp]
 [<c01ac83c>] driver_register+0x34/0x38
 [<e0dc84a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
 [<c019f6c2>] pci_register_driver+0x42/0x50
 [<e0dc84a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
 [<e0dcd1af>] agp_via_init+0xb/0x44 [via_agp]
 [<e0dc8480>] agp_via_pci_driver+0x0/0xa0 [via_agp]
 [<c0125752>] sys_init_module+0x116/0x1a4
 [<c0108937>] syscall_call+0x7/0xb

Code:  Bad EIP value.

The module load occured after X was started.

Ed Tomlinson


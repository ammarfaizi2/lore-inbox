Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUIWXhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUIWXhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIWXgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:36:03 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:30853 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S267548AbUIWX37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:29:59 -0400
Date: Fri, 24 Sep 2004 01:29:57 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "David S. Miller" <davem@davemloft.net>
cc: Herbert Xu <herbert@gondor.apana.org.au>, <xhejtman@mail.muni.cz>,
       <akpm@osdl.org>, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
In-Reply-To: <20040923133604.26a2ea2a.davem@davemloft.net>
Message-ID: <Pine.LNX.4.44.0409240125450.14340-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, David S. Miller wrote:

> On Thu, 23 Sep 2004 21:16:32 +1000
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> > Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> > > 
> > > However there is still the issue with endless loop in fn_hash_delete :(
> > 
> > Same problem, same fix.
> 
> Applied, thanks Herbert.

FYI: it seems applying these two list_for_each fixes did also solve a 
related issue with different symptoms, which I was just seeing:

Unable to handle kernel NULL pointer dereference at virtual address 00000028
 printing eip:
c0267a35
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: tulip soundcore parport_pc lp parport usblp ohci_hcd usbcore ne2k_pci 8390 crc32 rtc
CPU:    0
EIP:    0060:[<c0267a35>]    Not tainted VLI
EFLAGS: 00010297   (2.6.9-rc2-mm2) 
EIP is at fn_hash_insert+0x225/0x3e0
eax: 00000000   ebx: c3580401   ecx: cadcc2ec   edx: 00000000
esi: c358bea0   edi: cad03314   ebp: cbd335cc   esp: c358be30
ds: 007b   es: 007b   ss: 0068
Process route (pid: 2667, threadinfo=c358a000 task=c333b850)
Stack: 00000000 cadcc2ec 00000000 0002a8c0 00000001 00000000 cbd53ca8 cad0330c 
       ffffffef 00000000 c0141a72 00000000 c01422e7 cbc3e600 ffffff97 0000890b 
       0000890b c358a000 c02654c7 c11ca9f4 c358bea0 c358bf10 c358be90 00000000 
Call Trace:
 [<c0141a72>] check_spinlock_acquired+0x12/0x20
 [<c01422e7>] check_slabp+0x17/0xe0
 [<c02654c7>] ip_rt_ioctl+0x137/0x170
 [<c0260e90>] inet_ioctl+0x40/0xa0
 [<c021ea30>] sock_ioctl+0x2c0/0x300
 [<c0168256>] sys_ioctl+0x266/0x2b0
 [<c0104317>] syscall_call+0x7/0xb
Code: 75 14 8b 74 24 50 8a 46 06 38 47 0e 75 08 39 ea 0f 84 ae 01 00 00 89 cf 8b 07 89 c1 8d 74 26 00 3b 7f 04 74 0b 8b 57 08 8b 04 24 <39> 42 28 74 c8 81 e3 00 08 00 00 75 04 8b 7c 24 04 8b 54 24 58 

Thanks,
Martin


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267684AbUHPQFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267684AbUHPQFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267687AbUHPQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:02:50 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:15069 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S267747AbUHPPzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:55:32 -0400
Message-ID: <4120D8B1.6040000@ttnet.net.tr>
Date: Mon, 16 Aug 2004 18:54:25 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4] blacklist a device in usb-storage
References: <mailman.1092508141.32379.linux-kernel2news@redhat.com><20040815235204.0e9ec874@lembas.zaitcev.lan><412066BC.9040503@ttnet.net.tr>
	 <20040816080751.733c188d@lembas.zaitcev.lan>
In-Reply-To: <20040816080751.733c188d@lembas.zaitcev.lan>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
[...]
>>>I do not understand what the objective might be. Just do not
>>>use that thing with Linux kernel 2.4. Why do you wish "to revent
>>>usb-storage from taking over this disk"?
> 
> 
>>As I said above, I cannot prevent accidentals (VID/PIDs aren't
>>printed on the disk, yo know...) And usb-storage must not deal
>>with disks that it cannot deal with:
>>1. This particular disk can lead to panics as I said.
>>2. If someone ever writes a driver specific to this device (I
>>    know it's less than highly unlikely), than it would be also
>>    useful in that case if the disk isn't tried to be owned by
>>    usb-storage. That, I think applies as a general case, too.
> 
> 
> The #2 only makes sense when such driver appears.

And its title: "usb-storage must not deal with disks that
it cannot deal with" _also_ makes sense imho.

> As for #1, why don't you post the dmesg from your "panic".

Here's the panic (hand copied from the screen) + the
ksymoops' report:

ksymoops 2.4.9 on i686 2.4.27-acx2.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.27-acx2 (specified)
      -m /boot/System.map-2.4.27-acx2 (default)

CPU: 0
EIP: 0010: [<e0d24da0>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: d96df164   ebx: ffffffac   ecx: 00000003   edx: ffffffac
esi: 00000000   edi: dd738854   ebp: c032decc   esp: c032dea8
ds: 0018   es: 0018   ss: 0018
Process swapper: (pid: 0, stackpage= c032d000)
Stack:  e0a3b9cf  dd738854  dd738854  d96df164
         c1758440  d96df164  c1617ef0  c1617ed4
         dd738854  c032defc  e0a3bde4  c1617ed4
         dd738854  c03849e8  dfeb5d84  c032df08
         e0207ee9  00000000  c1617ef0  00000001
         c1617ed4  c032df2c  e0a3be87  c1617ed4
Call Trace: [<e0a3b9cf>]  [<e0a3bde4>]  [<e0207ee9>]
         [<e0a3be87>]   [<c010a848>]  [<c010aa33>]
         [<e0ae4385>]   [<c0107150>]   [<c0105000>]
         [<c01071f4>]
Code: Bad EIP value


 >>EIP; e0d24da0 <[sr_mod]sr_registered+22deec/22e1ac>   <=====

 >>eax; d96df164 <_end+19349420/2064e31c>
 >>edi; dd738854 <_end+1d3a2b10/2064e31c>
 >>ebp; c032decc <init_task_union+1ecc/2000>
 >>esp; c032dea8 <init_task_union+1ea8/2000>

Trace; e0a3b9cf <[usb-uhci]process_interrupt+21f/260>
Trace; e0a3bde4 <[usb-uhci]process_urb+254/260>
Trace; e0207ee9 <_end+1fe721a5/2064e31c>
Trace; e0a3be87 <[usb-uhci]uhci_interrupt+97/170>
Trace; c010a848 <handle_IRQ_event+48/80>
Trace; c010aa33 <do_IRQ+83/f0>
Trace; e0ae4385 <[battery]level_save.1+5ea9/10b84>
Trace; c0107150 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c01071f4 <cpu_idle+34/40>

<0>Kernel panic: Aiee, killing interrupt handler!

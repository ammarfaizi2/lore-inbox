Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUJMPmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUJMPmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUJMPmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:42:02 -0400
Received: from ida.rowland.org ([192.131.102.52]:11524 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S269276AbUJMPl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:41:27 -0400
Date: Wed, 13 Oct 2004 11:41:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Laurent Riffard <laurent.riffard@free.fr>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
 : oops...]
In-Reply-To: <416C3340.5070707@free.fr>
Message-ID: <Pine.LNX.4.44L0.0410131133300.1181-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Laurent Riffard wrote:

> Hello,
> 
> I posted the following bug to linux-usb-devel, and I did not receive 
> any reply.
> 
> As the problem still occurs with 2.6.9-rc4-mm1 
> (optimize-profile-path-slightly.patch reverted), I decided to post 
> it again.
> 
> I cc Greg KH because he provides a fix for pci_register_driver and 
> this oops is (indirectly) triggered by pci_unregister_driver (maybe 
> these two things are related, just a guess...).
> 
> regards
> ~~
> laurent
> 
> -------- Original Message --------
> Subject: 2.6.9-rc3-mm2 : oops when rmmod uhci_hcd
> Date: Wed, 06 Oct 2004 23:30:16 +0200
> From: Laurent Riffard <laurent.riffard@free.fr>
> To: linux-usb-devel@lists.sourceforge.net
> 
> Hello
> 
> I've got a oops when I rmmod uhci_hcd module :
> 
> Unable to handle kernel paging request at virtual address 6b6b6b6b
>     printing eip:
> c0186959
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: ne2k_pci 8390 crc32 ohci1394 ieee1394
> nls_iso8859_1 nls_cp850
>     vfat fat reiser4 reiserfs via_agp agpgart dm_mod joydev uhci_hcd
> usbcore rtc
> CPU:    0
> EIP:    0060:[<c0186959>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.9-rc3-mm2)
> EIP is at remove_proc_entry+0x29/0x140
> eax: 00000000   ebx: 6b6b6b6b   ecx: ffffffff   edx: cffa0770
> esi: c037ab40   edi: 6b6b6b6b   ebp: cc0a7ea0   esp: cc0a7e7c
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 1514, threadinfo=cc0a6000 task=cfbd8680)
> Stack: c1301938 cc0a7e90 c022b9ed c034fa14 cffa0770 6b6b6b6b f58c7d8
> c037ab40
>           c13e593c cc0a7ec8 c013813e 00000286 00000003 cc0a6000
> 0000212 00000005
>           c13e593c c13018f4 c1301938 cc0a7eec d083d3ff d084286a
> 0821af4 c1301990
> Call Trace:
>     [<c0105dd6>] show_stack+0xa6/0xb0
>     [<c0105f4d>] show_registers+0x14d/0x1c0
>     [<c0106134>] die+0xe4/0x170
>     [<c0115822>] do_page_fault+0x4c2/0x5f7
>     [<c01059a9>] error_code+0x2d/0x38
>     [<c013813e>] free_irq+0x8e/0xf0
>     [<d083d3ff>] usb_hcd_pci_remove+0xaf/0x180 [usbcore]
>     [<c01c27b6>] pci_device_remove+0x66/0x70
>     [<c022cbf7>] device_release_driver+0x57/0x60
>     [<c022cc19>] driver_detach+0x19/0x30
>     [<c022d0bc>] bus_remove_driver+0x5c/0xa0
>     [<c022d5a7>] driver_unregister+0x17/0x40
>     [<c01c29ae>] pci_unregister_driver+0xe/0x20
>     [<d08219e0>] uhci_hcd_cleanup+0x10/0x56 [uhci_hcd]
>     [<c0132b17>] sys_delete_module+0x177/0x1a0
>     [<c0104f4d>] sysenter_past_esp+0x52/0x71
> Code: 00 00 55 89 e5 83 ec 24 85 d2 89 5d f4 89 75 f8 89 7d fc 89 55
> ec 89 45 f0
>     0f 84 96 00 00 00 8b 5d f0 31 c0 b9 ff ff ff ff 89 df <f2> ae f7
> d1 49 8b 42 34
>     8d 7a 34 89 ce 85 c0 74 6e 8b 0f 89 da
> 
> 
> I'm running kernel 2.6.9-rc3-mm2 with patches :
> - pci_register_driver fix from greg KH
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109692915116202
> - compilation fix for arch/i386/kernel/irq.c
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109688635818749
> - preempt fix from Andrew Morton
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109692695515504
> 
> Attached below :
> - full dmesg
> - ksymoops output
> 
> For "lspci -v" output and .config, please see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109680811022527&q=p7 and
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109680811022527&q=p8

My impression is that this problem arises somewhere within or below the
free_irq routine.  I don't have the -mm2 sources, so I can't be any more 
precise than that.

Alan Stern


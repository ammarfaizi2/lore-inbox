Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262530AbSJAWJb>; Tue, 1 Oct 2002 18:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJAWJb>; Tue, 1 Oct 2002 18:09:31 -0400
Received: from adsl-157-199-164.dab.bellsouth.net ([66.157.199.164]:13968 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id <S262530AbSJAWJa>;
	Tue, 1 Oct 2002 18:09:30 -0400
Date: Tue, 1 Oct 2002 17:59:07 -0400
From: Andreas Boman <aboman@nerdfest.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.39 "Sleeping function called from illegal context at slab.c:1374"
Message-ID: <20021001215907.GA8273@midgaard.us>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <3D99885B.533C320D@aitel.hist.no> <3D99EF62.3A3E6932@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D99EF62.3A3E6932@digeo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@digeo.com) wrote:
> Helge Hafting wrote:
> > 
> > ..
> >  [<c01146c4>]__might_sleep+0x54/0x60
> >  [<c012dca0>]kmalloc+0x4c/0x130
> >  [<c010b6b2>]sys_ioperm+0x82/0x11c
> >  [<c0106fbb>]syscall_call+0x7/0xb
> > 
> 
> 
> You up to trying this fix?
>
 
This patch on 2.3.40+xfsfix didnt change anything here, while my trace does look different it seems to be related. I get a similar oops when ide initializes during boot, then when i modprobe ide-scsi it times out, and it seems  i get a prompt back, but the box is locked up and doesnt even respond to ping's.

UP athlon, disk on aic7xxx (xfs), ide dvdrom and cdrw on vt82c686b both set to master on separate channels.

.config is avaiable on http://midgaard.us/~aboman/dot.config-2.5
full log up to that point http://midgaard.us/~aboman/messages-40.1

 Debug: sleeping function called from illegal context at slab.c:1374
 deba1e40 deba1e60 c01333af c03597a5 0000055e dffec000 00000000 00001000 
        deba1e84 c0131a66 c15070c0 000001d0 00000000 c14cb800 00000246 00000000 
        00001000 deba1eb0 c0131dab 00001000 00000002 c14cc188 00001000 00001000 
 Call Trace:
  [__kmem_cache_alloc+255/272]__kmem_cache_alloc+0xff/0x110
  [get_vm_area+38/256]get_vm_area+0x26/0x100
  [__vmalloc+75/304]__vmalloc+0x4b/0x130
  [vmalloc+34/48]vmalloc+0x22/0x30
  [<e08fe502>]sg_init+0x82/0x130 [sg]
  [<e09022c7>].rodata.str1.1+0x23/0x2b0 [sg]
  [<e0903be0>]sg_fops+0x0/0x58 [sg]
  [<e0903b20>]sg_template+0x0/0x94 [sg]
  [scsi_register_device+276/336]scsi_register_device+0x114/0x150
  [<e08fec23>]init_sg+0x23/0x60 [sg]
  [<e0903b20>]sg_template+0x0/0x94 [sg]
  [sys_init_module+1311/1648]sys_init_module+0x51f/0x670
  [<e08fc060>]E __insmod_sg_O/lib/modules/2.5.40anb1/kernel/drivers/scsi/sg.o_M3D9A1098_V132392+0x60/0x80 [sg]
  [<e0902554>]__ksymtab+0x0/0x28 [sg]
  [<e08fc060>]E __insmod_sg_O/lib/modules/2.5.40anb1/kernel/drivers/scsi/sg.o_M3D9A1098_V132392+0x60/0x80 [sg]
  [syscall_call+7/11]syscall_call+0x7/0xb
 
 scsi1 : SCSI host adapter emulation for IDE ATAPI devices
 scsi_eh_offline_sdevs: Device set offline - notready or command retry failedafter error recovery: host1 channel 0 id 0 lun 0
   Vendor:           Model:                   Rev:     
   Type:   Direct-Access                      ANSI SCSI revision: 00
 hda: lost interrupt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266027AbUEUVwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUEUVwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 17:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUEUVwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 17:52:47 -0400
Received: from codepoet.org ([166.70.99.138]:31432 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S266027AbUEUVwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 17:52:20 -0400
Date: Fri, 21 May 2004 15:52:12 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Etienne Vogt <etienne.vogt@obspm.fr>, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com,
       Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: aic79xx trouble
Message-ID: <20040521215212.GA27456@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Etienne Vogt <etienne.vogt@obspm.fr>, linux-kernel@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Luben Tuikov <luben_tuikov@adaptec.com>
References: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de> <200405132136.32703.bernd.schubert@pci.uni-heidelberg.de> <Pine.LNX.4.58.0405161930260.2851@siolinb.obspm.fr> <3436150000.1084731012@aslan.btc.adaptec.com> <20040518154816.GA1918@logos.cnet> <202980000.1085066538@aslan.btc.adaptec.com> <227230000.1085069725@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227230000.1085069725@aslan.btc.adaptec.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 20, 2004 at 10:15:25AM -0600, Justin T. Gibbs wrote:
> > I have merged the latest drivers against linux-2.4 as of May 13th.
> > You can find bksend output containing all of the revisions to these
> > files since the last merge into 2.4.X, here:
> > 
> > http://people.freebsd.org/~gibbs/linux/SRC/aic79xx-linux-2.4-20040513.bksend.gz
> 
> I just pulled again and merged with the latest code as of today:
> 
> http://people.freebsd.org/~gibbs/linux/SRC/aic79xx-linux-2.4-20040520.bksend.gz

I do not think this code should (yet) be merged into 2.4.x.  I grabbed a
copy of aic79xx-linux-2.4-20040520 and patched it into 2.4.27-pre3.  It
appears to work as expected for my 29160 card, and thing work as
expected for that.  However...

I then inserted my Adaptec SlimSCSI 1480B Cardbus card into my laptop
and started up pcmcia.  This immediately resulted in an Oops and lsmod
shows aic7xxx is stuck initializing.  This does not happen with stock
2.4.27-pre3, where the Adaptec 1480B card works as expected.

May 21 14:18:57 sage kernel: Linux Kernel Card Services 3.1.22
May 21 14:18:57 sage kernel:   options:  [pci] [cardbus] [pm]
May 21 14:18:57 sage kernel: Intel ISA PCIC probe: not found.
May 21 14:18:57 sage kernel: PCI: Found IRQ 10 for device 02:0f.0
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 00:1f.2
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 02:06.0
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 02:06.1
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 02:0f.1
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 02:0f.2
May 21 14:18:57 sage kernel: PCI: Found IRQ 10 for device 02:0f.1
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 00:1f.2
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 02:06.0
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 02:06.1
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 02:0f.0
May 21 14:18:57 sage kernel: PCI: Sharing IRQ 10 with 02:0f.2
May 21 14:18:57 sage kernel: Yenta ISA IRQ mask 0x0298, PCI irq 10
May 21 14:18:57 sage kernel: Socket status: 30000006
May 21 14:18:57 sage kernel: Yenta ISA IRQ mask 0x0298, PCI irq 10
May 21 14:18:57 sage kernel: Socket status: 30000006
May 21 14:18:57 sage kernel: cs: IO port probe 0x0c00-0x0cff: clean.
May 21 14:18:57 sage kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
May 21 14:18:57 sage kernel: cs: IO port probe 0x0a00-0x0aff: clean.
May 21 14:19:05 sage kernel: cs: cb_alloc(bus 3): vendor 0x9004, device 0x6075
May 21 14:19:05 sage kernel: PCI: Enabling device 03:00.0 (0000 -> 0003)
May 21 14:19:05 sage kernel: SCSI subsystem driver Revision: 1.00
May 21 14:19:05 sage kernel: PCI: Setting latency timer of device 03:00.0 to 64
May 21 14:19:05 sage kernel: aic7xxx: PCI Device 3:0:0 failed memory mapped test.  Using PIO.
May 21 14:19:05 sage kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000087
May 21 14:19:05 sage kernel:  printing eip:
May 21 14:19:05 sage kernel: e08a966a
May 21 14:19:05 sage kernel: *pde = 00000000
May 21 14:19:05 sage kernel: Oops: 0000
May 21 14:19:05 sage kernel: CPU:    0
May 21 14:19:05 sage kernel: EIP:    0010:[<e08a966a>]    Not tainted
May 21 14:19:05 sage kernel: EFLAGS: 00010246
May 21 14:19:05 sage kernel: eax: 00000000   ebx: df29ae00   ecx: 80030004   edx: 00000cfc
May 21 14:19:05 sage kernel: esi: 02900006   edi: 00000005   ebp: dc2c5d8c   esp: dc2c5d70
May 21 14:19:05 sage kernel: ds: 0018   es: 0018   ss: 0018
May 21 14:19:05 sage kernel: Process modprobe (pid: 646, stackpage=dc2c5000)
May 21 14:19:05 sage kernel: Stack: 00000006 e08aba83 c02ca6e0 00064000 df29ae00 02900006 02900004 dc2c5db8 
May 21 14:19:05 sage kernel:        e08abc7b df29ae00 00000000 00004000 00000000 02900007 df290300 e08b45b0 
May 21 14:19:05 sage kernel:        df29ae00 df29ae00 dc2c5e08 e08a8937 df29ae00 dc848000 00000000 dc848000 
May 21 14:19:05 sage kernel: Call Trace:    [<e08aba83>] [<e08abc7b>] [<e08b45b0>] [<e08a8937>] [pcibios_set_master+102/108]
May 21 14:19:05 sage kernel:   [<e08ab9a0>] [<e08b45b0>] [<e08b45b0>] [get_new_inode+45/230] [iget4_locked+182/190] [<e08b4b60>]
May 21 14:19:05 sage kernel:   [<e08b4bc0>] [pci_announce_device+54/88] [<e08b4b60>] [<e08b4bc0>] [pci_register_driver+66/90] [<e08b4bc0>]
May 21 14:19:05 sage kernel:   [<e08b2da0>] [<e08ab9ee>] [<e08b4bc0>] [<e0894ff0>] [<e087f47f>] [<e08b2da0>]
May 21 14:19:05 sage kernel:   [<e08947e9>] [<e08947f1>] [<e089a47a>] [<e08b2da0>] [<e08b2da0>] [<e08b2c28>]
May 21 14:19:05 sage kernel:   [sys_init_module+1334/1494] [<e08b1768>] [<e0894060>] [system_call+51/56]
May 21 14:19:05 sage kernel: 
May 21 14:19:05 sage kernel: Code: 0f b6 80 87 00 00 00 eb 0f 90 0f b7 53 04 81 c2 87 00 00 00 


 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

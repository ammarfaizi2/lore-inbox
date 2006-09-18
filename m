Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965398AbWIRF2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbWIRF2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965400AbWIRF2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:28:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:29795 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965398AbWIRF2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:28:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nERnbTiy2djjKJ2HVUjS8quklwljW6EPc6PRK26IQl8pz5gWNITPig98ptCZBszSP7O1MhpoTaA6SinCIqI468zN2NUpY/ZMmhiSfQBoA4PgMiCzctXJIag4qTSxEQGzoHlGgpRmAf312n/l9W3/NPmHn1klBgnfZ//PCcgtALE=
Message-ID: <215036450609172228l21e8fb2drbdd880f7c1bfcc21@mail.gmail.com>
Date: Mon, 18 Sep 2006 13:28:37 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: e1000-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [BUG] kernel panic on T60 by e1000 driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while I try to transmit a 8k data by send() on my laptap T60,  kernel
panic occured:
===================================
kernel Bug at include/linux/skbuff.h:847!
invalid opcode 0000 [#1]
SMP
Modules linked in: rds cisco_ipsec parport_pc lp parport autofs4
pcmcia opw3945 ieee80211 ie80211_crypt ipt_REJECT xt_tcpudp x_tables
vfat fat dm_mirror dm_mod ibm-acpi button battery ac yenta_socket
rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd i2c_i801 i2c_core e1000
ext3 jbd ahci libata sd_mod scsi_mod
CPU:    0
EIP:    0060:[<f8e02261>]       Tainted:        PF      VLI
EFLAGS: 00010297        (2.6.17.4 #4)
EIP is at rds_tcp_data_recv+0x1f9/0x349 [rds]
eax: 00000590   ebx: f6f32d40   ecx: 00000008   edx: 0000000a
esi: 00000590   edi: f652ed48   ebp: f670f558   esp: c03eed90
ds: 007b        es: 007b        ss: 0068
Process swapper (pid: 0, threadinfo-c03ee000 task=c032e320)
Stack: 00000590 f652de58 c03eee0c 00000018 f6e30cc0 c03eee1c 00000001 dead4ead
       ffffffff ffffffff f6e30cc0 000005a8 f6795a80 d853d534 c02a4198 000005a8
       00000000 f8e02068 c03eee1c 00000000 f652ed48 f652de58 00000017 f673ab40
Call Trace:
 <c02a4198> tcp_read_sock+0xd5/0x158 <f8e02068>
rds_tcp_data_recv+0x0/0x349 [rds]
 <f8e02427> rds_tcp_read_sock+0x76/0xca [rds] <c012059c> printk+0xe/0x11
 <c027e123> sock_def_readable+0x0/0x5e <f8e025ac>
rds_tcp_data_ready+0x96/0xe8 [rds]
 <c02a9a45> tcp_data_queue+0x2d4/0x640 <c02aabe4>
tcp_rcv_established+0x57d/0x5e4
 <c02b13ba> tcp_v4_do_rcv+0x1b/0xae <c02b1929> tcp_v4_rcv+0x4dc/0x7fe
 <c014537d> get_page_from_freelist+0x7d/0x96 <c029a78a>
ip_local_deliver+0x163/0x20e
 <c029adbc> ip_rcv+0x3e6/0x420 <c0283f10> netif_receive_skb+0x274/0x294
 <f8ba835e> e1000_clean_rx_irq_ps+0x2a7/0x56e [e1000] <f8ba77d9>
e1000_clean+0x5e/0x100 [e1000]
 <c02840bf> net_rx_action+0x97/0x147 <c0124504> __do_softirq+0x5c/0xc2
 <c0104b1e> do_softirq+0x44/0x4b
 ========================
 <c0104a40> do_IRQ+0x74/0x7e <c010362e> common_interrupt+0x1a/0x20
 <c0206f05> acpi_processor_idle+0x235/0x341 <c010111b> cpu_idle+0x9a/0xb3
 <c03a5778> start_kernel+0x193/0x195
Code: 0c f4 ff ff e9 03 01 00 00 8b 47 18 8b 34 24 0f 47 f0 8b 43 60
39 44 24 0c 77 1e 2b 44 24 0c 77 1e 2b 44 24 0c 3b 43 64 89 43 60 73
08 <0f> 0b 4f 03 7a 47 e0 f8 8b 44 24 0c 01 83 98 00 00 00 39 73 60
EIP: [<f8e02261>] rds_tcp_data_recv+0x1f9/0x349 [rds] SS:ESP 0068: c03eed90
 <0>Kernel panic - not syncing: Fatal exception in interrupt


follow is the output of lspci:

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express PCI Express Root Port (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controller AHCI (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc M52 [ATI
Mobility Radeon X1300]
02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
Controller
03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG
Network Connection (rev 02)
15:00.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller


>From the panic information, I think it maybe caused by nic driver
could others also met this?
Thanks.


-- 
Regards,
Joe Jin

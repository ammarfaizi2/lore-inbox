Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVDSMvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVDSMvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 08:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVDSMvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 08:51:10 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:8081 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S261235AbVDSMu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 08:50:56 -0400
Message-ID: <4264FEAE.5070500@moving-picture.com>
Date: Tue, 19 Apr 2005 13:50:54 +0100
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG in khubd with 2.4.30 x86_64
References: <4263A5F7.9030105@moving-picture.com>
In-Reply-To: <4263A5F7.9030105@moving-picture.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've worked out what the problem is - this machine has more than 4GB 
memory and I didn't have IOMMU compiled in - rebuilding the kernel with 
this set and the problem goes away.

James Pearson

James Pearson wrote:
> I'm using a Dell PowerEdge 2850 with dual 3.6Ghz Xeon EM64T CPUs.
> 
> Using a vanilla 2.4.30 SMP x86_64 kernel, when I try to modprobe 
> usb-uhci I get:
> 
> kernel BUG in header file at line 160
> Kernel BUG at panic:149
> invalid operand: 0000
> 
> dmesg and ksymoops output below.
> 
> Thanks
> 
> James Pearson
> 
> dmesg:
> 
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 17:44:32 Apr 17 2005
> usb-uhci.c: High bandwidth mode enabled
> PCI: Setting latency timer of device 00:1d.0 to 64
> usb-uhci.c: USB UHCI at I/O 0x9ce0, IRQ 16
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Setting latency timer of device 00:1d.1 to 64
> usb-uhci.c: USB UHCI at I/O 0x9cc0, IRQ 19
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Setting latency timer of device 00:1d.2 to 64
> usb-uhci.c: USB UHCI at I/O 0x9ca0, IRQ 18
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 3
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> hub.c: new USB device 00:1d.0-1, assigned address 2
> kernel BUG in header file at line 160
> Kernel BUG at panic:149
> invalid operand: 0000
> CPU 1
> Pid: 1380, comm: khubd Not tainted
> RIP: 0010:[<ffffffff80121ae4>]
> RSP: 0018:000001023c3ddcd8  EFLAGS: 00010016
> RAX: 0000000000000026 RBX: 000001023e8f6880 RCX: 0000000000000000
> RDX: 000001023e163f08 RSI: ffffffff803e4000 RDI: 0000000000000000
> RBP: 000001023eac6400 R08: ffffffffffffffff R09: 000000000000000d
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000002 R14: 000001023c4dcf80 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff803daa00(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00000000004031a0 CR3: 000000000d674000 CR4: 00000000000006a0
> Process khubd (pid: 1380, stackpage=1023c3dd000)
> Stack: 000001023c3ddcd8 0000000000000018 ffffffff80121ae4 000001023eac6400
>        ffffffffa013b8c4 000001023c3ddd28 0000000000000202 000001023d641200
>        00000000000001f4 000001023e8f6880 000001023c3ddd48 000001023c3ddd68
> Call Trace: [<ffffffff80121ae4>] [<ffffffffa013b8c4>]
>        [<ffffffffa012443a>] [<ffffffffa012455c>] [<ffffffffa01246e3>]
>        [<ffffffffa012479d>] [<ffffffffa0125486>] [<ffffffffa012602f>]
>        [<ffffffffa0127c1a>] [<ffffffffa0127dbf>] [<ffffffffa0127f95>]
>        [<ffffffff80110888>] [<ffffffffa0127f40>] [<ffffffff80110880>]
> 
> 
> Code: 0f 0b 02 79 29 80 ff ff ff ff 95 00 eb fe 90 90 90 90 90 90
> RIP [<ffffffff80121ae4>] RSP <000001023c3ddcd8>
> 
> 
> ksymoops:
> 
> ksymoops 2.4.11 on x86_64 2.4.30.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.30/ (default)
>      -m /boot/System.map-2.4.30 (specified)
> 
> Error (expand_objects): cannot stat(/lib/xfs.o) for xfs
> Error (expand_objects): cannot stat(/lib/raid1.o) for raid1
> Error (expand_objects): cannot stat(/lib/mptscsih.o) for mptscsih
> Error (expand_objects): cannot stat(/lib/mptbase.o) for mptbase
> Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
> Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
> SGI XFS with no debug enabled
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> kernel BUG in header file at line 160
> Kernel BUG at panic:149
> invalid operand: 0000
> CPU 1
> Pid: 1380, comm: khubd Not tainted
> RIP: 0010:[<ffffffff80121ae4>]
> Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
> RSP: 0018:000001023c3ddcd8  EFLAGS: 00010016
> RAX: 0000000000000026 RBX: 000001023e8f6880 RCX: 0000000000000000
> RDX: 000001023e163f08 RSI: ffffffff803e4000 RDI: 0000000000000000
> RBP: 000001023eac6400 R08: ffffffffffffffff R09: 000000000000000d
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000002 R14: 000001023c4dcf80 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff803daa00(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00000000004031a0 CR3: 000000000d674000 CR4: 00000000000006a0
> Process khubd (pid: 1380, stackpage=1023c3dd000)
> Stack: 000001023c3ddcd8 0000000000000018 ffffffff80121ae4 000001023eac6400
>        ffffffffa013b8c4 000001023c3ddd28 0000000000000202 000001023d641200
>        00000000000001f4 000001023e8f6880 000001023c3ddd48 000001023c3ddd68
> Call Trace: [<ffffffff80121ae4>] [<ffffffffa013b8c4>]
>        [<ffffffffa012443a>] [<ffffffffa012455c>] [<ffffffffa01246e3>]
>        [<ffffffffa012479d>] [<ffffffffa0125486>] [<ffffffffa012602f>]
>        [<ffffffffa0127c1a>] [<ffffffffa0127dbf>] [<ffffffffa0127f95>]
>        [<ffffffff80110888>] [<ffffffffa0127f40>] [<ffffffff80110880>]
> Code: 0f 0b 02 79 29 80 ff ff ff ff 95 00 eb fe 90 90 90 90 90 90
> 
> 
>  >>RIP; ffffffff80121ae4 <__out_of_line_bug+14/30>   <=====
> 
>  >>RSI; ffffffff803e4000 <init_task_union+0/2000>
> 
> Trace; ffffffff80121ae4 <__out_of_line_bug+14/30>
> Trace; ffffffffa013b8c4 <[usb-uhci]uhci_submit_urb+284/410>
> Trace; ffffffffa012443a <[usbcore]usb_submit_urb+2a/40>
> Trace; ffffffffa012455c <[usbcore]usb_start_wait_urb+ac/1b0>
> Trace; ffffffffa01246e3 <[usbcore]usb_internal_control_msg+83/c0>
> Trace; ffffffffa012479d <[usbcore]usb_control_msg+7d/a0>
> Trace; ffffffffa0125486 <[usbcore]usb_set_address+46/50>
> Trace; ffffffffa012602f <[usbcore]usb_new_device+1f/1a0>
> Trace; ffffffffa0127c1a <[usbcore]usb_hub_port_connect_change+1ea/240>
> Trace; ffffffffa0127dbf <[usbcore]usb_hub_events+14f/2d0>
> Trace; ffffffffa0127f95 <[usbcore]usb_hub_thread+55/140>
> Trace; ffffffff80110888 <child_rip+8/10>
> Trace; ffffffffa0127f40 <[usbcore]usb_hub_thread+0/140>
> Trace; ffffffff80110880 <child_rip+0/10>
> 
> Code;  ffffffff80121ae4 <__out_of_line_bug+14/30>
> 0000000000000000 <_RIP>:
> Code;  ffffffff80121ae4 <__out_of_line_bug+14/30>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  ffffffff80121ae6 <__out_of_line_bug+16/30>
>    2:   02 79 29                  add    0x29(%rcx),%bh
> Code;  ffffffff80121ae9 <__out_of_line_bug+19/30>
>    5:   80 ff ff                  cmp    $0xff,%bh
> Code;  ffffffff80121aec <__out_of_line_bug+1c/30>
>    8:   ff                        (bad)
> Code;  ffffffff80121aed <__out_of_line_bug+1d/30>
>    9:   ff 95 00 eb fe 90         callq  *0xffffffff90feeb00(%rbp)
> Code;  ffffffff80121af3 <__out_of_line_bug+23/30>
>    f:   90                        nop
> Code;  ffffffff80121af4 <__out_of_line_bug+24/30>
>   10:   90                        nop
> Code;  ffffffff80121af5 <__out_of_line_bug+25/30>
>   11:   90                        nop
> Code;  ffffffff80121af6 <__out_of_line_bug+26/30>
>   12:   90                        nop
> Code;  ffffffff80121af7 <__out_of_line_bug+27/30>
>   13:   90                        nop
> 
> 
> 6 errors issued.  Results may not be reliable.
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUGAKSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUGAKSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 06:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbUGAKSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 06:18:44 -0400
Received: from www.logi-track.com ([213.239.193.212]:54927 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S264396AbUGAKSj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 06:18:39 -0400
Date: Thu, 1 Jul 2004 12:18:36 +0200
From: Markus Schaber <schabios@logi-track.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel BUG at drivers/usb/storage/usb.c:848
Message-Id: <20040701121836.07db4217@kingfisher.intern.logi-track.com>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Running Kernel 2.6.4-mm2 (We use an mm2 kernel because of problems with
highmem and cryto-loop playing together which seemed to be solved in
mm2) and dd'ing from a IDE disk in an external USB case, the following
just happened (from /var/log/syslog):

Jul  1 12:05:36 kingfisher kernel: usb 1-5: USB disconnect, address 3
Jul  1 12:05:36 kingfisher kernel: SCSI error : <5 0 0 0> return code = 0x50000
Jul  1 12:05:36 kingfisher kernel: end_request: I/O error, dev sda, sector 156301440
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301440
Jul  1 12:05:36 kingfisher kernel: SCSI error : <5 0 0 0> return code = 0x10000
Jul  1 12:05:36 kingfisher kernel: end_request: I/O error, dev sda, sector 156301441
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301441
Jul  1 12:05:36 kingfisher kernel: scsi5 (0:0): rejecting I/O to dead device
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301442
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301443
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301444
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301445
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301446
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301447
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301448
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301449
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301450
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301451
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301452
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301453
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301454
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301455
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301456
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301457
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301458
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301459
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301460
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301461
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301462
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301463
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301464
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301465
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301466
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301467
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301468
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301469
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301470
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301471
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301472
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301473
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301474
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301475
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301476
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301477
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301478
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301479
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301480
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301481
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301482
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301483
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301484
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301485
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301486
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301487
Jul  1 12:05:36 kingfisher kernel: Buffer I/O error on device sda, logical block 156301488
Jul  1 12:05:37 kingfisher kernel: ------------[ cut here ]------------
Jul  1 12:05:37 kingfisher kernel: kernel BUG at drivers/usb/storage/usb.c:848!
Jul  1 12:05:37 kingfisher kernel: invalid operand: 0000 [#1]
Jul  1 12:05:37 kingfisher kernel: PREEMPT 
Jul  1 12:05:37 kingfisher kernel: CPU:    0
Jul  1 12:05:37 kingfisher kernel: EIP:    0060:[<c02d0b77>]    Not tainted VLI
Jul  1 12:05:37 kingfisher kernel: EFLAGS: 00010202   (2.6.4-mm2-uli) 
Jul  1 12:05:37 kingfisher kernel: EIP is at usb_stor_release_resources+0xa2/0xc9
Jul  1 12:05:37 kingfisher kernel: eax: 000062fe   ebx: e5487c00   ecx: c0432ea8   edx: ef533ad8
Jul  1 12:05:37 kingfisher kernel: esi: c0439100   edi: f7e81f0c   ebp: f7e81f08   esp: f7e81e88
Jul  1 12:05:37 kingfisher kernel: ds: 007b   es: 007b   ss: 0068
Jul  1 12:05:37 kingfisher kernel: Process khubd (pid: 5, threadinfo=f7e80000 task=f7f98030)
Jul  1 12:05:37 kingfisher kernel: Stack: ef533ad8 f5c39280 c02ba53b e5487c00 f5c39280 ee0a6780 f5c39294 c0439120 
Jul  1 12:05:37 kingfisher kernel:        c0263e35 f5c39294 f5c392bc f5c39294 d838b8cc c0263f59 f5c39294 f5c392ec 
Jul  1 12:05:37 kingfisher kernel:        f5c39294 d838b8cc c0263026 f5c39294 f5c39294 d838b800 c0263077 f5c39294 
Jul  1 12:05:37 kingfisher kernel: Call Trace:
Jul  1 12:05:37 kingfisher kernel:  [<c02ba53b>] usb_unbind_interface+0x7b/0x7d
Jul  1 12:05:37 kingfisher kernel:  [<c0263e35>] device_release_driver+0x64/0x66
Jul  1 12:05:37 kingfisher kernel:  [<c0263f59>] bus_remove_device+0x55/0x96
Jul  1 12:05:37 kingfisher kernel:  [<c0263026>] device_del+0x5d/0x9b
Jul  1 12:05:37 kingfisher kernel:  [<c0263077>] device_unregister+0x13/0x23
Jul  1 12:05:37 kingfisher kernel:  [<c02bffff>] usb_disable_device+0x76/0xd7
Jul  1 12:05:37 kingfisher kernel:  [<c011eeb6>] printk+0x134/0x184
Jul  1 12:05:37 kingfisher kernel:  [<c02bb005>] usb_disconnect+0x9b/0xe8
Jul  1 12:05:37 kingfisher kernel:  [<c02bcdcb>] hub_port_connect_change+0x272/0x277
Jul  1 12:05:37 kingfisher kernel:  [<c02bc7b9>] hub_port_status+0x45/0xb0
Jul  1 12:05:37 kingfisher kernel:  [<c02bd0a3>] hub_events+0x2d3/0x346
Jul  1 12:05:37 kingfisher kernel:  [<c02bd143>] hub_thread+0x2d/0xe4
Jul  1 12:05:37 kingfisher kernel:  [<c037996a>] ret_from_fork+0x6/0x14
Jul  1 12:05:37 kingfisher kernel:  [<c011b024>] default_wake_function+0x0/0x12
Jul  1 12:05:37 kingfisher kernel:  [<c02bd116>] hub_thread+0x0/0xe4
Jul  1 12:05:37 kingfisher kernel:  [<c010725d>] kernel_thread_helper+0x5/0xb
Jul  1 12:05:37 kingfisher kernel: 
Jul  1 12:05:37 kingfisher kernel: Code: 24 04 83 c4 08 e9 cc d9 e6 ff 89 04 24 e8 0b e4 fe ff eb e6 89 04 24 e8 ba d9 e6 ff eb d2 8b 83 20 01 00 00 89 04 24 ff d2 eb bb <0f> 0b 50 03 2b 96 3b c0 eb 80 c7 80 d0 01 00 00 00 00 00 00 8b 

The symptoms are that "ps aux" shows all processes trying to access the
disk (including the dd command) in D+ state, and the kernel does not
recognize that I removed and re-plugged USB devices in this slot. (I did
not test unplugging the other of the two USB slots I have because that's
my mouse :-)

Is this a known issue that is solved in later kernels?

Thanks,
Markus


-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com

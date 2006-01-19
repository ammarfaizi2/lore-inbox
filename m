Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWASAGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWASAGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWASAGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:06:21 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:51762 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964893AbWASAGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:06:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=lG8+IgBZ8hcPyE56Qk+c5E9cRa8IueDQFoQwqAMqMb4T3QSxdJN2DU68FIEhWRqM5xKN+fvdyVK2CYScmbayx2uFQ4FXEIFd9R7Y49TNGrRa2eDMKpc/JhmGPCooYcSe8GUzxsBmAOeyTBnNKHmVTwzRVAcq/b9BRmSM6iURNr0=
Date: Thu, 19 Jan 2006 01:06:01 +0100
From: Diego Calleja <diegocg@gmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: pppd oopses current linu's git tree on disconnect
Message-Id: <20060119010601.f259bb32.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this on my log files (56k serial modem, pentium 3 smp machine, the
machine didn't hang, in fact I could connect again to send this bug
report). If needed, here's the dmesg: http://www.terra.es/personal/diegocg/dmesg
and .config: http://www.terra.es/personal/diegocg/.config. I've never seen
this so I assumed it could be a problem with the "TTY layer buffering revamp"

Jan 18 22:07:23 estel pppd[5338]: Serial link appears to be disconnected.
Jan 18 22:07:23 estel pppd[5338]: Connect time 296.0 minutes.
Jan 18 22:07:23 estel pppd[5338]: Sent 18290428 bytes, received 40448937 bytes.
Jan 18 22:07:23 estel pppd[5338]: Script /etc/ppp/ip-down started (pid 8044)
Jan 18 22:07:23 estel pppd[5338]: sent [LCP TermReq id=0x2 "Peer not responding"]
Jan 18 22:07:23 estel pppd[5338]: rcvd [LCP TermReq id=0x2 "Peer not responding"]
Jan 18 22:07:23 estel pppd[5338]: sent [LCP TermAck id=0x2]
Jan 18 22:07:23 estel pppd[5338]: rcvd [LCP TermAck id=0x2]
Jan 18 22:07:23 estel pppd[5338]: Connection terminated.
Jan 18 22:07:24 estel kernel: Unable to handle kernel paging request at virtual address f554fbf8
Jan 18 22:07:24 estel kernel:  printing eip:
Jan 18 22:07:24 estel kernel: c01fb9e7
Jan 18 22:07:24 estel kernel: *pde = 0043e067
Jan 18 22:07:24 estel kernel: *pte = 3554f000
Jan 18 22:07:24 estel kernel: Oops: 0000 [#1]
Jan 18 22:07:24 estel kernel: PREEMPT SMP DEBUG_PAGEALLOC
Jan 18 22:07:24 estel kernel: Modules linked in: ipt_REJECT xt_tcpudp radeon lp thermal fan button processor ac ipt_MASQUERADE iptable_nat ip
_nat ip_conntrack iptable_filter ip_tables x_tables usbhid parport_pc parport pcspkr floppy ohci_hcd usbcore e100 ide_cd cdrom unix
Jan 18 22:07:24 estel kernel: CPU:    1
Jan 18 22:07:24 estel kernel: EIP:    0060:[tty_buffer_free_all+35/73]    Not tainted VLI
Jan 18 22:07:24 estel kernel: EFLAGS: 00010282   (2.6.16-rc1)
Jan 18 22:07:24 estel kernel: EIP is at tty_buffer_free_all+0x23/0x49
Jan 18 22:07:24 estel kernel: eax: 0000000a   ebx: efab57f8   ecx: 3421a000   edx: f554fbf8
Jan 18 22:07:24 estel kernel: esi: efab57f8   edi: 00000000   ebp: c1aedea8   esp: c1aedea4
Jan 18 22:07:24 estel kernel: ds: 007b   es: 007b   ss: 0068
Jan 18 22:07:24 estel kernel: Process pppd (pid: 5338, threadinfo=c1aed000 task=f407dac0)
Jan 18 22:07:24 estel kernel: Stack: <0>00000000 c1aedec0 c01fd737 00000001 efab57f8 00000001 00000000 c1aedf54
Jan 18 22:07:24 estel kernel:        c01ff251 f43c7f4c 00aedee8 00000000 00000000 00000001 00000000 00000000
Jan 18 22:07:24 estel kernel:        00000001 c1aedef0 c02c3d79 c1aedf18 c01465ca 0808b81c f0cb7c10 f465ae04
Jan 18 22:07:24 estel kernel: Call Trace:
Jan 18 22:07:24 estel kernel:  [show_stack_log_lvl+170/181] show_stack_log_lvl+0xaa/0xb5
Jan 18 22:07:24 estel kernel:  [show_registers+306/414] show_registers+0x132/0x19e
Jan 18 22:07:24 estel kernel:  [die+360/493] die+0x168/0x1ed
Jan 18 22:07:24 estel kernel:  [do_page_fault+921/1239] do_page_fault+0x399/0x4d7
Jan 18 22:07:24 estel kernel:  [error_code+79/84] error_code+0x4f/0x54
Jan 18 22:07:24 estel kernel:  [release_mem+499/512] release_mem+0x1f3/0x200
Jan 18 22:07:24 estel kernel:  [release_dev+1651/1719] release_dev+0x673/0x6b7
Jan 18 22:07:24 estel kernel:  [tty_release+18/28] tty_release+0x12/0x1c
Jan 18 22:07:24 estel kernel:  [__fput+171/362] __fput+0xab/0x16a
Jan 18 22:07:24 estel kernel:  [fput+23/27] fput+0x17/0x1b
Jan 18 22:07:24 estel kernel:  [filp_close+81/91] filp_close+0x51/0x5b
Jan 18 22:07:24 estel kernel:  [sys_close+115/135] sys_close+0x73/0x87
Jan 18 22:07:24 estel kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Jan 18 22:07:24 estel kernel: Code: d8 5b 5e 5f 5d c3 90 90 55 89 e5 53 89 c3 eb 0f 8b 02 89 83 3c 01 00 00 89 d0 e8 8e 65 f5 ff 8b 93 3c 01
00 00 85 d2 75 e7 eb 0f <8b> 02 89 83 44 01 00 00 89 d0 e8 73 65 f5 ff 8b 93 44 01 00 00

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTJGTfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 15:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTJGTfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 15:35:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:14468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262725AbTJGTfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 15:35:13 -0400
Date: Tue, 7 Oct 2003 12:26:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Amir Hermelin" <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Format of an 'oops' call trace (in show_trace)
Message-Id: <20031007122631.4f028e62.rddunlap@osdl.org>
In-Reply-To: <00d101c38ceb$9ad4daf0$0401a8c0@CARTMAN>
References: <00d101c38ceb$9ad4daf0$0401a8c0@CARTMAN>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003 17:56:38 +0200 "Amir Hermelin" <amir@montilio.com> wrote:

| Hi,
| Can someone please point me to a description of what I see in the Call of
| the oops dump?  I tried looking into show_trace and lookup_symbol functions,
| but I couldn't understand some things.  For example, in this following
| trace:
| Oct  7 17:13:54 joji kernel: [<e01bae00>] reqrdata [mymod] 0x0 (0xd5543fb4))
| 
| Oct  7 17:13:54 joji kernel: [<e01a5220>] mymod [mymod] 0x0 (0xd5543fe0)) 
| I don't understand the relevance to reqrdata (since it's not a function, but
| a data structure, and isn't the parameter to the mymod function).
| And could
| someone please explain what the 0x0 in the lines mean? From the code I
| understood it to be the offset of the symbol within the module, but that
| can't be right if both symbols translate to the same offset - so I must've
| understood it wrong.

Hi,

What kernel version is this?
Any patches applied to it?

~Randy

| Oct  7 17:13:54 joji kernel:  printing eip:
| Oct  7 17:13:54 joji kernel: e01b090b
| Oct  7 17:13:54 joji kernel: *pde = 00000000
| Oct  7 17:13:54 joji kernel: Oops: 0002
| Oct  7 17:13:54 joji kernel: nfsd nfs lockd sunrpc bcm5700 parport_pc lp
| parport autofs sg sr_mod ide-scsi scsi_mod ide-cd cdrom key mymod bdev
| mousedev hid input usb-uhci ehci-hcd usbcore ext3 
| Oct  7 17:13:54 joji kernel: CPU:    0
| Oct  7 17:13:54 joji kernel: EIP:    0060:[<e01b090b>]    Not tainted
| Oct  7 17:13:54 joji kernel: EFLAGS: 00010282
| Oct  7 17:13:54 joji kernel: 
| Oct  7 17:13:54 joji kernel: EIP is at rtp_recv [mymod] 0x5b
| (2.4.20-8custom)
| Oct  7 17:13:54 joji kernel: eax: 00000000   ebx: d5542000   ecx: 00000001
| edx: c0374c88
| Oct  7 17:13:54 joji kernel: esi: e01bae00   edi: d76aa400   ebp: d5543fcc
| esp: d5543f98
| Oct  7 17:13:54 joji kernel: ds: 0068   es: 0068   ss: 0068
| Oct  7 17:13:54 joji kernel: Process mymod (pid: 6978, stackpage=d5543000) 
| Oct  7 17:13:54 joji kernel: Stack: e01bae00 d76aa400 d5542000 00000000
| d76aa400 ffffffff e01a5308 e01bae00 
| Oct  7 17:13:54 joji kernel:        d76aa400 d5543fcc d5542000 d5542000
| dbd15900 00000000 d54f3fd0 d5533fd0 
| Oct  7 17:13:54 joji kernel:        d5542000 00000000 e01a5220 00000000
| 00000000 00000000 c010742d d76aa400 
| Oct  7 17:13:54 joji kernel: Call Trace:   [<e01bae00>] reqrdata [mymod] 0x0
| (0xd5543f98))
| Oct  7 17:13:54 joji kernel: [<e01a5308>] mymod [mymod] 0xe8 (0xd5543fb0)) 
| Oct  7 17:13:54 joji kernel: [<e01bae00>] reqrdata [mymod] 0x0 (0xd5543fb4))
| 
| Oct  7 17:13:54 joji kernel: [<e01a5220>] mymod [mymod] 0x0 (0xd5543fe0)) 
| Oct  7 17:13:54 joji kernel: [<c010742d>] kernel_thread_helper [kernel] 0x5
| (0xd5543ff0)) 
| Oct  7 17:13:54 joji kernel: 
| Oct  7 17:13:54 joji kernel: 
| Oct  7 17:13:54 joji kernel: Code: ff 40 1c 8b 56 10 8b 52 1c 89 97 98 01 00
| 00 01 50 24 89 7c 

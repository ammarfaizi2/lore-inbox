Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUIPWMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUIPWMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIPWKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:10:37 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:12256 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268004AbUIPWJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:09:42 -0400
Date: Fri, 17 Sep 2004 00:09:38 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marek Habersack <grendel@caudium.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG() triggerred by Tux
Message-ID: <20040916220938.GB752@MAIL.13thfloor.at>
Mail-Followup-To: Marek Habersack <grendel@caudium.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040915185230.GA4502@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915185230.GA4502@beowulf.thanes.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 08:52:30PM +0200, Marek Habersack wrote:
> Hello,
> 
>   I realize that this question might be out of topic for this list, but
> since I've already tried to get help from the Tux mailing list and had no
> response, I'm hoping I will find some guidance here. The bug can be
> triggerred very easily by installing and using the demo4.c module shipped
> with the tux userland (tested with the 3 last versions of the Tux patch for
> both 2.4 and the 2.6 kernels). BUG() gets called when the request is
> redirected by Tux to the userland server and _after_ the latter handles the
> connection and delivers the content to the browser. Here's the message:
> 
> Sep 15 12:39:30 quantum kernel: ------------[ cut here ]------------
> Sep 15 12:39:30 quantum kernel: kernel BUG at fs/inode.c:1098!
						~~~~~~~~~~~~~~~
check what's at this location in your kernel source
this will probably provide information what went
wrong there ...

HTH,
Herbert

> Sep 15 12:39:30 quantum kernel: invalid operand: 0000 [#1]
> Sep 15 12:39:30 quantum kernel: PREEMPT 
> Sep 15 12:39:30 quantum kernel: Modules linked in: ds eth1394 ohci1394 ieee1394 via_ircc yenta_socket pcmcia_core ircomm_tty ircomm irda crc_ccitt
> Sep 15 12:39:30 quantum kernel: CPU:    0
> Sep 15 12:39:30 quantum kernel: EIP:    0060:[iput+114/128]    Not tainted
> Sep 15 12:39:30 quantum kernel: EFLAGS: 00010246   (2.6.8.1-tux-a4) 
> Sep 15 12:39:30 quantum kernel: EIP is at iput+0x72/0x80
> Sep 15 12:39:30 quantum kernel: eax: c040a860   ebx: cbb32b84   ecx: 00000000   edx: cbb32b94
> Sep 15 12:39:30 quantum kernel: esi: c9e5c2d0   edi: cbb32b84   ebp: cbb32b84   esp: cd71ee48
> Sep 15 12:39:30 quantum kernel: ds: 007b   es: 007b   ss: 0068
> Sep 15 12:39:30 quantum kernel: Process tux (pid: 2465, threadinfo=cd71e000 task=cdc9a7a0)
> Sep 15 12:39:30 quantum kernel: Stack: c016b202 cb49db00 cd71e000 c016800a cbb32b84 c04997b0 cb49db00 c02da7a0 
> Sep 15 12:39:30 quantum kernel:        cefbd4a0 c0151999 c9e5c2d0 cb49db00 c9e5c2d0 cb49db00 00000000 cdb03a20 
> Sep 15 12:39:30 quantum kernel:        00000000 c0150009 cb49db00 cdb03a20 cdb03a20 cb49db00 cbaf34a4 c03381a1 
> Sep 15 12:39:30 quantum kernel: Call Trace:
> Sep 15 12:39:30 quantum kernel:  [iput+98/128] iput+0x62/0x80
> Sep 15 12:39:30 quantum kernel:  [dput+250/528] dput+0xfa/0x210
> Sep 15 12:39:30 quantum kernel:  [sock_close+0/80] sock_close+0x0/0x50
> Sep 15 12:39:30 quantum kernel:  [__fput+201/304] __fput+0xc9/0x130
> Sep 15 12:39:30 quantum kernel:  [filp_close+89/144] filp_close+0x59/0x90
> Sep 15 12:39:30 quantum kernel:  [tux_close+97/160] tux_close+0x61/0xa0
> Sep 15 12:39:30 quantum kernel:  [flush_request+1475/2496] flush_request+0x5c3/0x9c0
> Sep 15 12:39:30 quantum kernel:  [redirect_request+215/416] redirect_request+0xd7/0x1a0
> Sep 15 12:39:30 quantum kernel:  [tux_schedule_atom+73/272] tux_schedule_atom+0x49/0x110
> Sep 15 12:39:30 quantum kernel:  [process_requests+288/496] process_requests+0x120/0x1f0
> Sep 15 12:39:30 quantum kernel:  [event_loop+501/624] event_loop+0x1f5/0x270
> Sep 15 12:39:30 quantum kernel:  [__sys_tux+763/5920] __sys_tux+0x2fb/0x1720
> Sep 15 12:39:30 quantum kernel:  [redirect_request+0/416] redirect_request+0x0/0x1a0
> Sep 15 12:39:30 quantum kernel:  [sys_chdir+117/144] sys_chdir+0x75/0x90
> Sep 15 12:39:30 quantum kernel:  [capable+35/96] capable+0x23/0x60
> Sep 15 12:39:30 quantum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Sep 15 12:39:30 quantum kernel: Code: 0f 0b 4a 04 5f 38 37 c0 eb a5 8d 74 26
> 00 83 ec 0c 8b 44 24 
> Sep 15 12:39:30 quantum kernel:  Possibly unexpected TUX-thread exit(11) at c0105228?
> -------
> 
> After that, TUX enters an endless loop, spewing the following message to the
> console:
> 
> Sep 15 15:52:59 quantum kernel: PRINT req cbe9c7f8 <c03c8f73>, sock 00000000
> Sep 15 15:52:59 quantum kernel: ... idx: 0
> Sep 15 15:52:59 quantum kernel: ... meth:{<null>}, uri:{<null>}, query:{<null>}, ver:{<null>}
> Sep 15 15:52:59 quantum kernel: ... post_data:{<NULL>}(0).
> Sep 15 15:52:59 quantum kernel: ... headers: {<NULL>}
> 
> The machine is responsive, can be accessed and used, but there is no way to
> get tux working after the above happens and it is not possible to reboot the
> machine using shutdown/reboot, power button etc - it has to be forcibly
> powered down.
> 
> The configuration of the machine the BUG gets triggerred on doesn't matter,
> it is happening in exactly the same way on any machine I could try this on.
> 
> I've tried to investigate the issue on my own, but so far I've failed
> miserably and I would appreciate any kind of pointers to help me solve the
> issue,
> 
> tia,
> 
> marek



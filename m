Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbULOQiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbULOQiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbULOQhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:37:51 -0500
Received: from ns1.digitalpath.net ([65.164.104.5]:442 "HELO
	mail.digitalpath.net") by vger.kernel.org with SMTP id S262385AbULOQhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:37:36 -0500
Date: Wed, 15 Dec 2004 08:36:51 -0800
From: Ray Van Dolson <rayvd@digitalpath.net>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Message-ID: <20041215163651.GA7037@digitalpath.net>
Mail-Followup-To: Matt Domsch <Matt_Domsch@dell.com>,
	linux-kernel@vger.kernel.org
References: <20041215013228.GA3390@digitalpath.net> <20041215162943.GB31494@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215162943.GB31494@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 10:29:43AM -0600, Matt Domsch wrote:
> These messages I have gotten for years. They're debugging messages,
> as a result of:
> register_netdevice( alloc_divert_blk( (sees it's not an ethernet device,     )
> printk's the message                                                         )
>
> So I believe they're harmless.

This is what I was thinking too.  I see plenty of these messages that do
not result in crashes.

> > ksymoops output of problem:
> > Unable to handle kernel NULL pointer dereference
> > 00000000
> > *pde = 00000000
> > Oops: 0000 [#1]
> > CPU: 2
> > EIP: 0060:[<00000000>] Not tainted VLI
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010286 (2.6.9)
> > eax: ed13b000 ebx: d1d0a000 ecx: c029e9de edx: f795ef40
> > esi: d1d0a000 edi: 00000000 ebp: e2f30080 esp: d2b0dea0
> > ds: 007b es: 007b ss: 0068
> > Stack: c02a205a ed13b000 00000000 c02a122c d1d0a000 13208a2e c040956f       
> > d1d0a000 d1d0a00c e2f30080 00000000 c029cda9 d1d0a000 e2f30080 00000000     
> > c01552cd e2f30080 00000010 00000004 00000004 c0166aa0 e2f30080 00000000     
> > 00000000                                                                    
> > Call Trace: [<c02a205a>] pty_chars_in_buffer+0x2c/0x49 [<c02a122c>]
> > normal_poll+0xed/0x150 [<c040956f>] schedule_timeout+0x75/0xbf
> > [<c029cda9>] tty_poll+0xa0/0xb0 [<c01552cd>] fget+0x49/0x5e [<c0166aa0>]
> > do_select+0x269/0x2c6 [<c0166691>] __pollwait+0x0/0xc7 [<c0166dd5>]
> > sys_select+0x2b3/0x4c6 [<c0105971>] sysenter_past_esp+0x52/0x71
> > Code: Bad EIP value.

> It looks like pty_chars_in_buffer() dereferenced a NULL function
> pointer, but I don't see how that can be, the one deference is tested
> for NULL before doing so.
>
> I can't rule out the ppp_mppe code, but I haven't seen this crash
> before myself. Does this happen on simlar systems that aren't running poptop?
>
> Thanks,
> Matt

Fortunately we use the DL140 server pretty widely here.  None of the
non-poptop servers exhibit this problem.  Every single one of them that has
been used as a Poptop server however does exhibit this issue.  It seems to
happen more frequenly on the machines with a higher number of users
connected.

I have switched one of the servers (the one with the highest load) to use
Jan Dubiec's MPPC/MPPE patches for ppp 2.4.3 and Kernel 2.6.9.  We'll see
how that goes.

Any information I can provide or something I can do on my end to better
trace this down?

Ray

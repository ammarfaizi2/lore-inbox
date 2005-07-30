Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263139AbVG3T6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbVG3T6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbVG3TzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:55:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25806 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261487AbVG3Txp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:53:45 -0400
Date: Sat, 30 Jul 2005 12:52:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: jt <jt@jtholmes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 stalls Andrew M. req this extended dmesg dump
Message-Id: <20050730125238.327be97c.akpm@osdl.org>
In-Reply-To: <42EBB9CD.7090706@jtholmes.com>
References: <42EBB9CD.7090706@jtholmes.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the  dmesg extended dump for the  stall you mailed me about earlier
>
> sequence is
>
> boot params
>     initcall_debug  log_buf_len=512k
>
> at stall
>
> ALT + Sys Req  + P
> small amout of output (8-9 lines)
>
> then
>
> ALT + Sys Req +T
> about 500+ lines of trace
>
> wait about 100 Seconds
>
> boot continues

OK, thanks.

jt <jt@jtholmes.com> wrote:
>
> [   31.895942] input: AT Translated Set 2 keyboard on isa0060/serio0
>  [   33.674983] input: PS/2 Generic Mouse on isa0060/serio4
>  [   37.193067] SysRq : Show Regs
>  [   37.197765] 
>  [   40.633539]  [<c0240410>] serio_thread+0x0/0x120
> ...
>  [   40.641468] linuxrc       S 00000000     0   786      1   795           653 (NOTLB)

So we're now running userspace from your initrd.

>  [   40.645466] c1651f40 00000086 c0115ff9 00000000 c1601020 08070798 c1601020 00000000 
>  [   40.645659]        c1384e80 c1384520 00000000 0000666c 4411f8ad 00000007 c1601020 c1601a40 
>  [   40.649731]        c1601b64 00000000 00000246 c1601ae8 00000004 fffffe00 c1601a40 c0121343 
>  [   40.653881] Call Trace:
>  [   40.661986]  [<c0115ff9>] do_page_fault+0x1a9/0x57a
>  [   40.666208]  [<c0121343>] do_wait+0x313/0x3a0
>  [   40.670429]  [<c0119940>] default_wake_function+0x0/0x10
>  [   40.674701]  [<c0119940>] default_wake_function+0x0/0x10
>  [   40.678920]  [<c0121479>] sys_wait4+0x29/0x30
>  [   40.683096]  [<c0103f99>] syscall_call+0x7/0xb
>  [   40.687191] udevstart     S 00000000     0   795    786  1443               (NOTLB)

udev is doing stuff.

>  [   40.691350] c16b1f40 00000082 c0115ff9 00000000 c1601530 bfd67d94 c1601530 00000000 
>  [   40.691544]        c1384e80 c1384520 00000000 0000122d 8cc9bc6a 00000008 c1601530 c1601020 
>  [   40.695744]        c1601144 00000000 00000246 c16010c8 00000004 fffffe00 c1601020 c0121343 
>  [   40.699932] Call Trace:
>  [   40.708026]  [<c0115ff9>] do_page_fault+0x1a9/0x57a
>  [   40.712230]  [<c0121343>] do_wait+0x313/0x3a0
>  [   40.716403]  [<c0119940>] default_wake_function+0x0/0x10
>  [   40.720663]  [<c0119940>] default_wake_function+0x0/0x10
>  [   40.724858]  [<c0121479>] sys_wait4+0x29/0x30
>  [   40.729039]  [<c0103f99>] syscall_call+0x7/0xb
>  [   40.733255] udev          S 00000000     0  1443    795                     (NOTLB)

And it's sleeping for some reason.

>  [   40.737575] db533f64 00000082 00000000 00000000 00000000 00000000 00001000 00000000 
>  [   40.737766]        42eb7f60 c1384520 00000000 00001a9e 3f629e4a 00000009 c035abc0 c1601530 
>  [   40.742137]        c1601654 00000246 00000000 fffbb44a 000003ea 00000000 fa09bac0 c03075de 
>  [   40.746498] Call Trace:
>  [   40.754791]  [<c03075de>] schedule_timeout+0x5e/0xb0
>  [   40.758975]  [<c0126690>] process_timeout+0x0/0x10
>  [   40.763137]  [<c0126776>] sys_nanosleep+0xc6/0x150
>  [   40.767289]  [<c0103f99>] syscall_call+0x7/0xb
>  [  147.456608] EXT2-fs warning (device hda6): ext2_fill_super: mounting ext3 filesystem as ext2

And after nearly two minutes you're off and running.

So it's not necessarily a kernel problem - udev is simply being verrry
slooow.

Are you running the latest version of udev?



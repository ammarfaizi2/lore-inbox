Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTKRSV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 13:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTKRSV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 13:21:59 -0500
Received: from gprs150-94.eurotel.cz ([160.218.150.94]:24705 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263734AbTKRSV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 13:21:58 -0500
Date: Tue, 18 Nov 2003 19:22:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Message-ID: <20031118182216.GB745@elf.ucw.cz>
References: <Pine.LNX.4.44.0311170844230.12994-100000@cherise> <200311180602.18511.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311180602.18511.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It then saved happily but didn't resume because I hadn't told it the default 
> resume partition was /dev/hda2.  (I don't have to specify which partition to 
> save to, why do I have to specify which one to resume from?  Oh
> well...)

Think again. How is kernel expected to find out partition which it
should resume from? Try all of them?

You did swapon before suspend, that's where you specified "which
partition". You need to tell it what to resume from...

> Unable to handle kernel paging request at virtual address cc044120
>  printing eip:
> c0131bf3
> *pde = 01276067
> *pte = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c0131bf3>]    Not tainted
> EFLAGS: 00010246
> EIP is at module_unload_init+0xe/0x52
> eax: cc044120   ebx: cc036df0   ecx: cc043c20   edx: 00000000
> esi: cc039cef   edi: cc0436ff   ebp: c4e1ff28   esp: c4e1ff28
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 920, threadinfo=c4e1e000 task=c4ba7310)
> Stack: c4e1ff9c c0133364 cc043c20 00000000 000003e8 cb015da0 cc013000 00000000 
>        cc043c20 00000000 00000000 00000000 00000000 00000000 00000008 00000012 
>        00000010 0000000c 00000000 00000000 00000018 00000017 00000019 cc0393e0 
> Call Trace:
>  [<c0133364>] load_module+0x4d8/0x7f7
>  [<c01336fa>] sys_init_module+0x77/0x234
>  [<c0108f85>] sysenter_past_esp+0x52/0x71
> 
> Code: 89 81 00 05 00 00 89 81 04 05 00 00 89 c8 42 c7 80 00 01 00 
>  Stopping tasks: ============================
>  stopping tasks failed (1 tasks remaining)
> Restarting tasks...<6> Strange, modprobe not stopped
>  done

Strange, it looks like you tried suspending in the middle of module
being [un]loaded?
								Pavel


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

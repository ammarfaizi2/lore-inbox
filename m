Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268505AbUJDTaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268505AbUJDTaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUJDT1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:27:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:56768 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268515AbUJDTZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:25:25 -0400
Date: Mon, 4 Oct 2004 12:23:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041004122304.4f545f3c.akpm@osdl.org>
In-Reply-To: <200410041634.24937.annabellesgarden@yahoo.de>
References: <200410041634.24937.annabellesgarden@yahoo.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese <annabellesgarden@yahoo.de> wrote:
>
>  EXT3-fs: mounted filesystem with ordered data mode.
>  kjournald starting.  Commit interval 5 seconds
>  Freeing unused kernel memory: 160k freed
>  ------------[ cut here ]------------
>  kernel BUG at /home/ka/kernel/2.6/linux-2.6.9-rc3-mm2/kernel/printk.c:606!
>  invalid operand: 0000 [#1]
>  PREEMPT
>  Modules linked in: nls_iso8859_1 nls_cp437 vfat fat nls_utf8 ntfs ext3 jbd 
>  sym53c8xx scsi_transport_spi sd_mod scsi_mod
>  CPU:    0
>  EIP:    0060:[<c0120a40>]    Not tainted VLI
>  EFLAGS: 00010206   (2.6.9-rc3-mm2)
>  EIP is at acquire_console_sem+0x10/0x40
>  eax: cff3e000   ebx: c037a684   ecx: cff15e70   edx: 00000000
>  esi: c037a680   edi: 00000293   ebp: cff3e000   esp: cff3ff28
>  ds: 007b   es: 007b   ss: 0068
>  Process events/0 (pid: 3, threadinfo=cff3e000 task=cff2ab10)
>  Stack: c020a3bc cff15e68 cff15e70 c037a684 c01306a2 00000000 cff3ff74 00000000
>         cff15e78 cff3e000 cff3e000 cff3e000 00000000 c020a3b0 cff3e000 cff3e000
>         cff15e68 ffffffff ffffffff 00000001 00000000 c011b910 00010000 00000000
>  Call Trace:
>   [<c020a3bc>] console_callback+0xc/0xf0
>   [<c01306a2>] worker_thread+0x222/0x300
>   [<c020a3b0>] console_callback+0x0/0xf0
>   [<c011b910>] default_wake_function+0x0/0x20
>   [<c011b910>] default_wake_function+0x0/0x20
>   [<c0130480>] worker_thread+0x0/0x300
>   [<c013498a>] kthread+0xaa/0xb0
>   [<c01348e0>] kthread+0x0/0xb0
>   [<c0104305>] kernel_thread_helper+0x5/0x10

You're the second person who is seeing in_interrupt() returning true when
clearly it should not be doing so.  Ingo, did you do soemthing which might
have caused this?


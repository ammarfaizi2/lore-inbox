Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268644AbTGLWfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268676AbTGLWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:35:29 -0400
Received: from mithril.c-zone.net ([63.172.74.235]:48645 "EHLO mail.c-zone.net")
	by vger.kernel.org with ESMTP id S268644AbTGLWfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:35:17 -0400
Message-ID: <3F1090BA.9050706@c-zone.net>
Date: Sat, 12 Jul 2003 15:50:34 -0700
From: jiho@c-zone.net
Organization: Kidding of Course
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 914] New: "bad: scheduling while atomic!" flood after IDE error
References: <166680000.1058017544@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This looks suspiciously like what used to be reported as a "lost 
interrupt" in earlier kernels.  It typically starts with a hardware 
problem, such as cable overheating (my personal favorite).


Martin J. Bligh wrote:

> http://bugme.osdl.org/show_bug.cgi?id=914
> 
>            Summary: "bad: scheduling while atomic!" flood after IDE error
>     Kernel Version: 2.5.75
>             Status: NEW
>           Severity: normal
>              Owner: alan@lxorguk.ukuu.org.uk
>          Submitter: rl@hellgate.ch
> 
> 
> This problem has been reported on LKML for 2.5.74. I think I have seen it
> at least with 2.5.73, too. The system looks okay, then, usually hours later
> (if at all, it's a rare event), something freezes the system for several
> seconds and triggers a flood of those call traces (many of them per second).
> It seems an IDE error causes it.
> 
> A 2.5.75 trace (the call stack is always the same):
> 
> Jul 12 13:08:47 [kernel] hda: dma_timer_expiry: dma status == 0x61
> Jul 12 13:09:02 [kernel] hda: timeout waiting for DMA
> Jul 12 13:09:03 [kernel] ide0: reset: success
> Jul 12 13:09:03 [kernel] bad: scheduling while atomic!
>                 - Last output repeated 103 times -
> Jul 12 13:09:51 [kernel] Call Trace:
> Jul 12 13:09:51 [kernel]  [<c0107000>] default_idle+0x0/0x40
> Jul 12 13:09:51 [kernel]  [<c011f4a0>] schedule+0x500/0x510
> Jul 12 13:09:51 [kernel]  [<c010706a>] poll_idle+0x2a/0x40
> Jul 12 13:09:51 [kernel]  [<c01180e3>] apm_cpu_idle+0xa3/0x140
> Jul 12 13:09:51 [kernel]  [<c0118040>] apm_cpu_idle+0x0/0x140
> Jul 12 13:09:51 [kernel]  [<c0107000>] default_idle+0x0/0x40
> Jul 12 13:09:51 [kernel]  [<c01070b8>] cpu_idle+0x38/0x40
> Jul 12 13:09:51 [kernel]  [<c0105000>] rest_init+0x0/0x30
> Jul 12 13:09:51 [kernel]  [<c0380738>] start_kernel+0x138/0x140
> Jul 12 13:09:51 [kernel]  [<c03804c0>] unknown_bootoption+0x0/0x100
> Jul 12 13:09:51 [kernel] bad: scheduling while atomic!
>                 - Last output repeated 144 times -
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUDPSmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUDPSmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:42:15 -0400
Received: from mail.tpgi.com.au ([203.12.160.100]:53920 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S262451AbUDPSmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:42:07 -0400
Subject: Re: 2.4.26 intermittent kernel bug on boot.
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Michael Frank <mhf@linuxmail.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <opr6j9q0d54evsfm@smtp.pacific.net.th>
References: <opr6j9q0d54evsfm@smtp.pacific.net.th>
Content-Type: text/plain
Message-Id: <1082140624.19725.82.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Sat, 17 Apr 2004 04:37:05 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-04-17 at 04:02, Michael Frank wrote:
> kernel BUG at slab.c:1238!

That's a really strange oops to see. It's testing that the GFP flags
match the slab's flags. To get an oops there, you'd have to have a
non-dma slab (which makes sense), but you've called the kmem_cache_alloc
routine with a DMA flag. Line 444 of kernel/signal.c clearly doesn't do
that! Could the args be being corrupted while being passed? What does a
backtrace look like?

Nigel

> invalid operand: 0000
> 
> CPU:    0
> EIP:    1010:[<c013bf39>]    Not tainted
> EFLAGS: 00010002
> EIP is at kmem_cache_alloc+0x31/0xdc [kernel]
> eax: 00000000   ebx: 00000008   ecx: 00000000   edx: 00000001
> esi: 00000000   edi: 0000000b   ebp: 00000020   esp: c0407f10
> ds: 1018   es: 1018   ss: 1018
> Process swapper (pid: 0, stackpage=c0407000)
> Stack: 0000000b 00000001 0000000b c040656c c0121f8c 00000000 00000020 c0406000
>         0000000b 0000000b 00000000 c012206d 0000000b 00000001 c040656c 00000282
>         0000000b c0406000 c012211c 0000000b 00000001 c0406000 00000286 c0406000
> Call Trace:
>   [<c0121f8c>] send_signal+0x2c/0xf0 [kernel]
>   [<c012206d>] deliver_signal+0x1d/0x54 [kernel]
>   [<c012211c>] send_sig_info+0x78/0x88 [kernel]
>   [<c01221a9>] force_sig_info+0x7d/0x88 [kernel]
>   [<c010a5e4>] do_double_fault+0x0/0x64 [kernel]
>   [<c01223d5>] force_sig+0x11/0x18 [kernel]
>   [<c010a619>] do_double_fault+0x35/0x64 [kernel]
>   [<c0109dc4>] error_code+0x34/0x40 [kernel]
> 
> Code: 0f 0b d6 04 e0 b7 2b c0 8d 5e 08 9c 5f fa 8b 4e 08 39 d9 75
> 
> Entering kdb (current=0xc0406000, pid 0) Oops: invalid operand
> due to oops @ 0xc013bf39
> eax = 0x00000000 ebx = 0x00000008 ecx = 0x00000000 edx = 0x00000001
> esi = 0x00000000 edi = 0x0000000b esp = 0xc0407f10 eip = 0xc013bf39
> ebp = 0x00000020 xss = 0x00001018 xcs = 0x00001010 eflags = 0x00010002
> xds = 0x00001018 xes = 0x00001018 origeax = 0xffffffff &regs = 0xc0407edc
> kdb>
> 
> Board did 50K+ boots testing swsusp with 2.4.2[012345]...
> 
> It's still sitting in kdb, if you want me lookup something let me know.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.


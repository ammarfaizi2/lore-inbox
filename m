Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTAPTEY>; Thu, 16 Jan 2003 14:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTAPTEY>; Thu, 16 Jan 2003 14:04:24 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:10182
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267200AbTAPTEW>; Thu, 16 Jan 2003 14:04:22 -0500
Message-ID: <3E27044C.4010308@tupshin.com>
Date: Thu, 16 Jan 2003 11:13:16 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en
MIME-Version: 1.0
To: Phil Oester <kernel@theoesters.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3-ac4 oops in free_pages_ok
References: <20030116082851.A31643@ns1.theoesters.com>
In-Reply-To: <20030116082851.A31643@ns1.theoesters.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple other threads about this problem recently. One 
started by me, as well as a few others.
The consensus is that it's a problem in the ac tree, and is not present 
in 2.4.21-pre3.
Some people seem to avoid the problem by disabling highmem, but this 
doesn't work for me. Quota has been mentioned as a possible culprit, but 
disabling that also doesn't help me. The ac changes to mm/shmem.c are 
still a possibility, though one reporter seems to have tried that 
without any success. The remaining candidate that has been mentioned to 
me is the buffer cache changes in the ac tree, this seems moderately 
likely. I don't see any obvious way to break out those changes from 
Alan's large ac4 patch, so I emailed him hoping to get a patch free of 
those changes, but I haven't heard back yet(it's been 9 hours 
already...how dare he ignore me ;-).

-Tupshin

Phil Oester wrote:

>Had a qmail server crash this morning with the below oops.  Also had 2 other squid servers running same kernel die with no indication of why in syslog (couldn't see console).  Think I'll stick with 2.4.20 for now...
>
>Phil Oester
>
>
>Jan 16 08:34:34 mail34 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
>Jan 16 08:34:34 mail34 kernel: c0131566
>Jan 16 08:34:34 mail34 kernel: *pde = 00000000
>Jan 16 08:34:34 mail34 kernel: Oops: 0002
>Jan 16 08:34:34 mail34 kernel: CPU:    0
>Jan 16 08:34:34 mail34 kernel: EIP:    0010:[<c0131566>]    Not tainted
>Using defaults from ksymoops -t elf32-i386 -a i386
>Jan 16 08:34:34 mail34 kernel: EFLAGS: 00010246
>Jan 16 08:34:34 mail34 kernel: eax: 00000000   ebx: c16eaf50   ecx: c9a00000   edx: c9a0005c
>Jan 16 08:34:34 mail34 kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: c9a01d84
>Jan 16 08:34:34 mail34 kernel: ds: 0018   es: 0018   ss: 0018
>Jan 16 08:34:34 mail34 kernel: Process smtp_message (pid: 12110, stackpage=c9a01000)
>Jan 16 08:34:34 mail34 kernel: Stack: d63b3840 40014000 00000001 d56f2b00 c0126a82 d63b3840 d56f2b00 c1c0fdb8 
>Jan 16 08:34:34 mail34 kernel:        e4e51000 c1000020 cd552cc0 c012e78a c1c0fdb8 00000025 00000000 c1c22660 
>Jan 16 08:34:34 mail34 kernel:        c012fb39 c1c0fdb8 cd552cc0 00000000 c1c0fdc0 c1c0fdc8 c5523b50 c9a00000 
>Jan 16 08:34:34 mail34 kernel: Call Trace:    [<c0126a82>] [<c012e78a>] [<c012fb39>] [<c0130cc9>] [<c0130d6c>]
>Warning (Oops_read): Code line not seen, dumping what data is available
>
>  
>
>>>EIP; c0131566 <__free_pages_ok+286/2a0>   <=====
>>>      
>>>
>Trace; c0126a82 <handle_mm_fault+62/d0>
>Trace; c012e78a <kmem_slab_destroy+aa/d0>
>Trace; c012fb39 <kmem_cache_reap+2b9/330>
>Trace; c0130cc9 <shrink_caches+19/80>
>Trace; c0130d6c <try_to_free_pages_zone+3c/60>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>



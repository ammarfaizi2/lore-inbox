Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbSIWSm7>; Mon, 23 Sep 2002 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbSIWSmx>; Mon, 23 Sep 2002 14:42:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261402AbSIWSma>;
	Mon, 23 Sep 2002 14:42:30 -0400
Date: Mon, 23 Sep 2002 08:41:15 -0700
From: Bob Miller <rem@osdl.org>
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux-2.5.37/include/asm/spinlock.h:123!
Message-ID: <20020923084115.A17934@build.pdx.osdl.net>
References: <1032679548.2042.5.camel@devil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1032679548.2042.5.camel@devil>; from Mika.Liljeberg@welho.com on Sun, Sep 22, 2002 at 10:25:48AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 10:25:48AM +0300, Mika Liljeberg wrote:
> This happened on 2.5.37 with KDE artsd and OSS sound drivers.
> 
> 	MikaL
> 
> Sep 21 22:12:10 devil kernel: eip: c02471a0
> Sep 21 22:12:10 devil kernel: kernel BUG at /usr/src/linux-2.5.37/include/asm/spinlock.h:123!
> Sep 21 22:12:10 devil kernel: invalid operand: 0000
> Sep 21 22:12:10 devil kernel: CPU:    1
> Sep 21 22:12:10 devil kernel: EIP:    0060:[dma_ioctl+920/2634]    Not tainted
> Sep 21 22:12:10 devil kernel: EFLAGS: 00210082
> Sep 21 22:12:10 devil kernel: eax: 0000000e   ebx: 40045010   ecx: d2a87e70   edx: c0368800
> Sep 21 22:12:10 devil kernel: esi: 40045038   edi: d98220fc   ebp: 40045038   esp: d2a87f00
> Sep 21 22:12:10 devil kernel: ds: 0068   es: 0068   ss: 0068
> Sep 21 22:12:10 devil kernel: Process artsd (pid: 545, threadinfo=d2a86000 task=d2dca020)
> Sep 21 22:12:10 devil kernel: Stack: c032bacd c02471a0 40045010 bffff6ec 00000000 40045010 d9822000 00000000 
> Sep 21 22:12:10 devil kernel:        00200202 00000002 d9822574 00000000 d5135a20 c0125226 00000000 00001000 
> Sep 21 22:12:10 devil kernel:        00000000 00000000 c0246a4c 00000000 40045010 bffff6ec 00000004 00000003 
> Sep 21 22:12:10 devil kernel: Call Trace: [dma_ioctl+896/2634] [update_wall_time+18/60] [audio_ioctl+1452/1512] [sound_ioctl+341/380] [sys_ioctl+639/748] 
> Sep 21 22:12:10 devil kernel:    [syscall_call+7/11] 
> Sep 21 22:12:10 devil kernel: 
> Sep 21 22:12:10 devil kernel: Code: 0f 0b 7b 00 a0 ba 32 c0 83 c4 08 f0 fe 0e 0f 88 aa 06 00 00 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Mika,

I haven't looked at the code yet... but most of the time when you see this
error it is because the kernel is compiled with CONFIG_DEBUG_SPINLOCK and
the code is using a lock that hasn't be initilized correctly (i.e.:
SPIN_LOCK_UNLOCKED().

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKEO1D>; Sun, 5 Nov 2000 09:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbQKEO0x>; Sun, 5 Nov 2000 09:26:53 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:28092 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129183AbQKEO0j>; Sun, 5 Nov 2000 09:26:39 -0500
Date: Sun, 5 Nov 2000 15:26:37 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Bernd Harries <bha@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: 2.2.x: Secret stack size limit in Driver file-ops??? (Was:are Generic ioctls a good thing?)
Message-ID: <20001105152637.A7204@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A01C6FA.25A90016@gmx.de> <3A054DC8.1D9701EC@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A054DC8.1D9701EC@gmx.de>; from bha@gmx.de on Sun, Nov 05, 2000 at 01:08:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 01:08:40PM +0100, Bernd Harries wrote:
> Is there a limit to the stack size (automatic variables) in
> driver methods, esp.  ioctl?
 
Yes, there is. It's INIT_TASK_SIZE. See include/linux/sched.h for
this.

> I was just implementing some generic ioctls where the size field and cmd field
> are defined at runtime. For testing I use a kernbuf on the stack.

kmalloc() and kfree() it instead.

> In the Linux Device Drivers book I didn't find 'stack size' or
> similar in the index. Are there any limits on the stacksize? If
> yes, how large are they and why would the driver behave so
> stange and not oops or hang? I fear, my filesystem on the test
> Box could be damaged. I saw this bad addres error quite some
> times and suddenly make modules complained about strange
> contents in .config...

Because it's an overall kernel limit. Once you are in kernel
mode, you have less than the above amount of stack. So don't use
it for sth. more complex then pointers or ints. And avoid
recursion as hell.

The kernel will not oops, but instead overwriting your
current task_struct.

> Does gcc grow the stack only at the beginning of a function, or
> can it save the space and re-grow it on entering code_blocks
> also?
 
Check the assembler stage output ;-)

Regards

Ingo Oeser
-- 
Feel the power of the penguin - run linux@your.pc
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

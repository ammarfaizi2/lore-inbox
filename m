Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbTCGHOY>; Fri, 7 Mar 2003 02:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbTCGHOY>; Fri, 7 Mar 2003 02:14:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:25738
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261401AbTCGHOV>; Fri, 7 Mar 2003 02:14:21 -0500
Date: Fri, 7 Mar 2003 02:22:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
In-Reply-To: <20030306222328.14b5929c.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
 <20030306222328.14b5929c.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> >
> > This just popped up on my screen, seems to have been triggered by sar/cron 
> > (i'll probably have to reboot the box soon)
> > 
> > slab error in check_poison_obj(): cache `size-64': object was modified after freeing
> > Call Trace:
> >  [<c0142226>] check_poison_obj+0x66/0x70
> >  [<c0143b92>] kmalloc+0xd2/0x180
> >  [<c0166078>] pipe_new+0x28/0xd0
> >  [<c0166153>] get_pipe_inode+0x23/0xb0
> >  [<c0166212>] do_pipe+0x32/0x1e0
> >  [<c0111ed3>] sys_pipe+0x13/0x60
> >  [<c010ad9b>] syscall_call+0x7/0xb
> 
> Don't know.  If you're using anticipatory scheduler in 2.5.63-mmfoo this
> will happen. 64-mm1 is OK.

Nope simply 2.5.64-unwashed. I don't know how to twiddle the advanced 
knobs

> show_interrupts() is walking the per-irq action chain without locking it.
> Any concurrent add/remove activity will explode.
> 
> Do you want to hunt down all the show_interrupts() instances and pop a
> spin_lock_irq(desc->lock) around them?

Sure thing.

Thanks,
	Zwane
-- 
function.linuxpower.ca

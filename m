Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbSJYOHg>; Fri, 25 Oct 2002 10:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbSJYOHg>; Fri, 25 Oct 2002 10:07:36 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:19850 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S261419AbSJYOHf>;
	Fri, 25 Oct 2002 10:07:35 -0400
Date: Fri, 25 Oct 2002 16:13:47 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux@hazard.jcu.cz: Re: [miniPATCH][RFC] Compilation fixes in the 2.5.44]
Message-ID: <20021025141346.GB2057@hazard.jcu.cz>
References: <20021025112923.GB1073@hazard.jcu.cz> <20021025131824.GA1766@suse.de> <20021025134159.GA2057@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025134159.GA2057@hazard.jcu.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

On Fri, Oct 25, 2002 at 03:41:59PM +0200, Jan Marek wrote:
> Hallo Dave and l-k,
> 
> On Fri, Oct 25, 2002 at 02:18:24PM +0100, Dave Jones wrote:
> > On Fri, Oct 25, 2002 at 01:29:23PM +0200, Jan Marek wrote:
> >  > > This fragment must be fixed, look at Documentation/Changes:
> >  > gcc-2.95.4-17 on my Debian works fine on that and without any
> >  > messages... You can try it, if you have other version of compiler...
> > 
> > Try testing with CONFIG_DEBUG_STACKOVERFLOW=y
> 
> I'm sorry, I don't think about it :-(... Yes, error or warning can be
> generated, when I compile #ifdef'ed code...
> 
> But I tried it and everythink was OK:

I'm sorry: with my fix compiler show error and ended... In the previous
case I've compiled 2.5.44-mm5 kernel, where is esp declared as follows:

#ifdef CONFIG_DEBUG_STACKOVERFLOW
        /* Debugging check for stack overflow: is there less than 1KB
 * free? */
        {
                long esp;

                __asm__ __volatile__("andl %%esp,%0" :
                                        "=r" (esp) : "0" (8191));
                if (unlikely(esp < (sizeof(struct task_struct) + 1024)))
{
                        printk("do_IRQ: stack overflow: %ld\n",
                                esp - sizeof(struct task_struct));
                        dump_stack();
                }
        }
#endif

and on this code compiler is silent...

I'm one's more sorry...

This errorlog is from the compilation of 2.5.44-mm5:

> arch/i386/kernel/traps.c: In function `do_int3':
> arch/i386/kernel/traps.c:428: warning: label `skip_trap' defined but not used
> arch/i386/kernel/traps.c: In function `do_overflow':
> arch/i386/kernel/traps.c:429: warning: label `skip_trap' defined but not used
> arch/i386/kernel/traps.c: In function `do_bounds':
> arch/i386/kernel/traps.c:430: warning: label `skip_trap' defined but not used
> arch/i386/kernel/traps.c: In function `do_device_not_available':
> arch/i386/kernel/traps.c:432: warning: label `skip_trap' defined but not used
> arch/i386/mm/hugetlbpage.c:272: warning: `unlink_vma' defined but not used
> drivers/char/agp/agp.h:87: warning: `global_cache_flush' defined but not used
> drivers/char/agp/agp.h:87: warning: `global_cache_flush' defined but not used
> drivers/ide/pci/generic.h:138: warning: `unknown_chipset' defined but not used
> drivers/ide/ide.c: In function `start_request':
> drivers/ide/ide.c:881: warning: unused variable `hwif'
> drivers/ide/ide.c: In function `ide_do_drive_cmd':
> drivers/ide/ide.c:1518: warning: unused variable `major'
> Root device is (8, 1)
> Boot sector 512 bytes.
> Setup is 4854 bytes.
> System is 1253 kB
> warning: kernel is too big for standalone boot from floppy

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

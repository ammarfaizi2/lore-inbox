Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVCYIOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVCYIOJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 03:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVCYIOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 03:14:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6667 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261536AbVCYIOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 03:14:04 -0500
Date: Fri, 25 Mar 2005 08:13:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Message-ID: <20050325081359.C18596@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, miles.lane@gmail.com,
	linux-kernel@vger.kernel.org
References: <20050324044114.5aa5b166.akpm@osdl.org> <a44ae5cd05032420122cd610bd@mail.gmail.com> <20050324202215.663bd8a9.akpm@osdl.org> <20050325073846.A18596@flint.arm.linux.org.uk> <20050324234544.135a1eb2.akpm@osdl.org> <20050325075032.B18596@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050325075032.B18596@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Fri, Mar 25, 2005 at 07:50:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 07:50:32AM +0000, Russell King wrote:
> On Thu, Mar 24, 2005 at 11:45:44PM -0800, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > On Thu, Mar 24, 2005 at 08:22:15PM -0800, Andrew Morton wrote:
> > > > Miles Lane <miles.lane@gmail.com> wrote:
> > > > >  Unable to handle kernel paging request at virtual address 24fc1024
> > > > >  c0198448
> > > > >  *pde = 00000000
> > > > >  Oops: 0000 [#1]
> > > > >  CPU:    0
> > > > >  EIP:    0060:[<c0198448>]    Not tainted VLI
> > > > 
> > > > I wonder why the EIP sometimes doesn't get decoded.
> > > > 
> > > > >  Using defaults from ksymoops -t elf32-i386 -a i386
> > > > >  EFLAGS: 00210206   (2.6.12-rc1-mm2)
> > > 
> > > ksymoops seems to remove lines from the kernel output that it doesn't
> > > like.
> > 
> > but.  but.  There used to be a symbol+0xN/0xM in the EIP: line.  Are you
> > saying that ksymoops rubbed that out and stuck a hex number in there?
> 
> The kernel's x86 format is:
> 
>         printk("EIP: %04x:[<%08lx>] CPU: %d\n",0xffff & regs->xcs,regs->eip, smp_processor_id());
>         print_symbol("EIP is at %s\n", regs->eip);

Argh, wrong one, it's supposed to be:

        print_modules();
        printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\nEFLAGS: %08lx"
                        "   (%s) \n",
                smp_processor_id(), 0xffff & regs->xcs, regs->eip,
                print_tainted(), regs->eflags, system_utsname.release);
        print_symbol("EIP is at %s\n", regs->eip);

but the result is the same.  Also note that the modules line is also
missing from the posted oops.

(Why does x86 duplicate the register dumping between process.c and
traps.c ?)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

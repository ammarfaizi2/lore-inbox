Return-Path: <linux-kernel-owner+w=401wt.eu-S964973AbWLUO0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWLUO0V (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWLUO0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:26:20 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54296 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964973AbWLUO0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:26:19 -0500
Date: Thu, 21 Dec 2006 09:24:58 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061221035458.GE30299@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221102232.5a10bece.khali@linux-fr.org> <m164c5pmim.fsf@ebiederm.dsl.xmission.com> <20061221010814.GA30299@in.ibm.com> <m1vek5o2dj.fsf@ebiederm.dsl.xmission.com> <20061221022601.GB30299@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221022601.GB30299@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 07:56:01AM +0530, Vivek Goyal wrote:
[..]
> >  #      Manual, Mixing 16-bit and 32-bit code, page 16-6)
> > 
> >         .byte 0x66, 0xea                        # prefix + jmpi-opcode
> > -code32:        .long   0x1000                          # will be set to 0x100000
> > -                                               # for big kernels
> > +code32:        .long   startup_32                      # will be set to %cs+startup_32
> >         .word   __BOOT_CS
> > +.code32
> > +startup_32:
> > +       movl $(__BOOT_DS), %eax
> > +       movl %eax, %ds
> > +       movl %eax, %es
> > +       movl %eax, %fs
> > +       movl %eax, %gs
> > +       movl %eax, %ss
> > +
> > +       xorl %eax, %eax
> > +1:     incl %eax                               # check that A20 really IS enabled
> > +       movl %eax, 0x00000000                   # loop forever if it isn't
> > +       cmpl %eax, 0x00100000
> > +       je 1b
> > +
> > +       # Jump to the 32bit entry point
> > +       jmpl *(code32_start - start + (DELTA_INITSEG << 4))(%esi)
> 
> Hi Eric,
> 
> I got a basic query. Why have we introduced this additional jump to 
> startup_32 in the same file? Won't it work if we stick to old method of
> enabling protected mode and then directly taking a jmp to startup_32 in
> arch/i386/kernel/head.S. Am I missing something obivious? 
> 

Sorry, I meant arch/i386/boot/compressed/head.S and not arch/i386/kernel/head.S

Thanks
Vivek

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbULEKLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbULEKLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 05:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbULEKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 05:11:16 -0500
Received: from gate.ebshome.net ([64.81.67.12]:51162 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S261261AbULEKLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 05:11:11 -0500
Date: Sun, 5 Dec 2004 02:11:10 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Linh Dang <dang.linh@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
Message-ID: <20041205101110.GC3448@gate.ebshome.net>
Mail-Followup-To: Linh Dang <dang.linh@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3b2b32004120206497a471367@mail.gmail.com> <3b2b320041202082812ee4709@mail.gmail.com> <16815.31634.698591.747661@cargo.ozlabs.ibm.com> <3b2b32004120306463b016029@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2b32004120306463b016029@mail.gmail.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 09:46:00AM -0500, Linh Dang wrote:
> On Fri, 3 Dec 2004 07:31:14 +1100, Paul Mackerras <paulus@samba.org> wrote:
> > Linh Dang writes:
> > 
> > > In 2.6.9 on non-APUS ppc32 platforms, virt_to_bus() will just subtract
> > > KERNELBASE  from the the virtual address. bus_to_virt() will perform
> > > the reverse operation.
> > >
> > > This patch will make virt_to_bus():
> > >
> > >      - perform the current operation if the virtual address is between
> > >        KERNELBASE and ioremap_bot.
> > 
> > Why do you want to do this?  The only code that should be using
> > virt_to_bus or bus_to_virt is the DMA API code, and it's happy with
> > them the way they are.
> 
> I wrote a DMA engine (to used by other drivers) that (would like to) accept
> all kind of buffers as input (vmalloced, dual-access shared RAM mapped
> by BATs, etc). The DMA engine has to decode the virtual address of the
> input buffer to (possibly multiple) physical  address(es). virt_to_phys()
> has the right name for the job except it only works for the kernel virtual
> addresses initially mapped at KERNELBASE

Unfortunately your patch doesn't achieve your goals. vmalloc space on 
PPC32 will be between KERNEL_BASE and ioremap_bot anyway, so 
additional check is mostly useless anyway (it will only call iopa() 
for ioremaps done early during the boot).

Also, even assuming you got the range right and called iopa() for 
vmalloced space, tell me how are you gonna deal with non-physically 
continuous vmalloced buffers in your DMA library?

--
Eugene

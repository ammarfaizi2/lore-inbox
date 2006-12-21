Return-Path: <linux-kernel-owner+w=401wt.eu-S1422962AbWLUOKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422962AbWLUOKi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422963AbWLUOKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:10:38 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50496 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422962AbWLUOKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:10:37 -0500
Date: Thu, 21 Dec 2006 09:10:29 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061221034029.GD30299@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221102232.5a10bece.khali@linux-fr.org> <m164c5pmim.fsf@ebiederm.dsl.xmission.com> <20061221145401.07bfe408.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221145401.07bfe408.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 02:54:01PM +0100, Jean Delvare wrote:
> On Thu, 21 Dec 2006 03:32:33 -0700, Eric W. Biederman wrote:
> > Ok.  There is almost enough for inference but here is a patch of stops
> > for setup.S let's see if one of those will stop the reboots.
> >
> > I have a strong feeling that we are going to find a tool chain issue,
> > but I'd like to find where we ware having problems before we declare
> > that to be the case.
> > (...)
> > diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
> > index 06edf1c..2868020 100644
> > --- a/arch/i386/boot/setup.S
> > +++ b/arch/i386/boot/setup.S
> > @@ -795,6 +795,7 @@ a20_done:
> >
> >  #endif /* CONFIG_X86_VOYAGER */
> >  # set up gdt and idt and 32bit start address
> > +10: jmp	10b
> 
> Locked here, removed.
> 
> Out of curiosity, what does the "b" stand for?
> 

I think one can have multiple labels named as 10: so we need to specify
which one do you want to jump to. Either forward one (f) or backward
one (b).
 
[..]
> 
> Locked here, removed.
> 
> >  	# Jump to the 32bit entry point
> >  	jmpl *(code32_start - start + (DELTA_INITSEG << 4))(%esi)
> >  .code16
> 
> Which brought me to the original situation, where unsurprisingly the
> reboot happened. So the problem is located after label 14. Does it help?
>

Ok. so indirect jump seems to be having problem. On my machine disassembly
of setup.o show following.

ff a6 14 02 00 00       jmp    *0x214(%esi)

This seems to be fine as 0x14 is the offset of code32_start, and 
((DELTA_INITSEG) << 4) is 0x200. How does it look like on your machine?

Thanks
Vivek
  

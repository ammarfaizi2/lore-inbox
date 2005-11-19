Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVKSEfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVKSEfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVKSEfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:35:33 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:50899 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751365AbVKSEfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:35:32 -0500
Date: Sat, 19 Nov 2005 10:05:23 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>, ak@suse.de
Subject: Re: [PATCH 8/10] kdump: x86_64 save cpu registers upon crash
Message-ID: <20051119043523.GB3665@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com> <20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com> <20051117132659.GK3981@in.ibm.com> <20051117132850.GL3981@in.ibm.com> <m1mzk1mxni.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mzk1mxni.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 02:52:33PM -0700, Eric W. Biederman wrote:
> 
> > diff -puN arch/x86_64/kernel/crash.c~x86_64-save-cpu-registers-upon-crash
> > arch/x86_64/kernel/crash.c
> > ---
> > linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/crash.c~x86_64-save-cpu-registers-upon-crash
> 
> >  #ifdef CONFIG_SMP
> >  static atomic_t waiting_for_crash_ipi;
> >  
> > @@ -38,6 +106,7 @@ static int crash_nmi_callback(struct pt_
> >  		return 1;
> >  	local_irq_disable();
> >  
> > +	crash_save_this_cpu(regs, cpu);
> >  	disable_local_APIC();
> >  	atomic_dec(&waiting_for_crash_ipi);
> >  	/* Assume hlt works */
> > @@ -113,4 +182,5 @@ void machine_crash_shutdown(struct pt_re
> >  	disable_IO_APIC();
> >  #endif
> >  
> > +	crash_save_self(regs);
> >  }
> 
> Where did this disable_local_APIC and disable_IO_APIC on x86_64 come
> from?  I know we had it on x86 but that was supposed to be a stop gap
> until we have the real fix.  Now I know it needs a little more
> debugging but the real fix has been written.  Putting it there on
> x86_64 makes the code less reliable and it allows things to start
> depending on it. 
> 

Hi Eric,

Initially we had written the patch without disable_local_APIC and
disable_IO_APIC only. But realized later that fix provided by you to
move apic initialization in init_IRQ has not been merged yet.

Like i386, here also this is a stop gap solution only till your patch is
merged. After that we shall drop this code.

I understand that it is less reliable but at least it provides us a base
to move forward and test kdump on x86_64 and address the other issues.

Thanks
Vivek

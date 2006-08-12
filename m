Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWHLPXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWHLPXd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 11:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWHLPXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 11:23:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964862AbWHLPXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 11:23:30 -0400
Date: Sat, 12 Aug 2006 11:25:55 -0400
From: Don Zickus <dzickus@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060812152555.GB16068@redhat.com>
References: <20060807235727.GM16231@redhat.com> <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com> <20060809200642.GD7861@redhat.com> <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com> <20060810131323.GB9888@in.ibm.com> <m18xlw34j1.fsf@ebiederm.dsl.xmission.com> <20060810181825.GD14732@in.ibm.com> <m1irl01hex.fsf@ebiederm.dsl.xmission.com> <20060811212522.GF18865@redhat.com> <m1d5b6zagy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5b6zagy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 01:20:29AM -0600, Eric W. Biederman wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> >> >> 
> >> >> I'm a little disappointed but at this point it isn't a great surprise,
> >> >> the code is early yet and hasn't had much testing or attention.
> >> >> I wonder if I have missed something else silly.
> >> >> 
> >> >> As for testing, can you use plain kexec to load the kernel at a
> >> >> different address?  I'm curious to know if it is something related
> >> >> to the kexec on panic path or if it is just running at a different
> >> >> location that is the problem.
> >> >
> >
> > I think I have found the 'something silly'.  Here is a patch that allows
> > our Dell em64t boxes to boot.  This change matches the original code.  The
> > main difference that caused the problems was the setting of _PAGE_NX bit.
> > This caused issues in early_io_remap().  
> >
> > Thanks to Larry Woodman for debugging this.  
> 
> This looks like a different one but looks fairly sane.  
> 
> Do you know what code had problems having _PAGE_NX set.
> What are we doing with early_ioremap the requires execute
> permissions.  It doesn't sound right that we would need
> this.

This fix is only needed for a subset of our em64t boxes, so it could be
just a chipset problem.  Supposedly, if I remember the conversation
correctly, when the kernel first boots it reserves about 40MB and about 20
pmds automatically.  After decompression, early_io_remap tries to setup
all the memory.  The conflict arose when early_io_remap tried to reuse one
of those pmds.  This caused the system to crash and reboot.  

I'll try to get more info Monday on the specifics.  

Cheers,
Don

> 
> Eric

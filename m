Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbSKOONC>; Fri, 15 Nov 2002 09:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSKOONC>; Fri, 15 Nov 2002 09:13:02 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54863 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266257AbSKOONA>; Fri, 15 Nov 2002 09:13:00 -0500
To: suparna@in.ibm.com
Cc: Andy Pfiffer <andyp@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: Kexec for v2.5.47-bk2
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1adkda9dm.fsf_-_@frodo.biederman.org>
	<20021115145454.B2503@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Nov 2002 07:14:56 -0700
In-Reply-To: <20021115145454.B2503@in.ibm.com>
Message-ID: <m165uyapi7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> On Wed, Nov 13, 2002 at 06:26:29AM -0700, Eric W. Biederman wrote:
> > 
> > O.k. and now a version that applies cleanly to 
> > v2.5.47-bk2 aka ChangeSet@1.845
> > 
> 
> BTW, results similar to Andy on my SMP system (the same problem
> machine we'd talked about earlier). Same problem ?

Something like that.  The good news is that the image is being
loaded the bad news is the BIOS doesn't work, and so the kernels
initial setup code isn't working.

Hopefully this weekend I can do the work in user space to bypass
the BIOS altogether for booting a kernel.  That should make the whole
thing easier to use.
 
> with 2.5.47-bk2 
> + kexec patch for 2.5.47-bk2 attached in your mail
> + linux-2.5.47.x86kexec-hwfixes
> and using
> kexec-tools-1.5
> 
> Results of kexec kexec_test
> 
> [root@llm01 root]# Synchronizing SCSI caches: 
> Shutting down devices
> Starting new kernel
> kexec_test 1.5 starting...
> eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
> esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
> idt: 00000000 C0000000
> gdt: 00000000 C0000000
> Switching descriptors.
> Descriptors changed.
> Legacy pic setup.
> In real mode.
> <hang>
> 
> What would be best way to pass a parameter or address from the
> current kernel to kernel being booted (e.g log buffer address
> or crash dump buffer etc) ? Should this be part of the interface,
> i.e. could/would it make sense for kexec to support this (rather 
> than our having to go and try to fix up kernel parameters ourselves,
> or designate a fixed address for this) ? Also thinking
> about other arch support for kexec in the future ...

The current interface says load image X at location Y, and entry
at point Z.  Given that every little situation wants a slightly
different tweak I don't think a specific feature in the kernel is
needed.  The user space binaries can incorporate all of the
interesting logic.

Eric

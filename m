Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292317AbSBBQWD>; Sat, 2 Feb 2002 11:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292315AbSBBQVy>; Sat, 2 Feb 2002 11:21:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36152 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S292314AbSBBQVh>; Sat, 2 Feb 2002 11:21:37 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>
	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>
	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>
	<m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2002 09:17:40 -0700
In-Reply-To: <3C5ADDD1.6000608@zytor.com>
Message-ID: <m1665fame3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > What is magic about interactivity?  What makes this a different
> > problem?  We approach booting from totally different perspectives,
> > which makes communicating clearly hard.  If you spell out individual problems
> > I will show you how I would solve
> > them.
> >
> 
> 
> It makes it a very different problem because YOU DON'T KNOW WHAT YOU'RE BOOTING
> UNTIL THE USER TELLS YOU.
> 
> In fact, depending on just exactly what you're doing, you might not even know
> what you're booting until you have already gotten several items downloaded
> (consider, for example, a device-probing bootloader.)
> 
> Therefore, the bootloader must be able to obtain boot medium services not just
> once and for all, but on a back-and-forth basis.  There needs to be an API
> between the boot loader and the firmware, and just "stuffing it into memory"
> doesn't count.

If you are correct, then there a fundamental design problem with my
Linux Booting Linux code.  Because that is exactly what I do.  I stuff
the kernel in memory and jump to it.  Once the new kernel starts there is
no back and forth.  _Please_ help me understand why this back and
forth is needed.  

Here is my experience.  Non-interactive etherboot, doesn't know what
it is booting, or where it is booting from until the DHCP server tells
it.  Then it gets a file from a TFTP server and boots that.

When booting the Linux kernel it never attempts to do a back and forth
via the firmware to the boot medium.  Instead someone has a clue about
what the boot medium was and it mounts that medium using it's own
drivers.  Booting a rescue cd is a good example.

_Please_ help me find the flaw in my understanding.  



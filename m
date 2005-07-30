Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbVG3SEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVG3SEN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVG3SEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:04:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263087AbVG3SD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:03:57 -0400
Date: Sat, 30 Jul 2005 11:02:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Khalid Aziz <khalid.aziz@hp.com>
Cc: khalid_aziz@hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050730110249.481ebb2d.akpm@osdl.org>
In-Reply-To: <1122737595.3133.7.camel@minuet.fc.hp.com>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<1122678354.20867.48.camel@lyra.fc.hp.com>
	<20050729161751.34705ac6.akpm@osdl.org>
	<1122737595.3133.7.camel@minuet.fc.hp.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid.aziz@hp.com> wrote:
>
> On Fri, 2005-07-29 at 16:17 -0700, Andrew Morton wrote:
>  > Khalid Aziz <khalid_aziz@hp.com> wrote:
>  > >
>  > > Serial console is broken on ia64 on an HP rx2600 machine on
>  > > 2.6.13-rc3-mm3. When kernel is booted up with "console=ttyS,...", no
>  > > output ever appears on the console and system is hung. So I booted the
>  > > kernel with "console=uart,mmio,0xff5e0000" to enable early console and
>  > > here is how far the kernel got before hanging:
>  > 
>  > (cc the ia64 and acpi lists)
>  > 
>  > OK, thanks.  There have been a few serial driver changes recently, but
>  > there's also a tremendous ACPI patch in -mm.  I'm wondering about those
>  > ACPI error messages:
>  > 
>  > > -------
>  > > Linux version 2.6.13-rc3-mm3 (root@mars) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #4 SMP Fri Jul 29 16:30:41 MDT 2005
>  > > EFI v1.10 by HP: SALsystab=0x3fb38000 ACPI 2.0=0x3fb2e000 SMBIOS=0x3fb3a000 HCDP=0x3fb2c000
>  > > booting generic kernel on platform hpzx1
>  > > PCDP: v0 at 0x3fb2c000
>  > > Explicit "console="; ignoring PCDP
>  > ..............
>  > > NET: Registered protocol family 16
>  > > ACPI: bus type pci registered
>  > > ACPI: Subsystem revision 20050708
>  > >     ACPI-0509: *** Error: Method execution failed [\PARS.GFIT] (Node e0000002ffff8a00), AE_BAD_PARAMETER
>  > >     ACPI-0509: *** Error: Method execution failed [\_SB_.SBA0._INI] (Node e0000002ffffa780), AE_BAD_PARAMETER
>  > > ACPI: Interpreter enabled
>  > > ACPI: Using IOSAPIC for interrupt routing
>  > 
>  > Does the above happen on 2.6.13-rc3 or 2.6.13-rc4?
> 
>  No, I do not see this on 2.6.13-rc3. It does seem ACPI is busted on
>  2.6.13-rc3-mm3 which is leading to kernel not being able to scan PCI bus
>  and set up IRQ routing.
> 

OK, thanks.  Could I suggest that you raise a bug against ACPI 20050708 at
bugzilla.kernel.org containing the info we've generated thus far?

And thanks for testing -mm: we really don't want to permit this to leak
into mainline...

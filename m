Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVBTKVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVBTKVC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVBTKVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:21:02 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48652 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261780AbVBTKUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:20:46 -0500
Date: Sun, 20 Feb 2005 10:20:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI interrupts. Fish. Please report.]
Message-ID: <20050220102037.C9509@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
References: <1108858971.8413.147.camel@localhost.localdomain> <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org> <1108863372.8413.158.camel@localhost.localdomain> <20050220082226.A7093@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050220082226.A7093@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Feb 20, 2005 at 08:22:26AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 08:22:26AM +0000, Russell King wrote:
> On Sat, Feb 19, 2005 at 08:36:12PM -0500, Steven Rostedt wrote:
> > Linux version 2.6.10 (root@bilbo) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #13 SMP Sat Feb 19 20:12:19 EST 2005
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
> >  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
> >  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
> >  BIOS-e820: 000000000f6f0000 - 000000000f700000 (reserved)
> >  BIOS-e820: 000000000f700000 - 000000003fef0000 (usable)
> >  BIOS-e820: 000000003fef0000 - 000000003fef8000 (ACPI data)
> >  BIOS-e820: 000000003fef8000 - 000000003fefa000 (ACPI NVS)
> >  BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
> 
> Your BIOS is broken.  You probably have 1GB of RAM which extends from
> 0x00000000 to 0x40000000.  However, there's a hole in the ACPI map
> between 0x3fefa000 and 0x3ff00000.

BTW, try passing:

	reserve=0x3fefa000,0x6000

to the kernel - this will mark the "hole" reserved and should reallocate
the resources which are clashing with the RAM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTE1JbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbTE1JbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:31:02 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:35818 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263990AbTE1Ja5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:30:57 -0400
Subject: Re: Machin dependent serial port patches
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jcwren@jcwren.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1053432549.30546.5.camel@dhcp22.swansea.linux.org.uk>
References: <200305192056.00610.jcwren@jcwren.com>
	 <1053432549.30546.5.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1054115049.2082.142.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Wed, 28 May 2003 10:44:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-20 at 13:09, Alan Cox wrote:
> On Maw, 2003-05-20 at 01:56, J.C. Wren wrote:
> > 	One of the things I noticed in the port of 2.5.69 to the 386EX embedded 
> > system is that serial.h appears to not be a mach-xxx positionable file.  The 
> > 386EX board uses standard 8250 type serial ports, but at 3.6864Mhz instad of 
> > 1.8432Mhz.  There appears to be no way to build a patch set without modifying 
> > include/i386/serial.h.  Would this not be better places in mach-defaults?  
> > I'm trying very hard to modify as few files as possible when building these 
> > patch sets.
> 
> Making asm-i386/serial.h include a mach- file sounds the right thing to
> do. mach- for x86 is pretty new so a lot of stuff that maybe should be
> in it, hasnt migrated yet.

I disagree. I think it would be better to get rid of the hard-coded
table altogether and let something in the machine-specific code call
register_serial() during early boot.

Even on PeeCee hardware, that lets us do the superio chip probe and
potentially register high-speed serial ports, before the pnpbios probe
and finally falling back to the old standard I/O addresses.

-- 
dwmw2


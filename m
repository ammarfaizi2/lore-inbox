Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVAAUZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVAAUZA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 15:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVAAUZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 15:25:00 -0500
Received: from [66.35.79.110] ([66.35.79.110]:47041 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261172AbVAAUYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 15:24:54 -0500
Date: Sat, 1 Jan 2005 12:24:50 -0800
From: Tim Hockin <thockin@hockin.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APIC, changing level/edge interrupt
Message-ID: <20050101202450.GA19360@hockin.org>
References: <41D1977D.2000600@drzeus.cx> <20050101054925.GA13925@hockin.org> <41D6C81F.1090106@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D6C81F.1090106@drzeus.cx>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2005 at 04:56:15PM +0100, Pierre Ossman wrote:
> >BIOS should set this up.  Maybe ACPI has a way to do this?

> Should doesn't always mean that it actually does ;)

Of course.  My point was that if it does not, it's a bug in the BIOS.  

> But since BIOS can configure the APIC then the kernel should be able to 

Of course, but the kernel has no way to know whether a device should be
edge or level triggered unless you have a driver for that device.  And
even if you do, I don't know that there is an API in kernel to say
set_irq_mode(IRQ_EDGE) (though there could be).

> What is the default mode and what does the XT-PIC expect? (it works fine 
> with the apic disabled).

I think default is PIC-compatible which is edge by default.  I think.  I
don;t have the book here.

> ACPI might have some functions to configure the APIC correctly but right 
> now the connection between ACPI and drivers is rather weak (non-existant 
> for this driver) so that's not really a viable solution when testing. 
> Might be a good long term solution though.

I know ACPI can get the information with the _PRS and _CRS methods.  The
OSPM core should probably be re-programming the (A)PIC appropriately.  Of
course, that depends on the BIOS vendor getting the ACPI correct, too.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318882AbSHEVyc>; Mon, 5 Aug 2002 17:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318886AbSHEVyc>; Mon, 5 Aug 2002 17:54:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28946 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318882AbSHEVyb>; Mon, 5 Aug 2002 17:54:31 -0400
Date: Mon, 5 Aug 2002 22:58:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: twaugh@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: parport_serial / serial init order wrong?
Message-ID: <20020805225805.C16793@flint.arm.linux.org.uk>
References: <E17boyC-0004rp-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17boyC-0004rp-00@alf.amelek.gda.pl>; from marekm@amelek.gda.pl on Mon, Aug 05, 2002 at 11:00:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 11:00:52PM +0200, Marek Michalkiewicz wrote:
> I suspect that the parport_serial driver should be initialized after
> the serial driver, so it can register the detected UARTs properly.
> (I have the necessary drivers compiled into the kernel, no modules.)

You are correct; the same bug just got fixed in the 2.5 series.

> I suspect the NM9835 may be a quite popular chip - any chances of
> making support for it available in 2.4.x kernel series?

Unfortunately its all controlled by the link ordering, and serial is
buried in within drivers/char.  Moving it before parport needs some
careful analysis and may very well end up breaking other stuff.

The simple answer for 2.4 may well be to move serial.c into
drivers/serial so it can be ordered into the right place on its own.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


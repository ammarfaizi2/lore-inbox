Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264831AbSKEOWX>; Tue, 5 Nov 2002 09:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbSKEOWX>; Tue, 5 Nov 2002 09:22:23 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:49937
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264831AbSKEOWW>; Tue, 5 Nov 2002 09:22:22 -0500
Date: Tue, 5 Nov 2002 09:30:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in
In-Reply-To: <20021105102055.B20224@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211050927350.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Russell King wrote:

> static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
> {
>         offset <<= up->port.regshift;
> 
>         switch (up->port.iotype) {
> 
> which also dereferences "up".  So something may have corrupted %ebx
> between executing that switch statement and executing the inb().
> 
> Could the NMI handler be corrupting %ebx ?

Yes that is highly likely, my current NMI handler does a fair amount of 
work, however it chains from the current default nmi handler, i thought 
register saving was already taken care of otherwise wouldn't i have all 
sorts of other strange bugs creeping up?

	Zwane
-- 
function.linuxpower.ca


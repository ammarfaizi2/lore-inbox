Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTLLQmC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTLLQmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:42:02 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:6277 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261188AbTLLQl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:41:59 -0500
Date: Fri, 12 Dec 2003 17:41:47 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Message-ID: <20031212164147.GA10758@vana.vc.cvut.cz>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se> <Pine.LNX.4.53.0312121000150.10423@chaos> <yw1xy8tixe96.fsf@kth.se> <Pine.LNX.4.53.0312121018450.10945@chaos> <yw1xr7zaxd7e.fsf@kth.se> <20031212160546.GA6363@vana.vc.cvut.cz> <yw1xad5yxapq.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xad5yxapq.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 05:27:45PM +0100, M?ns Rullg?rd wrote:
> Petr Vandrovec <vandrove@vc.cvut.cz> writes:
> 
> > On Fri, Dec 12, 2003 at 04:33:57PM +0100, M?ns Rullg?rd wrote:
> >> 
> >> I'm running 2.6.0-test11 on a machine with modular floppy driver,
> >> without any spinning motors.  I think it boots from floppy before HD,
> >> but I'm not certain (can't check right now).
> >
> > Maybe because you run patched LILO which works around this 2.6.x
> 
> GRUB, actually.  Does it mess with the floppy drive?

AFAIK yes:

NEWS:

New in 0.5 - 1998-08-20, Erich Boleyn:

 * GRUB now shuts off the floppy before transferring control to any
   other programs/modules/loaders.  (chain-loading doesn't matter here,
   just loading 32-bit modules/kernels)


stage2/asm.S:

/*
 * stop_floppy()
 *
 * Stops the floppy drive from spinning, so that other software is
 * jumped to with a known state.
 */
ENTRY(stop_floppy)
       movw    $0x3F2, %dx
       xorb    %al, %al
       outb    %al, %dx
       ret

						Petr Vandrovec


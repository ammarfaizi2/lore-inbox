Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUJAUqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUJAUqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUJAUli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:41:38 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:45649 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263743AbUJAUhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:37:10 -0400
Subject: RE: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       "'Roland =?ISO-8859-1?Q?Ca=DFebohm=27?=" 
	<roland.cassebohm@VisionSystems.de>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <010101c4a7f3$1ef63540$294b82ce@stuartm>
References: <010101c4a7f3$1ef63540$294b82ce@stuartm>
Content-Type: text/plain
Message-Id: <1096662993.2757.29.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 15:36:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 15:13, Stuart MacDonald wrote:
> I've come late to this discussion. Not sure what the scope of this
> cleanup is, but I'd like to see the flip buffers done away with
> entirely, to be replaced by a single buffer with proper r/w locking.
> Or keep the flip arrangement, but move it out of tty_struct so that it
> can be made larger. Some of our high speed products find the rx buffer
> to be less than sufficient.

This started as a bug report of a lockup under high load.
(2 ports @ 921600bps)

The cause was serial.c (kernel 2.4) not clearing
the receive IRQ if the flip buffer was full.
The ISR simply returned without flushing the
receive FIFO or disabling receive interrupts.
The short term cure for the lock up is to
flush the receive FIFO and discard the data.

The discussion then descended into analysis of the
flip buffer scheme in general. Everyone seems to agree
it should be eliminated or replaced.
It has synchronization problems for SMP.

Alan is busy reworking other tty locking
issues, and it probably annoyed by the noise
created by this thread :-)

I suspect when those issues are resovled there
will be an opportunity to submit suggestions and patches.

-- 
Paul Fulghum
paulkf@microgate.com


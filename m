Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTJWEfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 00:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTJWEfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 00:35:44 -0400
Received: from zok.SGI.COM ([204.94.215.101]:63725 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261683AbTJWEfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 00:35:43 -0400
Date: Wed, 22 Oct 2003 21:34:58 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: gwh@sgi.com, jbarnes@sgi.com, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch to add support for SGI's IOC4 chipset
Message-ID: <20031023043458.GB82539@sgi.com>
References: <3F7CB4A9.3C1F1237@sgi.com> <200310211639.28346.bzolnier@elka.pw.edu.pl> <20031022043058.GC80096@sgi.com> <200310222031.02243.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310222031.02243.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 08:31:02PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> I think there is another bug:
> 
> ...
> 	hwif->hw.ack_intr = &sgiioc4_checkirq;	/* MultiFunction Chip */
> ...
> 
> sgiioc4_clearirq() should be used instead of sgiioc4_checkirq() here,
> because otherwise IRQ won't be cleared.
> 
> In order to do this you must modify sgiioc4_clearirq() slightly,
> just change "return intr_reg;" to "return intr_reg & 0x03;".
> 
> If you wonder why, please look at ide_ack_intr() use in ide-io.c:ide_intr().

Thanks.  I've taken a look at it and have become puzzled.

It looks as though ide_ack_intr normally just "returns" 1 and has no
other effect.  But then I see some ide drivers that also have an ack_intr
routine.  On some (most?) architechtures, it would appear that the ack_intr
routine is not used, since the ide_ack_intr macro will not call it.

In gayle_ack_intr_a4000(), it looks as though all it does is read a
register and return something.  Is that register read supposed to clear
interrupt as a side effect.

So maybe an explicit clear is not needed on most implementations?

jeremy

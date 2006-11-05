Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965825AbWKEEBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965825AbWKEEBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965828AbWKEEBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:01:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:60847 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965825AbWKEEBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:01:23 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
	 <1162678639.28571.63.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
	 <1162689005.28571.118.camel@localhost.localdomain>
	 <1162697533.28571.131.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 15:00:55 +1100
Message-Id: <1162699255.28571.150.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-04 at 19:46 -0800, Linus Torvalds wrote:
> 
> On Sun, 5 Nov 2006, Benjamin Herrenschmidt wrote:
> >
> > Make the generic lib/iomap.c use arch provided MMIO accessors when
> > available for big endian and repeat operations. Also while at it,
> > fix the *_be version which are currently broken for PIO
> 
> Just rip the _be versions out, methinks.

At least one user:

./drivers/scsi/53c700.h:        __u32 value = bEBus ? ioread32be(hostdata->base + reg) :
./drivers/scsi/53c700.h:        bEBus ? iowrite32be(value, hostdata->base + reg):

Should I make it use explicit swab32 instead ?

Ben.



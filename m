Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbTAURMQ>; Tue, 21 Jan 2003 12:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbTAURMQ>; Tue, 21 Jan 2003 12:12:16 -0500
Received: from [217.167.51.129] ([217.167.51.129]:48844 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267120AbTAURMP>;
	Tue, 21 Jan 2003 12:12:15 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@redhat.com>
Cc: Ross Biro <rossb@google.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1043105473.12609.5.camel@dhcp22.swansea.linux.org.uk>
References: <200301131946.h0DJk1w32012@devserv.devel.redhat.com>
	 <1042565893.587.66.camel@zion.wanadoo.fr>
	 <1043105473.12609.5.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043168835.688.38.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 21 Jan 2003 18:07:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 00:31, Alan Cox wrote:
> On Tue, 2003-01-14 at 17:38, Benjamin Herrenschmidt wrote:
> > > Fatal on PIIX PIO
> > 
> > Ok, but PIIX runs on intel platforms with real IOs, so there is no need
> > to perform a read... If we go the hwif->IOSYNC() way, we might well set
> > it up to no-op on x86 PIO iops by default and read of alt-status on
> > other archs if it's safe enough on other controllers/drives...
> 
> PIIX is also found on MIPS, IA-64 and some other platforms. I also fear
> that bug may be far from unique

Then we may want to have the actual implementation of the default iops
IOSYNC() for PIO & MMIO be arch specific. I would suggest nothing for
PIO on x86 and at least and mb() on others. For MMIO, then, we have the
choice of reading the alt status, or reading the dma_base if any.

Of course these are defaults, I expect controllers like ide-pmac to
implement their own IOSYNC.

That means that we must _both_ call IOSYNC and do the 400ns delay (I
don't trust reading alt status to be enough, especially on MMIO based
controlers, also, on ide-pmac, I plan to go read some other register
instead).

What do you think ?

Ben.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267193AbUHWASV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267193AbUHWASV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 20:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUHWASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 20:18:21 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:49107 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S267193AbUHWASL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 20:18:11 -0400
Date: Mon, 23 Aug 2004 02:18:05 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.8.1-mm2: floppy magically disappaperd
Message-ID: <20040823001805.GA11315@irc.pl>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	linux-kernel@vger.kernel.org
References: <20040819121035.035be585.akpm@osdl.org> <200408201122.45779.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408201122.45779.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 11:22:45AM -0600, Bjorn Helgaas wrote:
> >  My flopped disappeared with this kernel becaouse of ACPI. It was
> > working earlier revisions. Modprobing floppy.ko fails:
> > 
> > (in dmesg)
> > #v+
> > inserting floppy driver for 2.6.8.1-mm2
> > floppy: controller ACPI FDC0 at I/O 0x3f7-0x3f7 irq 6 dma channel 2
> > Floppy drive(s): fd0 is 1.44M
> > floppy0: Floppy io-port 0x03f7 in use
> > #v-
> I'm interested in the dmesg output whether it works or not.
> 
> I suspect your ACPI is reporting two I/O regions for the floppy
> controller: 0x3f2-0x3f5, and 0x3f7.  Strictly speaking, that's
> probably the correct thing.  It happens that my box (an HP DL360)
> only reports 0x3f2-0x3f5.  The driver uses 0x3f7, and I don't see
> how it could get along without it, so I think the HP BIOS is broken.
> 
> In any case, the patch below should deal better with two I/O regions
> being reported.

 Good news! With your patch floppy works:

#v+
inserting floppy driver for 2.6.8.1-mm2
acpi_floppy_resource: 4 ioports at 0x3f2
acpi_floppy_resource: 1 ioports at 0x3f7
floppy: controller ACPI FDC0 at I/O 0x3f2-0x3f5, 0x3f7-0x3f7 irq 6 dma
channel 2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
#v-
 
 Thank you! 

-- 
Tomasz Torcz                Only gods can safely risk perfection,     
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia


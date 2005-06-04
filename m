Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVFDSXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVFDSXU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 14:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFDSXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 14:23:20 -0400
Received: from colo.lackof.org ([198.49.126.79]:7145 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261408AbVFDSXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 14:23:14 -0400
Date: Sat, 4 Jun 2005 12:26:45 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bodo Eggert <7eggert@gmx.de>, Dipankar Sarma <dipankar@in.ibm.com>,
       Grant Grundler <grundler@parisc-linux.org>, awilliam@fc.hp.com,
       bjorn.helgaas@hp.com
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050604182645.GD19823@colo.lackof.org>
References: <1117882628.42a1890479c23@imap.linux.ibm.com> <Pine.LNX.4.44L0.0506041126030.5133-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0506041126030.5133-100000@iolanthe.rowland.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 11:35:59AM -0400, Alan Stern wrote:
> On Sat, 4 Jun 2005, Vivek Goyal wrote:
> 
> > Hi Alan, I know very little about consoles and their working.
> > I had a question. Even if console is being managed by platform firmware, in
> > initial states of booting, does it require interrupts to be enabled at 
> > VGA contorller (at least for the simple text mode). I was quickly browsing
> > through drivers/video/console/vgacon.c and did not look like that this
> > console driver needed interrupts to be enabled at the controller.
> 
> This isn't an issue for VGA, as far as I know.  It applies to
> architectures like PPC-64 and perhaps Alpha or PA-Risc.  And I don't know
> the details; ask Grant Grundler.

I'm more familiar with the serial consoles and how PDC interacts with them.
>From HP, both Alex Williamson and Bjorn Helgaas know more about
VGA support. I've cc'd both.

> > Anyway, looks like serial consoles will always work. So at least this can be
> > done for kdump case (CONFIG_CRASH_DUMP) and not generic kernel. Or, as I
> > mentioned in previous mail, while pre-loading capture kernel, pass a command
> > line parameter containing pci dev id of console and capture kernel does not 
> > disable interrupts on this console.  

parisc serial consoles don't need interrupts enabled. The serial device
does need it's MMIO and/or IO Port range enabled (I forgot which).
ISTR most serial consoles don't do DMA and thus don't need BusMaster
enabled in the PCI command register either.

> I suspect you're right that implementing this only in kdump kernels will 
> work okay.
> 
> For people interesting in reading some old threads on the subject, here 
> are some pointers:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=111055702309788&w=2
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=98383052711171&w=2

wow...from 2001.
That's when we first release a500 support with Debian 3.0.

thanks,
grant

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWJMSKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWJMSKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWJMSKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:10:36 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37132 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751788AbWJMSKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:10:35 -0400
Date: Fri, 13 Oct 2006 14:10:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Helge Hafting <helge.hafting@aitel.hist.no>, Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
In-Reply-To: <20061013092941.30500a15.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0610131408240.6612-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Andrew Morton wrote:

> On Fri, 13 Oct 2006 15:11:11 +0200
> Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> 
> > Andrew Morton wrote:
> > > On Thu, 12 Oct 2006 14:18:04 +0200
> > > Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> > >
> > >   
> > >> I found an easy way to hang the kernel when copying a SD-card:
> > >>
> > >> dd if=/dev/sdc of=file bs=1048576
> > >>
> > >> I.e. copy the entire 256MB card in 1MB chunks.  I got about
> > >> 160MB before the kernel hung.  Not even sysrq+B worked, I needed
> > >> the reset button.  The pc has a total of 512MB memory if that matters.
> > >>
> > >> Using bs=4096 instead let me copy the entire card with no problems,
> > >> but that seems to progress slower.
> > >>
> > >> The above 'dd' command hangs my office pc every time. So I can repeat
> > >> it for debugging purposes. 
> > >>
> > >>     
> > >
> > > What device driver is providing /dev/sdc?
> > >   
> > It is an usb card reader, so it is "usb mass storage"
> > and "scsi disk".
> > > Did any previous kernels work correctly?  If so, which?
> > >   
> > 
> > I just got that card reader, so I haven't tested any earlier kernels.
> > I have another machine with a card reader, which I have used for
> > a long time. But I only ever copy files with "cp" on that one.
> > 
> > This time I used "dd" to get an image of the entire card, and got trouble
> > when using 1M chunks. 
> > 
> > I can try with verbose scsi debug messages if that might help?

Verbose usb-storage debugging messages would help more 
(CONFIG_USB_STORAGE_DEBUG and CONFIG_USB_DEBUG).  If the kernel hangs very 
badly you might need to use a serial console to capture all the logging 
information.

Alan Stern


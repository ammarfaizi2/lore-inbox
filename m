Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751936AbWJMVIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWJMVIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWJMVIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:08:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38408 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751928AbWJMVIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:08:47 -0400
Date: Fri, 13 Oct 2006 17:08:46 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Open Source <opensource3141@yahoo.com>
cc: =?iso-8859-1?Q?WolfgangM=FCes?= <wolfgang@iksw-muees.de>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13
 (CRITICAL???)
In-Reply-To: <20061013193107.43500.qmail@web58109.mail.re3.yahoo.com>
Message-ID: <Pine.LNX.4.44L0.0610131703030.8377-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Open Source wrote:

> Hi Wolfgang (and all),
> 
> Thanks for the input.  However, I am not understanding
> exactly why kernel mode is treated any differently than
> user mode for this sort of thing.  I am looking at the code
> in ehci-q.c and ehci-hcd.c.
> 
> It seems like the unlinking of completed URBs
> happens asynchronously on a timer.  This is a
> surprise to me since I thought this was happening
> on an IRQ from the host controller.  But if what I'm
> surmising is correct it would explain everything
> I am seeing.  I'm not able to ascertain how
> user mode drivers are treated differently than
> kernel mode drivers in this regard.  From what I
> can tell, all drivers would be broken equally!
> Can anyone who has more experience
> with this code confirm this for me?

I don't think so.  You must be mis-reading the code.  The only timers used 
in ehci-hcd are a couple of watchdogs; they shouldn't affect the normal 
URB completions which occur within ehci_work(), called by ehci_irq().

What Wolfgang meant was that user processes are subject to unpredictable 
delays from all kinds of sources.

Alan Stern


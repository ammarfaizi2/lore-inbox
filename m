Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWJMSC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWJMSC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWJMSC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:02:59 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60171 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751587AbWJMSC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:02:58 -0400
Date: Fri, 13 Oct 2006 14:02:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Open Source <opensource3141@yahoo.com>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13
 (CRITICAL???)
In-Reply-To: <20061013172042.21215.qmail@web58113.mail.re3.yahoo.com>
Message-ID: <Pine.LNX.4.44L0.0610131359510.6612-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Open Source wrote:

> Hi all,
> 
> I just tested using CONFIG_HZ_1000=y and
> CONFIG_HZ=1000 and as expected, this change
> improves the throughput.  Thank you Lee for pointing
> that out so quickly.
> 
> Alan -- yes, I understand the ability to increase throughput
> by transfering more bytes and I am definitely able to see
> better overall throughput when increasing the number
> of bytes per transaction.  However, I needs to still have
> good transaction-level timing because I cannot always
> queue the transactions up.  Recall that each transaction
> is a WRITE followed by a READ.  The results of the
> READ determine the outgoing bytes for the following
> transaction's WRITE.
> 
> Not to sound like a broken record, but there is something
> seriously wrong here.  This has to be a bug somewhere.
> It could be very well just be something as simple as
> issuing the right incantation with libusb, devio, etc.  But,
> I've been using libusb for years now and am at a loss
> on what might have changed to require this.
> 
> Any ideas???

Try using usbmon to get a detailed record of events with high-precision
timestamps.  Maybe also add similar logging to your program.  This may
suggest some ideas about where the slowdown originates.

It's possible that some process you're unaware of is using the CPU, and 
the reduced clock rate increases the latency for your process to continue 
running.

Alan Stern


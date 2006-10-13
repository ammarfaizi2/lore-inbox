Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWJMN4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWJMN4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWJMN4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:56:36 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:31753 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750728AbWJMN4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:56:35 -0400
Date: Fri, 13 Oct 2006 09:56:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Open Source <opensource3141@yahoo.com>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13
 (CRITICAL???)
In-Reply-To: <20061012193313.4281.qmail@web58107.mail.re3.yahoo.com>
Message-ID: <Pine.LNX.4.44L0.0610130952090.6460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[FYI, it would make things easier for the rest of us if you can convince 
your email client to wrap lines before 80 columns.]

On Thu, 12 Oct 2006, Open Source wrote:

> Hi all, 
>  I am writing regarding a performance issue that I recently observed
> after upgrading from kernel 2.6.12 to 2.6.17.  I did some hunting around
> and have found that the issue first arises in 2.6.13.
> 
> I am using a device that submits URBs asynchronously using the libusb
> devio infrastructure.  In version 2.6.12 I am able to submit and reap
> URBs for my particular application at a transaction rate of one per
> millisecond.  A transaction consists of a single WRITE URB (< 512 bytes)
> followed by a single READ URB (1024 bytes).  Once I upgrade to version
> 2.6.13, the transactional rate drops to one per 4 milliseconds!
> 
> The overall performance of a particular algorithm is increased from a
> total execution time of 75 seconds to over 160 seconds.  The only
> difference between the two tests is the kernel.  Microsoft Windows
> executes the algorithm in 70-75 seconds!
> 
> I am using a Fedora Core distribution with FC4 kernels for testing.  Is
> there some new incantation that is required in my user-mode driver to
> get around a "feature" in recent kernels?  Does anyone else know about
> this?  I was not able to easily find discussion about this on the
> newsgroups.  It appears that this problem has been around for a while,
> if it is indeed a problem.

I'll be interested to here if changing HZ back to 1000 makes any 
difference.  As others have already stated, it shouldn't matter but maybe 
it does somehow.

Even if it does, there are things you might be able to do with HZ=250 to 
improve throughput.  You could transfer more than 512/1024 bytes per URB.  
You could queue multiple URBs before waiting for the first one to 
complete.  Provided you can keep the endpoint queues filled, you should be 
able to achieve the maximum throughput of the hardware.

Alan Stern


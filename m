Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUCDCwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUCDCwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:52:21 -0500
Received: from mail.tpgi.com.au ([203.12.160.59]:16538 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261425AbUCDCwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:52:02 -0500
Subject: Re: Resume only part of device tree?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1078353622.15320.25.camel@gaston>
References: <1078344202.3203.22.camel@calvin.wpcb.org.au>
	 <1078353622.15320.25.camel@gaston>
Content-Type: text/plain
Message-Id: <1078361326.3203.47.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Thu, 04 Mar 2004 13:48:46 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

My implementation saved the image in two parts. 'Pageset 2' contains the
LRU pages (active & inactive lists). 'Pageset 1' contains all other data
to be saved. At resume time, I read pageset 1 and copy the original
kernel data back. Then I want to resume the storage devices and read
pageset 2 before resuming all devices and waking everything else up. It
would also be good to not resume all devices when writing the state to
the swap partition, but I have other means of ensuring the consistency
of the image that mean I'm not so worried then.

Regards,

Nigel

On Thu, 2004-03-04 at 11:40, Benjamin Herrenschmidt wrote:
> On Thu, 2004-03-04 at 07:03, Nigel Cunningham wrote:
> > Hi all.
> > 
> > Is there any existing code in the device model that supports resuming a
> > part of the device tree? For Suspend2, I'm wanting to resume storage
> > devices (and their parents) part way through resuming, and other drivers
> > later.
> 
> What is your exact goal ? Not resuming all devices when writing the
> state to the swap partition ?
> 
> You really need to resume it all at this point. However, the optimisation
> that can be done is for some drivers to not put the HW to sleep on a
> swsusp transition, only freeze the state. I did something like that in
> IDE though that doesn't always work well due our "state" paremeter passed
> down to drivers not beeing consistent.
> 
> Ben.
> 
-- 


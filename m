Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWGRQZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWGRQZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWGRQZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:25:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52430 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751360AbWGRQZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:25:48 -0400
Message-ID: <44BD0B80.3010908@garzik.org>
Date: Tue, 18 Jul 2006 12:25:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Dave Boutcher <boutcher@cs.umn.edu>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/33] Add Xen virtual block device driver.
References: <20060718091807.467468000@sous-sol.org>	<20060718091958.657332000@sous-sol.org> <17596.56260.541661.919437@hound.rchland.ibm.com>
In-Reply-To: <17596.56260.541661.919437@hound.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Boutcher wrote:
> On Tue, 18 Jul 2006 00:00:33 -0700, Chris Wright <chrisw@sous-sol.org> said:
>> The block device frontend driver allows the kernel to access block
>> devices exported exported by a virtual machine containing a physical
>> block device driver.
> 
> First, I think this belongs in drivers/block (and the network driver
> belongs in drivers/net).  If we're going to bring xen to the party,
> lets not leave it hiding out in a corner.

Strongly agreed.


>> +static void connect(struct blkfront_info *);
>> +static void blkfront_closing(struct xenbus_device *);
>> +static int blkfront_remove(struct xenbus_device *);
>> +static int talk_to_backend(struct xenbus_device *, struct blkfront_info *);
>> +static int setup_blkring(struct xenbus_device *, struct blkfront_info *);
>> +
>> +static void kick_pending_request_queues(struct blkfront_info *);
>> +
>> +static irqreturn_t blkif_int(int irq, void *dev_id, struct pt_regs *ptregs);
>> +static void blkif_restart_queue(void *arg);
>> +static void blkif_recover(struct blkfront_info *);
>> +static void blkif_completion(struct blk_shadow *);
>> +static void blkif_free(struct blkfront_info *, int);
> 
> I'm pretty sure you can rearrange the code to get rid of the forward
> references. 

I've never thought this was useful...  If the function ordering helps 
the human...


>> +	switch (backend_state) {
>> +	case XenbusStateUnknown:
>> +	case XenbusStateInitialising:
>> +	case XenbusStateInitWait:
>> +	case XenbusStateInitialised:
>> +	case XenbusStateClosed:
> 
> This actually should get fixed elsewhere, but SillyCaps???

Agreed.



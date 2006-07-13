Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWGMOjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWGMOjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWGMOjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:39:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47562 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751546AbWGMOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:39:48 -0400
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Organov <osv@javad.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <8764i1h9nd.fsf@javad.com>
References: <1151646482.3285.410.camel@tahini.andynet.net>
	 <20060630001021.2b49d4bd.akpm@osdl.org> <87veq9cosq.fsf@javad.com>
	 <1152302831.20883.63.camel@localhost.localdomain>
	 <87d5cdg308.fsf@javad.com>
	 <1152529855.27368.114.camel@localhost.localdomain>
	 <873bd9fobb.fsf@javad.com>
	 <1152552683.27368.185.camel@localhost.localdomain>
	 <8764i1h9nd.fsf@javad.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jul 2006 16:40:45 +0100
Message-Id: <1152805246.17919.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-07-13 at 18:17 +0400, Sergei Organov wrote:
> This problem may occur with any tty driver that doesn't stop to insert
> data into the tty buffers in throttled state. And yes, there are such
> drivers in the tree. Before Paul's changes, the tty just dropped bytes
> that aren't accepted by ldisc, so this problem had no chances to arise.

You must honour throttle. That has always been the case. At all times
you should attempt to homour tty->receive_room and also ->throttle. If
you don't it breaks. There will always be some "reaction time" overruns.

> latter cases drivers that insert too much data without pushing to ldisc
> may cause similar problem. Anyway, you definitely know better what to do
> about it.

Might be a good idea to put a limiter in before 2.6.18 proper just to
trap any other drivers that have that bug. At least printk a warning and
refuse the allocation once there is say 64K queued. That way the driver
author gets a hint all is not well.

Alan


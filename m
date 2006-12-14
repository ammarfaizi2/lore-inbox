Return-Path: <linux-kernel-owner+w=401wt.eu-S1751948AbWLNSHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWLNSHp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbWLNSHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:07:45 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:51114 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbWLNSHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:07:44 -0500
Date: Thu, 14 Dec 2006 19:04:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <Pine.LNX.4.64.0612140926290.5718@woody.osdl.org>
Message-ID: <Pine.LNX.4.61.0612141900390.12730@yvahk01.tjqt.qr>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <1166044471.11914.195.camel@localhost.localdomain>
 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
 <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0612141224190.6223@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612140926290.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 14 2006 09:32, Linus Torvalds wrote:
>On Thu, 14 Dec 2006, Jan Engelhardt wrote:
>> 
>> Rather than IRQ_HANDLED, it should have been: remove this irq
>> handler from the irq handlers for irq number N, so that it does
>> not get called again until userspace has acked it.
>
>That just means that the _handler_ won't be called. But the irq
>still stays active, and if it's shared, ALL THE OTHER HANDLERS FOR
>THAT INTERRUPT will be called.
>[...]
>And the reason was that it would send an irq, but we were expecting
>it on another interrupt. But if it showed up on something that was
>shared, you'd have a hung machine, because you'd just have the (say)
>ethernet driver saying "not for me", and returning. And obviously
>not able to actually shut it up, so when we returned from the
>interrupt handler, the interrupt happened immediately again.

Thanks for this explanation, I see the point. Removing the uio irq
handler will leave the irq chain only with "not for me" devices. In
that case, would it make sense to install a replacement uio handler
that says "yes, that's mine" [but ignoring it since userspace has not
yet finished with it]? (I think I've gotten into a loop since that
would be the IRQ_HANDLED case.) Mh, delicate problem.


	-`J'
-- 

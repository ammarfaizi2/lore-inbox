Return-Path: <linux-kernel-owner+w=401wt.eu-S1751000AbWLMVOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWLMVOo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWLMVOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:14:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:51999 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbWLMVOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:14:43 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 08:14:31 +1100
Message-Id: <1166044471.11914.195.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, what kind of ass-hat idiotic thing is this?
> 
> 	irqreturn_t uio_irq_handler(int irq, void *dev_id)
> 	{
> 	        return IRQ_HANDLED;
> 	}
> 
> exactly what is the point here? No way will I pull this kind of crap. You 
> just seem to have guaranteed a dead machine if the irq is level-triggered, 
> since it will keep on happening forever.
> 
> Please remove.
> 
> YOU CANNOT DO IRQ'S BY LETTING USER SPACE SORT IT OUT!

Actually, you can... but wether you want is a different story :-)

You can simply mask it, have it handled by userspace and re-enable it
when that's done. Though say hello to horrible interrupt latencies and
hope you aren't sharing it with anything critical...

I don't mean I -like- the approach... I just say it can be made to
sort-of work. But I don't see the point.

Ben.


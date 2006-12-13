Return-Path: <linux-kernel-owner+w=401wt.eu-S1751083AbWLMV0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWLMV0k (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWLMV0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:26:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43832 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbWLMV0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:26:39 -0500
Date: Wed, 13 Dec 2006 13:26:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <1166044471.11914.195.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <1166044471.11914.195.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2006, Benjamin Herrenschmidt wrote:
>
> Actually, you can... but wether you want is a different story :-)
> 
> You can simply mask it, have it handled by userspace and re-enable it
> when that's done.

Nope. Again, this whole mentality is WRONG.

It DOES NOT WORK. No architecture does per-device interrupts portably, 
which means that you'll always see sharing. 

And once you see sharing, you have small "details" like the harddisk 
interrupt or network interrupt that the user-land driver will depend on.

Oops. Instant deadlock.

> I don't mean I -like- the approach... I just say it can be made to
> sort-of work. But I don't see the point.

No. The point really is that it fundamentally _cannot_ work. Not in the 
real world.

It can only work in some alternate reality where you can always disable 
interrupts per-device, and even in that alternate reality it would be 
wrong to use that quoted interrupt handler: not only do you need to 
disable the irq, you need to have an "acknowledge" phase too

So you'd actually have to fix things _architecturally_, not just add some 
code to the irq handler.

		Linus

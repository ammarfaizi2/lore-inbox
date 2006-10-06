Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWJFOQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWJFOQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWJFOQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:16:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7838 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932354AbWJFOQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:16:25 -0400
Message-ID: <45266523.9040408@garzik.org>
Date: Fri, 06 Oct 2006 10:16:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing
 to IRQ handlers
References: <20061002132116.2663d7a3.akpm@osdl.org>	 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>	 <18975.1160058127@warthog.cambridge.redhat.com>	 <4525A8D8.9050504@garzik.org>	 <1160133932.1607.68.camel@localhost.localdomain>	 <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu>	 <45263D9C.9030200@garzik.org> <20061006112550.GA21733@elte.hu> <d120d5000610060707p13a9e97fkcb1219164da3f2d1@mail.gmail.com>
In-Reply-To: <d120d5000610060707p13a9e97fkcb1219164da3f2d1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 10/6/06, Ingo Molnar <mingo@elte.hu> wrote:
>>
>> * Jeff Garzik <jeff@garzik.org> wrote:
>>
>> > >but pt_regs is alot less frequently used than irq - and where it's
>> > >used they arent "drivers" but mostly arch level code like hw-timer
>> > >handlers.
>> >
>> > Nonetheless the -vast majority- of drivers don't use the argument at
>> > all, and the minority that do use it are not modern drivers.
>>
>> i'm all for changing that too :)
>>
> 
> What drivers use irq argument? I know i8042 does but only to detect
> whether interrupt routine was called because irq was raised or it was
> called manually and I can use dev_id for that...

Ancient ISA legacys, a few powermac drivers, and a lot of printk's. 
Your gut instinct is correct -- outside of printk, it is largely used to 
differentiate callers.

	Jeff




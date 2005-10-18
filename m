Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVJRB6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVJRB6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVJRB6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:58:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18322 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932365AbVJRB6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:58:03 -0400
Message-ID: <435456A1.6020208@pobox.com>
Date: Mon, 17 Oct 2005 21:57:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc4-rt6, skge vs. sk98lin
References: <1129599910.5031.3.camel@cmn3.stanford.edu>
In-Reply-To: <1129599910.5031.3.camel@cmn3.stanford.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:
> I'm running 2.6.14-rc4-rt6 and trying the skge driver instead of the
> sk98lin and I'm getting these warnings in my logs (this is probably not
> related to the rt patch):
> 
>   network driver disabled interrupts: skge_xmit_frame+0x0/0x320 [skge]
> 
> No other relevant messages around that I can see. Is this a bug? Any
> information I could supply to help debug it?

This is a bogus message added by the -rt patch.  It is not a bug.

The trylock scheme in some newer net drivers (grep for NETDEV_TX_LOCKED) 
uses local_irq_save/restore because there is no 
spin_trylock_irqsave/spin_trylock_failed_irqrestore API.

	Jeff



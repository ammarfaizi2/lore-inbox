Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbTA0RZV>; Mon, 27 Jan 2003 12:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbTA0RZV>; Mon, 27 Jan 2003 12:25:21 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:12325 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267215AbTA0RZV>; Mon, 27 Jan 2003 12:25:21 -0500
Message-ID: <3E356DAA.6090108@google.com>
Date: Mon, 27 Jan 2003 09:34:34 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <rossb@google.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: [2.4.18+] IDE Race Condition
References: <3E356854.1090100@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The net effect of this race condition and the other one I spotted is 
that you may see some interesting messages in your log file and you can 
detect the race condition if you look for it hard enough.  I don't 
currently see any bad effects.

    Ross

Ross Biro wrote:

>
> There is at least one more IDE race condition in 2.4.18 and 
> 2.4.21-pre3. Basically the interrupt for the controller being serviced 
> is left on while setting up the next command.  I'm not sure how much 
> trouble it can cause but it does lead to some interesting stack traces.
>
> The condition
> if (masked_irq && hwif->irq != masked_irq)
> in ide_do_request should be replaced with
> if (!masked_irq || hwif->irq != masked_irq)
> in two places.
>



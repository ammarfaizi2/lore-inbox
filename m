Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVBRQbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVBRQbC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVBRQbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:31:02 -0500
Received: from smtp11.wanadoo.fr ([193.252.22.31]:51 "EHLO smtp11.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261399AbVBRQar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:30:47 -0500
X-ME-UUID: 20050218163042968.EC7411C00083@mwinf1109.wanadoo.fr
Message-ID: <421617D3.4080207@innova-card.com>
Date: Fri, 18 Feb 2005 17:29:07 +0100
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org, linux-os@analogic.com, pmarques@grupopie.com
Subject: Re: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com> <42160290.3070000@microgate.com>
In-Reply-To: <42160290.3070000@microgate.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Second point, a lot of serial drivers call in their interrupt handler
>> "tty_flip_buffer_push" function. This function must no be called
>> in interrupt context. Why is it done anyway ?
>
>
> Calling tty_flip_buffer_push() is fine from interrupt
> as long as tty->low_latency is not set. It just queues
> work for later.
>
I was looking at driver for 8250 in 8250.c file and at the end
of "receive_chars" interrupt handler, it calls "tty_flip_buffer_push"
even if "tty->low_latency" is set since no such test is done before
the call...
I was also wondering why not always calling "schedule_delayed_work"
whatever the state of "tty->latency"?

          Franck


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVBRO71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVBRO71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 09:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVBRO71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 09:59:27 -0500
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:29578
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S261208AbVBRO7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 09:59:23 -0500
Message-ID: <42160290.3070000@microgate.com>
Date: Fri, 18 Feb 2005 08:58:24 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: franck.bui-huu@innova-card.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com>
In-Reply-To: <4215B5AC.4050600@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> Looking at TTY code, I noticed a weird test done in "opost_bock"
> located in n_tty.c file. I don't understand why the following test is
> done at the start of the function:
> if (nr > sizeof(buf))
>        nr = sizeof(buf);
> Actually it limits the size of processing blocks to 4 bytes and I can't
> find a reason why.

No, it limits the size to 80 bytes,
which is the size of buf.

sizeof returns the size of the char array buf[80]
(standard C)

> Second point, a lot of serial drivers call in their interrupt handler
> "tty_flip_buffer_push" function. This function must no be called
> in interrupt context. Why is it done anyway ?

Calling tty_flip_buffer_push() is fine from interrupt
as long as tty->low_latency is not set. It just queues
work for later.

-- 
Paul Fulghum
Microgate Systems, Ltd.

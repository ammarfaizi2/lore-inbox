Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVBRQmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVBRQmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVBRQmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:42:23 -0500
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:57483
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S261404AbVBRQmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:42:19 -0500
Message-ID: <42161A9D.1080406@microgate.com>
Date: Fri, 18 Feb 2005 10:41:01 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: franck.bui-huu@innova-card.com
CC: linux-kernel@vger.kernel.org, linux-os@analogic.com, pmarques@grupopie.com
Subject: Re: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com> <42160290.3070000@microgate.com> <421617D3.4080207@innova-card.com>
In-Reply-To: <421617D3.4080207@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> I was looking at driver for 8250 in 8250.c file and at the end
> of "receive_chars" interrupt handler, it calls "tty_flip_buffer_push"
> even if "tty->low_latency" is set since no such test is done before
> the call...

Yes this is a known problem. In the case of SMP kernel
and low_latency, and 8250.c, this causes a dead lock. This has
resurfaced again and again for many months from
different sources.

There is disagreement on what code is
in error and what should be fixed. So it stays broken.

> I was also wondering why not always calling "schedule_delayed_work"
> whatever the state of "tty->latency"?

If low_latency is set and you are not calling
from interrupt, then calling work directly speeds processing.

I submitted a patch that forced schedule_delayed_work
if in interrupt context to avoid this problem. It was rejected.

-- 
Paul Fulghum
Microgate Systems, Ltd.

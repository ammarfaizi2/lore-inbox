Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSLVV2y>; Sun, 22 Dec 2002 16:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSLVV2y>; Sun, 22 Dec 2002 16:28:54 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:43278 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265437AbSLVV2x>; Sun, 22 Dec 2002 16:28:53 -0500
Date: Sun, 22 Dec 2002 19:36:53 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Joshua Stewart <joshua.stewart@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: From __cpu_raise_softirq() to net_rx_action()
Message-ID: <20021222213652.GD4942@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Joshua Stewart <joshua.stewart@comcast.net>,
	linux-kernel@vger.kernel.org
References: <1040591503.11608.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040591503.11608.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 22, 2002 at 04:11:37PM -0500, Joshua Stewart escreveu:
> I'm still trying to follow a packet (or even better an sk_buff) from the
> NIC card to user space.  I think I have a good chunk of it figured out,
> but I'm missing a bit from the time that the __netif_rx_schedule()
> routine calls __cpu_raise_softirq() until the routine net_rx_action()
> occurs.  I read in a book on Linux TCP/IP implementation that the
> softirq basically leads to a call to net_rx_action(), but I don't see
> the connection yet.  It's probably due to my lack of understanding of
> IRQ's (and software IRQ's).

You need to read about softirqs, but here is a quick explanation: there are
several points where softirqs are serviced, like bottom halves were in the
past (softirqs are much nicer), one example:

do_IRQ -> irq_exit -> do_softirq -> net_rx_action

So basically search for places calling do_softirq, they look if there is
softirqs pending and call do_softirq that will call the appropriate _action
function registered at softirq creation (look at net/core/dev.c, function
net_dev_init, line 2875.

- Arnaldo

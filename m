Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263296AbTC0Qta>; Thu, 27 Mar 2003 11:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263297AbTC0Qta>; Thu, 27 Mar 2003 11:49:30 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:54031
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S263296AbTC0Qt0>; Thu, 27 Mar 2003 11:49:26 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33E09@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'henrique.gobbi@cyclades.com'" <henrique.gobbi@cyclades.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: RE: Interpretation of termios flags on a serial driver
Date: Thu, 27 Mar 2003 09:00:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 7:33 AM, Henrique Gobbi wrote:
> 
> Thanks for the feedback.
> 
> > If PARENB is set you generate parity. It is ODD parity if PARODD
> > is set, otherwise it's EVEN. There is no provision to generate
> > "stick parity" even though most UARTS will do that. When you
> > generate parity, you can also ignore parity on received data if
> > you want.  This is the IGNPAR flag.
> 
> Ok. But, considering the 2 states of the flag IGNPAR, what should the 
> driver do with the chars that are receiveid with wrong 
> parity, send this 
> data to the TTY with the flag TTY_PARITY or just discard this data ?
> 
Hi Henrique,

The driver should send all characters with parity errors to the line
discipline marked with TTY_PARITY. The driver is supposed to handle the
hardware. The line discipline is supposed to handle any higher level
protocol. Ideally, the driver should not know or care about the state of
flags like IGNPAR, that are not needed to configure the hardware. 

Two common exceptions are:

1. "smart" UART hardware that directly handles some of the higher level
protocol, so the driver needs to know the higher level settings so it can
configure the hardware properly.

2. defensive actions to avoid bogging down the whole system with interrupt
storms from noisy or unconnected modem status inputs, where the driver could
mask off interrupts on modem status when the higher level options dictate
that all such status will be ignored.

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------


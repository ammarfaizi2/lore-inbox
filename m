Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbRFUQgq>; Thu, 21 Jun 2001 12:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbRFUQgh>; Thu, 21 Jun 2001 12:36:37 -0400
Received: from smtp3.libero.it ([193.70.192.53]:62144 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S265024AbRFUQgb>;
	Thu, 21 Jun 2001 12:36:31 -0400
Message-ID: <3B322224.91E17820@alsa-project.org>
Date: Thu, 21 Jun 2001 18:34:44 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: D.A.Fedorov@inp.nsk.su
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <Pine.SGI.4.10.10106212130280.3193032-100000@Sky.inp.nsk.su>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dmitry A. Fedorov" wrote:
> 
> On Thu, 21 Jun 2001, Oliver Neukum wrote:
> 
> > > Lastly an IRQ kernel module can disable_irq() from interrupt handler
> > > and enable it again only on explicit acknowledge from user.
> >
> > Unless you need that interrupt to be enabled to deliver the signal or let
> 
> Need not. Signal and other event delivery mechanisms has nothing
> common with disable/enable_irq().
> 
> > userspace reenable the interrupt.
> 
> "user acknowledge" is mean that.
> 
> > In addition, how do you handle shared interrupts ?
> 
> It is impossible, see my another message.

I don't see why you think it's impossible, the only thing you need is
that your kernel module know how to discriminate the interrupt source.

You can do this also with a irq.o module and other tiny modules that
register their irq source detection code.

Then you have /dev/irqX with the following API:

- ioctl(fd, IRQ_SUBSCRIBE, source_id);
- ioctl(fd, IRQ_ACK, source_id);
- poll
- async notification

Interrupts received between notification and acknowledge are queued
(i.e. counted). An alternative to queuing (user selectable) is to block
interrupt generation at hardware level in kernel space immediately
before notification.

I'm missing something?

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

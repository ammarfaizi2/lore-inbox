Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbRFUU5W>; Thu, 21 Jun 2001 16:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265223AbRFUU5M>; Thu, 21 Jun 2001 16:57:12 -0400
Received: from smtp3.libero.it ([193.70.192.53]:41190 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S265222AbRFUU5B>;
	Thu, 21 Jun 2001 16:57:01 -0400
Message-ID: <3B325F05.8D2F492A@alsa-project.org>
Date: Thu, 21 Jun 2001 22:54:29 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, D.A.Fedorov@inp.nsk.su,
        Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <Pine.LNX.3.95.1010621161215.4263A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> It just broke. The handler returned before the cause of the interrupt
> was handled. Think LEVEL interrupts. The same interrupt will again
> be entered, looping over and over again, until the tiny bit if CPU
> resource available for the few instants the handler was not in the
> ISR, was enough for the user-mode signal-handler to shut the
> damn thing off, pull the plug, and figure this will never work.

Sorry, I've missed an action writing the previous message (now marked
with a +)

Kernel space:
- irq 9 arrives from our device
- interrupts are disabled
- our kernel space micro handler is invoked
- interrupt source is checked
+ interrupt is acknowledged to our device
- if no notification is pending a signal is notificated for user space
(or a process is marked runnable)
- optionally our device interrupt generation is disabled
- handler returns
- interrupts are enabled

> >
> > User space:
> > - signal arrive (or process is restarted)
> > - action is done
> > - notification is acknowledged (using an ioctl)
> >
> 
> Way too late see above.

Don't equivocate me: this not the IRQ acknowledge, it's the acknowledge
of the user space notification.

Also note that this mechanism is not an attempt to demonstrate that to
move interrupt handlers to user space is a good thing. I wanted only to
show a way to permit to have *pseudo* interrupt handlers in user space
also having shared IRQ.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

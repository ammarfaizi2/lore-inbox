Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265178AbRFUUBL>; Thu, 21 Jun 2001 16:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbRFUUBB>; Thu, 21 Jun 2001 16:01:01 -0400
Received: from smtp2.libero.it ([193.70.192.52]:48070 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S265178AbRFUUAt>;
	Thu, 21 Jun 2001 16:00:49 -0400
Message-ID: <3B325206.3EB44DDD@alsa-project.org>
Date: Thu, 21 Jun 2001 21:59:02 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: D.A.Fedorov@inp.nsk.su, Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <E15D8Ec-0001lL-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > (i.e. counted). An alternative to queuing (user selectable) is to block
> > interrupt generation at hardware level in kernel space immediately
> > before notification.
> >
> > I'm missing something?
> 
> IRQ 9 shared between user space app and disk. IRQ arrives is disabled and
> reported, app wakes up, app wants to page in code, IRQ is disabled, box dies
> 
> You have to handle that in kernel space, at least enough to handle the
> irq event, ack it and queue the data

I try to be more clear:

Kernel space:
- irq 9 arrives from our device
- interrupts are disabled
- our kernel space micro handler is invoked
- interrupt source is checked
- if no notification is pending a signal is notificated for user space
(or a process is marked runnable)
- optionally our device interrupt generation is disabled
- handler returns
- interrupts are enabled

User space:
- signal arrive (or process is restarted)
- action is done
- notification is acknowledged (using an ioctl)

Kernel space:
- if we have other notifications to do, do one
- optionally our device interrupt generation is reenabled

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

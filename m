Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277552AbRJETRb>; Fri, 5 Oct 2001 15:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRJETRZ>; Fri, 5 Oct 2001 15:17:25 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:19723 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277552AbRJETRP>;
	Fri, 5 Oct 2001 15:17:15 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110051917.XAA23007@ms2.inr.ac.ru>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: adilger@turbolabs.com (Andreas Dilger)
Date: Fri, 5 Oct 2001 23:17:22 +0400 (MSK DST)
Cc: Robert.Olsson@data.slu.se, mingo@elte.hu, hadi@cyberus.ca,
        linux-kernel@vger.kernel.org, bcrl@redhat.com, netdev@oss.sgi.com,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20011005124824.F315@turbolinux.com> from "Andreas Dilger" at Oct 5, 1 12:48:24 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> One question which I have is why would you ever want to continue polling
> if there is no work to be done?  Is it a tradeoff between the amount of
> time to handle an IRQ vs. the time to do a poll?

Yes. IRQ even taken alone eat non-trivial amount of resources.

Actually, I remember Jamal worked with machine, which had
no io-apic and only irq ack/mask/unmask eated >15% of cpu there. :-)

>						  An assumption that if
> there was previous network traffic there is likely to be more the next
> time the interface is checked (assuming you have other work to do between
> the time you last polled the device and the next poll)?

Exactly.

Note also that the testing of "goto not_done" was made in pure environment:
dedicated router. Continuous polling is an evident advantage in this situation,
only power is eaten. I would not enable this on a notebook. :-)


> Is enabling/disabling of the RX interrupts on the network card an issue
> in the sense of "you need to wait X us after writing to this register
> for it to take effect" or other issue which makes it preferrable to have
> some "hysteresis" between changing state from IRQ-driven to polling?

"some hysteresis" is right word. This loop is an experiment with still
unknown result yet. Originally, Jamal proposed to spin several times.
I killed this. Robert proposed to check inifinite loop yet. (Note,
jiffies check is just a way to get rid of completely idle devices,
one jiffie is enough lonf time to be considered infinite).

Alexey

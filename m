Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272068AbRIDSYL>; Tue, 4 Sep 2001 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272065AbRIDSYB>; Tue, 4 Sep 2001 14:24:01 -0400
Received: from maild.telia.com ([194.22.190.101]:2794 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S272068AbRIDSXt>;
	Tue, 4 Sep 2001 14:23:49 -0400
Message-Id: <200109041823.f84INqE13918@maild.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
        Fred <fred@arkansaswebs.com>
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
Date: Tue, 4 Sep 2001 20:19:17 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu> <01090410264000.14864@bits.linuxball> <3B950034.17909E5D@nortelnetworks.com>
In-Reply-To: <3B950034.17909E5D@nortelnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday den 4 September 2001 18:24, Christopher Friesen wrote:
> Fred wrote:
> > I'm  curious, Alan, Why? I'm a hardware developer, and I would have
> > assumed that linux would have been ideal for real time / embedded
> > projects? (routers / controllers / etc.) Is there, for instance, a reason
> > to suspect that linux would not be able to respond to interrupts at say
> > 8Khz?
> > of course I know nothing of rtlinux so I'll read.
>
> I'm involved in a project where we are using linux in an embedded
> application. We've got a gig of ram, no hard drives, no video, and the only
> I/O is serial, ethernet and fiberchannel.
>
> We have a realtime process that tries to run every 50ms.  We're seeing
> actual worst-case scheduling latencies upwards of 300-400ms.
>
> So while interrupts can be handled pretty quickly, you'll want to make sure
> that your buffers are big enough that your userspace app only needs to run
> every half second or so.
>
> You may be better off with rtlinux if you need better response. (Or if
> you're on x86 hardware you could look at the low-latency patches.)

1) Why shouldn't the low-latency patches work for another architecture?
Andrew Morton might be interested to fix other architectures too.
(but most patches are not in architecture specific code)

2) Montavistas reschedulable kernel is a very interesting approach, newly
released an update by Robert Love
  http://kpreempt.sourceforge.net/
  http://tech9.net/rml/linux/patch-rml-2.4.10-pre2-preempt-kernel-1
(there are still some spikes, but the floor is smooth)

But note you with both approaches you want to run the latency critical process
with a higher priority, and probably with the memory locked down.

See example code (latencytest) at:
 http://www.gardena.net/benno/linux/audio/
(but there is no need to run at the maximum possible priority since your
 process will be alone anyway...)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

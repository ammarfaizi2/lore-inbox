Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVCIOcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVCIOcC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVCIOcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:32:02 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:35978 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261634AbVCIObu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:31:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=e5R75eo6JaJTWV5TDRy2H02iC40F8HBHvx5JCo0BeOA4gBlHvxJ8iEki8dvK+cJG7oYB/E/8J704IyC3DJsEMWAHzW4MQFTnITZ2nvt5m94HaqVMD7jtJPG9obxqVS0GZaIuwlK6V+d+FfcOswqMvmAAmgII/IucoXQJE5GnWaY=
Message-ID: <875fe4a505030906315ef7a16b@mail.gmail.com>
Date: Wed, 9 Mar 2005 14:31:50 +0000
From: Francesco Oppedisano <francesco.oppedisano@gmail.com>
Reply-To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: about interrupt latency
In-Reply-To: <Pine.LNX.4.61.0503081345080.12268@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <875fe4a50503081039328ffede@mail.gmail.com>
	 <Pine.LNX.4.61.0503081345080.12268@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 14:03:21 -0500 (EST), linux-os 
> You can't measure interrupt latency that way even
> though you may get the "correct" answer!

Why do you think the technique is not valid?

> Make a simple module that uses IRQ7, the printer-port
> interrupt. Inside your ISR, you toggle one of the
> printer-port bits. Program the printer port to
> generate the interrupt when its control bit
> is triggered.
> 
> Now, connect a function generator to toggle the
> printer control bit. Also use this transition to
> trigger an oscilloscope while looking at its trace
> on one channel. Connect the other channel to the
> bit that's being toggled in your ISR.
> 
> Observe the time between the trigger-trace and
> the toggle-trace. That, minus the few nanoseconds
> necessary to execute your ISR code, is the
> interrupt latency when using that specific interrupt
> source. PCI/Bus devices have lower latencies.

I do not have such an instrumentation :-(

> 
> The CPU speed seems to have little to do with interrupt
> latency now that we have fast CPUs. The limiting action
> is the memory speed (front-side bus). You can seldom
> count on having your ISR code inside the cache, so it
> needs to be fetched. It also takes more cache-flushes
> to switch from user-mode to a kernel stack, set up
> new segments, etc. That's the reason why you must
> MEASURE the latency if it is important. Guessing that
> an interrupt occurred when a timer went to zero, then
> measuring the residual in that same ISR will give you
> the wrong answers, altough in this case, it's probably
> close.
> 
Sorry but i cannot understand this:
i'm trying to estimate interrupt latency (i need only the order of
magnitude) by measuring the interrupt latency of the timer interrupt.
So when the 8254 counter reaches zero it issues an interrupt so i'm
sure that the time when the interrupt has been issued was when the
counter was to zero. From that time the counter returns to a value of
19832 (or something else) and at that time the countdown restarts.
When i reach the ISR i read the counter and obtain the
latency...what's wrong in this simple strategy?
Probably  i'm guessing  that the latency experienced by a timer
interrupt is the same as e.g the latency experienced by a NIC
interrupt, but remember that i need only a coarse measure.

Nevertheless, the information about the ISR in cache is very
interesting, probably it's what i was looking for....thank u.

Francesco Oppedisano

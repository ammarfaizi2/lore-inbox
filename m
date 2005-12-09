Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVLIPBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVLIPBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLIPBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:01:43 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:21978 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932173AbVLIPBm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:01:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YdflkYpjg0obnFpu3fJJdG/e4ow4fvXhZdyFJTjmnf3HlmqNj3PA4Vd/H7jC1lEL5QoP8QhXo/pLm/j8jqC0mUVAlrxU9PAIL9PJGJ00qkjKgYmjhG6MdXdURGsG/2yM3/iOnBN1WZXuvpKRyEoeg92BuSREenfnYMK28bkvPdU=
Message-ID: <808c8e9d0512090701l1f065c23radaa8ff5d800da2a@mail.gmail.com>
Date: Fri, 9 Dec 2005 09:01:25 -0600
From: Ben Gardner <gardner.ben@gmail.com>
To: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH 1/3] i386: CS5535 chip support - cpu
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
In-Reply-To: <20051207194226.GA2617@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051207194226.GA2617@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,

Sorry it took so long for me to respond.

On 12/7/05, Jordan Crouse <jordan.crouse@amd.com> wrote:
> Greetings Ben -
>
> > - verifies the existence of the CS5535 by checking the DIVIL signature
> > - configures UART1 as a NS16550A
>
> I'm confused by all this.  Not so much your code, which is correct, but
> your reason for doing all of this in the first place.  On a somewhat sane
> BIOS, it should have already set up all your descriptors and GPIO pins
> long before the kernel booted.  Not that you should trust blindly the BIOS
> in all  things, but as long as this is handled for you, you might as well take
> advantage of it.

I think your phrase "somewhat sane BIOS" sums up the problem nicely.
I threw in the UART1 config because UART2 has problems. Paranoia.
I'm not sure that the UART1 config is needed, so I'm willing to scrap
it, or wrap it in a config option.

If you are interested in my experience with UART2, see the kernel
buzilla report #5677.

> Now, if your particular board has its own very good reasons for handling
> this, then thats fine, but I don't think this should be accepted as CS5535
> support, because it stands a fairly good chance of causing trouble over
> the larger set of Geode devices.   I'll certainly listen to arguments
> to the contrary, though.

I'm curious as to what trouble this could cause?

> > -  (optionally) enables UART2 and configures it as a NS16550A
>
> This is similar to code that has previously been submitted, and is attached
> below.  Please review and comment.

Your patch looks like it would also solve the UART2 problem.
What I still don't understand is why UART2 works fine in DOS and in
linux 2.6.13-rc6-mm1, but not in the current kernel - in short, why is
this needed?
My guess (not based on any data) is that a BIOS call (initiated by
Linux) uses the DDC, but doesn't restore the GPIO to its original
state. So, again, a BIOS problem.

Anyway, I recommend adding sanity checks on MSR_DIVIL_GLD_CAP and
MSR_LBAR_GPIO before writing to the IO port.  The code as-is may cause
problems on a non-cs5535 board.

> > - (optionally) enables the SMBus/I2C interface
>
> Is there any reason why you can't use the PCI devices instead?  Granted,
> the SMBUS and GPIO are part of a multi-function device  (which has a higher
> annoyance level),  but it still seems better then passing around the global
> variables that you read from the MSR.  Also, PCI has the advantage of being
> a much cleaner and well traveled path, which is always nice.

I agree that PCI would work much cleaner.
I plan to revisit the GPIO & SMB drivers and get them to use PCI, but
that may not happen for a while.

> Regards,
> Jordan

Thanks for your input.
Ben

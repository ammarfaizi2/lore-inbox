Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271535AbRHPI4R>; Thu, 16 Aug 2001 04:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271532AbRHPI4H>; Thu, 16 Aug 2001 04:56:07 -0400
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:23568 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271531AbRHPIzv>; Thu, 16 Aug 2001 04:55:51 -0400
Date: Thu, 16 Aug 2001 09:55:38 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <125898493.997907155@[169.254.45.213]>
Message-ID: <Pine.LNX.4.21.0108160938420.2107-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Alex Bligh - linux-kernel wrote:

> Some network drivers generate entropy on network interrupts, some
> don't. Apparently this inconsistent state is the way people want
> to keep it.

This is very bad I would think - if the main source of entropy data is the
keybaord & mouse, there are a lot of servers out there with no keyboard
and mouse plugged into them that must be really having problems getting
enough data.

I was originally using Cobalt's kernel, so I have my suspicions that they
may have kludged the random number generator into working better with
their hardware.

> If you want to add entropy on network interrupts, look for the line
> in your driver which does a request_irq, and | in SA_SAMPLE_RANDOM
> to the flags value.

I've just added that to the natsemi ethernet driver (used on the Cobalt
Qube 3's) and the eepro100 driver (used on the Cobalt Raq 3/4) and it
seems to have fixed the problem, thanks.  I can only assume that this is
what Cobalt did to their own kernels in the first place...

> I'd prefer a single /proc/ entry to turn entropy on from ALL network
> devices for precisely the reason you state (SCSI means no IDE
> entity either), even if its off by default for ALL network
> devices for paranoia reasons, but there seems to be some religious
> issue at play which means the state currently depends on which
> brand of network card you have.

Yes, this would be a very nice idea.

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...



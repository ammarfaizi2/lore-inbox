Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278113AbRJRUEW>; Thu, 18 Oct 2001 16:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278114AbRJRUEN>; Thu, 18 Oct 2001 16:04:13 -0400
Received: from marty.infinity.powertie.org ([63.105.29.14]:519 "HELO
	marty.infinity.powertie.org") by vger.kernel.org with SMTP
	id <S278113AbRJRUEE>; Thu, 18 Oct 2001 16:04:04 -0400
Date: Thu, 18 Oct 2001 12:49:01 -0700 (PDT)
From: Patrick Mochel <mochelp@infinity.powertie.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <p05100309b7f4cd5976f7@[10.128.7.49]>
Message-ID: <Pine.LNX.4.21.0110181237360.17191-100000@marty.infinity.powertie.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The "state of all the devices in the system". Presumably, while you 
> walk the tree the first time (to save state) interrupts are enabled, 
> and devices are active. Operations (including interrupts) on the 
> device can, presumably, change the state of the device after its 
> state has been saved.

Ya, I'm an idiot sometimes. I relized this just as I was leaving for
lunch. I almost turned around to come back and answer..

This is what I had in mind; If someone could give me a thumbs-up or
thumbs-down on whether or not this would work:

When the driver gets a save_state request, that is its notification that
it is going to sleep. It should then stop/finish all I/O requests. It
should then prevent itself from taking any more - by setting a flag or
whatever. Then, device save state. 

>From that point in, it should know not to take any requests, theoretically
preserving state. 

When it gets the restore_state() call, it should first restore device
state. Once it does that, it knows that it can take I/O requests again. 

That should work, right?

The only thing that that won't work for is the device to which we're
saving state, like the disk. At some point, though we have to accept that
the state that we saved was some checkpoint in the past, and it won't
reflect the state that changed in the process of writing the system state.

	-pat




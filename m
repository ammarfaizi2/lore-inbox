Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbTDAUur>; Tue, 1 Apr 2003 15:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbTDAUuq>; Tue, 1 Apr 2003 15:50:46 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:25521 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262856AbTDAUup>; Tue, 1 Apr 2003 15:50:45 -0500
Subject: Re: 2.5.66-mm2-1 freezes solid after init PCMCIA
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030401204645.B7936@flint.arm.linux.org.uk>
References: <1049196020.789.8.camel@teapot>
	 <20030401125328.B30470@flint.arm.linux.org.uk>
	 <1049202135.612.4.camel@teapot>
	 <20030401204645.B7936@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1049230897.637.9.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 01 Apr 2003 23:01:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 21:46, Russell King wrote:
> I was thinking that it could be due to the pci changes - that's one of
> the areas I've been working in recently which could have caused this.
> 
> However, I believe it is to do with the recent PCMCIA changes to use
> the device model, and deadlock within the device model itself.
> 
> What basically seems to be happening is this:
> 
> - the ds module is inserted
> - ds registers a driver model interface for pcmcia socket drivers,
>   which takes the global devclass_sem.
> - ds causes the pcmcia core to evaluate the status of the sockets, and
>   perform "card insertion" processing if cards are present.
> - this processing detects a cardbus card, and calls the cardbus code to
>   scan pci devices, and add them to the device tree.
> - each device gets passed to the device model's class layer, which tries
>   to take devclass_sem.  But wait!  We've locked it while initialising
>   the ds module -> deadlock.
> 
> I'm currently working on the card insertion/removal code which hopefully
> should fix this.  However, it's not going to be immediately available,
> so please be patient.

Ok, Russell, take your time... Meanwhile, I'll stick with 2.5.66-mm1 and
will try all upcoming patches to see if/when the deadlock is fixed.
Thanks :-)

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org


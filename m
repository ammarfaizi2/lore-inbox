Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278421AbRJMWIH>; Sat, 13 Oct 2001 18:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278426AbRJMWH5>; Sat, 13 Oct 2001 18:07:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45891 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S278421AbRJMWHq>; Sat, 13 Oct 2001 18:07:46 -0400
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Pavel Machek" <pavel@Elf.ucw.cz>, "Jeremy Elson" <jelson@circlemud.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
In-Reply-To: <20011002204836.B3026@bug.ucw.cz>
	<200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu>
	<20011005205136.A1272@elf.ucw.cz> <m1n132x4qg.fsf@frodo.biederman.org>
	<20011008122013.B38@toy.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2001 15:57:32 -0600
In-Reply-To: <20011008122013.B38@toy.ucw.cz>
Message-ID: <m1wv1zqk37.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pavel Machek" <pavel@suse.cz> writes:

> Hi!
> 
> > > Yep. And linmodem driver does signal processing, so it is big and
> > > ugly. And up till now, it had to be in kernel. With your patches, such
> > > drivers could be userspace (where they belong!). Of course, it would be 
> > > very good if your interface did not change...
> > 
> > I don't see how linmodem drivers apply.  At least not at the low-level
> > because you actually have to driver the hardware, respond to interrupts
> > etc.  On some of this I can see a driver split like there is for the video
> 
> You don't actually need interrupts -- you *know* when next sample arrives.
> And port io is completely fine with iopl() ;-).

But DMA? You are talking about what amounts to a sound card driver.
And since in the cases that burn cpu time you have to process raw
sound samples into modem data, you need to shift a fair amount of
data. inb and outb just don't have the bandwidth.  So you need a
kernel side component that drives the hardware to some extent.

Additionally you still don't need a FUSD driver for that case.  All
you need is to have is a ptty.  Because that is what modem drivers
are now.  And the ptty route has binary and source compatiblity
to multiple unix platforms.

Eric

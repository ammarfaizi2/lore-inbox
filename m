Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290421AbSA3SdW>; Wed, 30 Jan 2002 13:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290333AbSA3ScB>; Wed, 30 Jan 2002 13:32:01 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:56844 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S290421AbSA3Sbj>; Wed, 30 Jan 2002 13:31:39 -0500
Date: Wed, 30 Jan 2002 19:31:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pozsar Balazs <pozsy@sch.bme.hu>,
        Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.2-dj7
Message-ID: <20020130193136.B2487@suse.cz>
In-Reply-To: <E16Vie4-0005gE-00@the-village.bc.nu> <Pine.LNX.4.10.10201301018200.7609-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201301018200.7609-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jan 30, 2002 at 10:22:02AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 10:22:02AM -0800, James Simmons wrote:

> > >    In dmi_scan.c there is a hook to deal with the PS/2 mouse on Dell
> > > Latitude C600. Can someone with this machine test the new input drivers on
> > > it. I like to see if we need some kind of fix for this device.
> > 
> > You I suspect will. When the machine resumes it likes to re-enable the mouse
> > pad irrespective of whether it is being used - so you get an IRQ12. Even
> > more fun if you ignore that IRQ you dont get keyboard events because the
> > microcontroller (or SMM code impersonating it - who knows these days) is
> > waiting for the ps/2 event to be handled first.
> 
> Oh man is that brain dead. 

The i8042 has a single byte output buffer shared by both the keyboard
and a mouse. If it's full, no more data is accepted from the keyboard or
mouse. Hence the problem above.

> > The alternative (possibly cleaner) fix on those machines would be to turn
> > the PS/2 port on always and process/discard output if its not wanted by
> > the user
> 
> This could be easily arranged with the new input drivers with it modular
> design. Since for the ix86 platform most people will want PS/2 input
> support to be built in. The only expection are the USB only users. I guess
> with the Dell Latitude C600 we will have to force i8042.c to be built in. 
> Vojtech what do you think about this solution?

I don't think we need to have it built in. If we need keyboard support
(which is likely), we'll have it, and if we don't need keyboard, then
we can safely ignore the IRQ12 as well.

And i8042.c, once power management is implemented in it, will reset the
keyboard controller and flush its buffers upon resume from sleep anyway.
(A problem may arise if the machine doesn't tell us about sleep/wake and
handles it all in SMM ...)

-- 
Vojtech Pavlik
SuSE Labs

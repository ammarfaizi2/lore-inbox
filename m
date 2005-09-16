Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbVIPNZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbVIPNZi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbVIPNZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 09:25:38 -0400
Received: from host27-37.discord.birch.net ([65.16.27.37]:43865 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1161093AbVIPNZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 09:25:38 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Vojtech Pavlik'" <vojtech@suse.cz>, "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       "'Dmitry Torokhov'" <dtor_core@ameritech.net>
Subject: RE: Machine does not find AT keyboard with 2.6.13.1
Date: Fri, 16 Sep 2005 08:30:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcW6s6M11MIKtYLKRUCKXCpO/IysFAADsMoA
In-Reply-To: <20050916114534.GB1278@ucw.cz>
Message-ID: <EXCHG2003mpcQABZTW500000858@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 16 Sep 2005 13:21:53.0116 (UTC) FILETIME=[9A5CE1C0:01C5BAC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

Adding usb-handoff fixed the problem, the keyboard/mouse is found
and works correctly.

I never would have guessed that a usb option would fix a ps2 issue.

                       Thanks
                       Roger 

> -----Original Message-----
> From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
> Sent: Friday, September 16, 2005 6:46 AM
> To: Andrew Morton
> Cc: Roger Heflin; linux-kernel@vger.kernel.org; Dmitry Torokhov
> Subject: Re: Machine does not find AT keyboard with 2.6.13.1
> 
> On Fri, Sep 16, 2005 at 02:47:10AM -0700, Andrew Morton wrote:
> > "Roger Heflin" <rheflin@atipa.com> wrote:
> > >
> > > I have an older machine that fails to find the AT 
> keyboard.   The machine is
> > >  based
> > >  on an Intel 7501 chipset.
> > > 
> > >  Under the default fedora core 4 kernel, it found the 
> keyboard and 
> > > that  keyboard  worked in UP mode, in SMP mode the 
> machine crashed, 
> > > but that is a different  issue.
> > > 
> > >  Under 2.6.13.1 the machine boots under SMP and does not crash, 
> > > dmesg does  not report  the keyboard being found, and the 
> keyboard 
> > > fails to work.  The .config file  does have
> > >  CONFIG_KEYBOARD_ATKBD set to Y.   The keyboard was being 
> found was seen on
> > >  the default
> > >  fedora core 4 kernel.   There are no extra options on 
> the boot cmdline.
> > > 
> > >  The important messages seem to be:
> > > 
> > >  Fedora Core 4 default UP kernel boot:
> > >  Sep 15 19:55:12 node001 kernel: serio: i8042 AUX port at 
> 0x60,0x64 
> > > irq 12  Sep 15 19:55:12 node001 kernel: serio: i8042 KBD port at 
> > > 0x60,0x64 irq 1  Sep 15 19:55:12 node001 kernel: input: AT 
> > > Translated Set 2 keyboard on  isa0060/serio0
> > > 
> > >  New boot (2.6.13.1 smp boot)
> > >  Sep 15 21:12:35 node001 kernel: i8042.c: Can't read CTR while 
> > > initializing  i8042.
> 
> "usb-handoff" on the kernel command line should solve this. I 
> thought we already had that as a default, or was the patch to 
> make it so dropped?
> 
> > >  The i8042 is of course missing out of /proc/interrupts 
> on the new boot.
> > 
> > That I8042_CMD_CTL_WCTR write-and-test seems to be new.  
> Can you try 
> > taking it out?
> 
> It's not a test, it's enabling the port interrupt. It won't 
> work without it at all.
> 
> > --- devel/drivers/input/serio/i8042.c~a	2005-09-16 
> 02:45:02.000000000 -0700
> > +++ devel-akpm/drivers/input/serio/i8042.c	2005-09-16 
> 02:46:51.000000000 -0700
> > @@ -305,11 +305,6 @@ static int i8042_activate_port(struct i8
> >  
> >  	i8042_ctr |= port->irqen;
> >  
> > -	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
> > -		i8042_ctr &= ~port->irqen;
> > -		return -1;
> > -	}
> > -
> >  	return 0;
> >  }
> >  
> > _
> > 
> > 
> 
> --
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277599AbRJNUwN>; Sun, 14 Oct 2001 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277608AbRJNUwD>; Sun, 14 Oct 2001 16:52:03 -0400
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:44422 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277599AbRJNUvu>; Sun, 14 Oct 2001 16:51:50 -0400
Date: Sun, 14 Oct 2001 16:49:13 -0400
From: Willem Riede <wriede@home.com>
To: German Gomez Garcia <german@piraos.com>
Cc: Dan Hollis <goemon@anime.net>,
        Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the 760MP
Message-ID: <20011014164913.A1428@linnie.riede.org>
In-Reply-To: <20011013102128.A1414@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011013102128.A1414@linnie.riede.org>; from wriede@home.com on Sat, Oct 13, 2001 at 10:21:28 -0400
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not having much luck with this :-(

I also have a Tyan Tiger MP, and have built a 2.4.10-ac12 based kernel
for it. Actually, I modified the Rawhide kernel SRPM to use linux-2.4.10
and the ac12 patch, as I run ext3 and software raid installed by RedHat's
Roswell beta, and I need to stay compatible with that; then made and
installed the athlon-smp RPM. 

It contains 2.6.1 for i2c, and I generated the patch for lm_sensors
2.6.1 to replace the older patch for lm_sensors in the SRPM.

The i2c-amd756 module hangs my kernel too, but you seem to have it
work without it? I don't get anything detected without i2c-amd756. 
This is what the log messages say (but I have to reboot to read them):

Oct 14 16:17:16 linnie kernel: i2c-amd756.o version 2.6.1 (20010830)
Oct 14 16:17:16 linnie kernel: i2c-dev.o: Registered 'SMBus AMD7X6 adapter
at 80e0' as minor 1
Oct 14 16:17:16 linnie kernel: i2c-core.o: client [W83782D chip] registered
to adapter [SMBus AMD7X6 adapter at 80e0](pos. 0).
Oct 14 16:17:16 linnie kernel: i2c-core.o: client [W83782D subclient]
registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 1).
Oct 14 16:17:16 linnie kernel: i2c-core.o: client [W83782D subclient]
registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 2).

Or is it this module (i2c-amd756) that you say must be included in the 
kernel to make 'it' work (English is so ambiguous :-))?

One more question if you don't mind: do you (still) have to first
read the sensors in the BIOS before booting? If I do that, for some
reason, I don't get my grub boot screen after exiting setup, instead
the board tries to boot off the lan; I ctrl-atl-del out of that, and 
then things are back to normal, but that soft reset probably undid
whatever reading the sensors in the bios changed :-(
Any other settings in the bios that matter?

Thanks, Willem Riede.

On 2001.10.09 18:20 German Gomez Garcia wrote:
> On Tue, 9 Oct 2001, Dan Hollis wrote:
> 
> > On Tue, 9 Oct 2001, German Gomez Garcia wrote:
> > > On Tue, 9 Oct 2001, Dan Hollis wrote:
> > > > On Tue, 9 Oct 2001, German Gomez Garcia wrote:
> > > > > it appears in the /proc/cmdline that message stills apears.
> > > > > Also I'm unable to get correct readings with lm_sensors (CVS),
> I've been
> > > > > enable to detect the w83781d chip using the i2c-amd756 SMbus but
> half of
> > > > > the times the kernel hangs up when loading this module.
> > > > 1) You need to enable ACPI in bios for sensors to work.
> > > 	What about the kernel? must I enable it there too?
> >
> > No. You don't need it in kernel.
> 
> 	Well, I must include it in the kernel to make it work, if I don't
> it detects a w83627hf instead of the w83782d, and it is unable to set it
> up on the bus:
> 
> i2c-proc.o version 2.6.1 (20010825)
> w83781d.o version 2.6.1 (20010830)
> i2c-core.o: driver W83781D sensor driver registered.
> i2c-core.o: client [W83627HF chip] registered to adapter [SMBus AMD7X6
> adapter at 80e0](pos. 0).
> i2c-core.o: client [W83627HF subclient] registered to adapter [SMBus
> AMD7X6 adapter at 80e0](pos. 1).
> i2c-core.o: client [W83627HF subclient] registered to adapter [SMBus
> AMD7X6 adapter at 80e0](pos. 2).
> i2c-core.o: client [W83782D chip] registered to adapter [SMBus AMD7X6
> adapter at 80e0](pos. 3).
> w83781d.o: Subclient 0 registration at address 0x49 failed.
> 
> 	then I get incorrect readings for the every sensors 1 goes up to
> 77º, 2 goes down to 12º, and 3 goes really down to 0º
> 
> 	If I include it in the kernel I get the following:
> 
> i2c-proc.o version 2.6.1 (20010825)
> w83781d.o version 2.6.1 (20010830)
> i2c-core.o: driver W83781D sensor driver registered.
> i2c-core.o: client [W83782D chip] registered to adapter [SMBus AMD7X6
> adapter at 80e0](pos. 0).
> i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> AMD7X6 adapter at 80e0](pos. 1).
> i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> AMD7X6 adapter at 80e0](pos. 2).
> 
> 	And after changing the type of the sensor to 2 (3904 transistor)
> it works perfectly, no temp offset, at least it reports the same than the
> BIOS (well I cannot be sure of that, but it doesn't differ more than one
> or two degrees).
> 
> 	Yeaahh!! that's outstanding online support, anybody still think
> that paid support is better than friendly penguins? :-D
> 	I'll start burn-testing this box now that I have some way to
> check temperature.
> 
> 	Regards and great thanks!
> 
> 	- german
> 
> -------------------------------------------------------------------------
> German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
> <german@piraos.com>          | to receive my GnuPG public key.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

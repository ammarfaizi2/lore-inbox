Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286665AbSABD3V>; Tue, 1 Jan 2002 22:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286670AbSABD3L>; Tue, 1 Jan 2002 22:29:11 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:55193
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S286665AbSABD2x>; Tue, 1 Jan 2002 22:28:53 -0500
Date: Tue, 1 Jan 2002 22:35:11 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 with es1370 pci
Message-ID: <20020101223511.A32329@animx.eu.org>
In-Reply-To: <20011231065544.A28966@animx.eu.org> <3C3065CE.1070608@wanadoo.fr> <20011231122440.B29342@animx.eu.org> <3C316C47.4080406@wanadoo.fr> <20020101104611.A30843@animx.eu.org> <3C3205AF.1080409@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3C3205AF.1080409@wanadoo.fr>; from Pierre Rousselet on Tue, Jan 01, 2002 at 07:53:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Nope, they don't work well IMO and since this card has 2 DSPs
> 
> 
> I assume one dsp is for es1370 and one is for the sb-16

Nope.  /dev/dsp and /dev/dsp1 are both on the es1370.  /dev/dsp2 is the
sb-16

> > I know,  I only pasted the what was for the sound card, it is working
> > properly.  mpg123 -a /dev/dsp2 works w/o any problem what so ever.
> 
> 
> Yes, you can use one sound card or the other. You may hear a difference.
> 
> > here's mpg123 -4:
> 
> <snip>
> > open("/sound/mp3/Aerosmith/Ain\'t_That_A_Bitch.mp3", O_RDONLY) = 3
> <snip>

It read about 128 bytes form this file.  I originally thought it didn't
read anything

> > open("/dev/dsp", O_WRONLY)              = 4
> > ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x806ae1c) = 0
> > ioctl(4, SNDCTL_DSP_RESET, 0)           = 0
> > ioctl(4, SOUND_PCM_READ_BITS, 0xbffff8a0) = 0
> > ioctl(4, SNDCTL_DSP_STEREO, 0xbffff89c) = 0
> > ioctl(4, SOUND_PCM_READ_RATE, 0xbffff898) = 0
> > write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384) = 16384
> > write(4, "\374\377\3\0\373\377\4\0\367\377\1\0\373\377\7\0\377\377"..., 16384) = 16384
> > write(4, "\344\377\333\377\5\0\316\377\362\377\234\377\f\0\212\377"..., 16384) = 16384
> > write(4, "P\0\202\0\367\377\263\0\353\377\274\0\274\377\353\0\235"..., 16384) = 16384
> > write(4, "\23\377S\0I\377U\0\200\377\215\0Z\377\222\377\330\377\16"..., 16384) = 16384
> > write(4, "@\377\376\375\344\376\355\377\263\3769\0%\377Y\376\255"..., 16384) = 16384
> > write(4, "\0\0\274\1:\377\365\1\17\0\301\1\0\0\332\0\360\377%\377"..., 16384) = 16384
> > write(4, "\r\375_\372{\377\356\373W\374\230\370\'\1\220\0\26\371"..., 16384) = 16384
> > write(4, "k\5j\5\337\1E\370<\10\346\5{\377;\3776\4\374\4F\376\24"..., 16384
> >  <unfinished ...>
> 
> 
> The same as the previous one: write to dsp but never read even the 
> smallest sample of the sound file possibly by lack of interrupt.
> 
> 
> >            CPU0       CPU1       
> >   0:   68416693   68502478    IO-APIC-edge  timer
> >   1:     400959     396781    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   3:  184224466  184748725    IO-APIC-edge  serial
> >   4:     803073     799856    IO-APIC-edge  serial
> >   5:     666537     667971   IO-APIC-level  aic7xxx
> >   7:        126        106    IO-APIC-edge  soundblaster
> >  10:   10271518   10263624   IO-APIC-level  eth0
> >  11:     236351     237359   IO-APIC-level  aic7xxx
> >  15:    4438445    4431067   IO-APIC-level  es1370
> > NMI:          0          0 
> > LOC:  136921268  136921264 
> > ERR:          0
> > MIS:          2
> > 
> > After attempting to play an mp3
> > 
> >            CPU0       CPU1       
> >   0:   68420347   68505506    IO-APIC-edge  timer
> >   1:     401392     397000    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   3:  184242407  184763513    IO-APIC-edge  serial
> >   4:     803633     800393    IO-APIC-edge  serial
> >   5:     666566     668012   IO-APIC-level  aic7xxx
> >   7:        126        106    IO-APIC-edge  soundblaster
> >  10:   10271726   10263824   IO-APIC-level  eth0
> >  11:     236351     237359   IO-APIC-level  aic7xxx
> >  15:    4438445    4431067   IO-APIC-level  es1370
> > NMI:          0          0 
> > LOC:  136927950  136927946 
> > ERR:          0
> > MIS:          2
> 
> My es1370 is happy with IRQ 9 which is shared with usb-uhci. IRQ 15 is 
> for ide1 here.

I have all ide disabled in bios.  I had a nic on 14 and one on 15 w/o
problems.  but this was with 2.2.13 and I had no problems with that kernel.

alan cox suggested using noapic when booting.  I'll try that, but I'm going
to be disabling the usb since this system's usb hardware is junk.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

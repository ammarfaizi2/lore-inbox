Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278505AbRJVKtE>; Mon, 22 Oct 2001 06:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278504AbRJVKsz>; Mon, 22 Oct 2001 06:48:55 -0400
Received: from web11903.mail.yahoo.com ([216.136.172.187]:51980 "HELO
	web11903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278502AbRJVKsq>; Mon, 22 Oct 2001 06:48:46 -0400
Message-ID: <20011022104920.36145.qmail@web11903.mail.yahoo.com>
Date: Mon, 22 Oct 2001 03:49:20 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: Re: 2.4.12-ac5: i810_audio does not work
To: Andris Pavenis <pavenis@latnet.lv>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110221036.f9MAaDt03374@hal.astr.lu.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had same problem with KDE. I've just disabled aRts
soundserver.


--- Andris Pavenis <pavenis@latnet.lv> wrote:
> On Monday 22 October 2001 10:41, Alan Cox wrote:
> > > i810: Intel ICH 82801AA found at IO 0xe100 and
> 0xe000, IRQ 10
> > > i810_audio: Audio Controller supports 2
> channels.
> > > ac97_codec: AC97 Audio codec, id: 0x4144:0x5348
> (Analog Devices AD1881A)
> > > i810_audio: AC'97 codec 0 Unable to map surround
> DAC's (or DAC's not
> > > present), total channels = 2
> >
> > The messages seem ok. It found a 2 channel device
> with no surround support.
> > What part of the system then fails ?
> 
> Rechecked more carefully with original
> drivers/sound/i810_audio.c from 2.4.12-ac5.
> 
> Sound practically doesn't work under KDE-2.2.1. For
> example I'm getting only 
> some garbled sound for a very short time when I'm
> trying sound test in kcontrol. 
> Maybe these problems are due to non blocking output
> to /dev/sound/dsp 
> which artsd is using. Here is fragment from strace
> output for artsd
> 
> 13:32:21.290449 access("/dev/dsp", F_OK) = 0
> 13:32:21.290799 access("/dev/dsp", F_OK) = 0
> 13:32:21.290949 open("/dev/dsp",
> O_WRONLY|O_NONBLOCK) = 9
> 13:32:21.291551 ioctl(9, SNDCTL_DSP_GETCAPS,
> 0xbffff360) = 0
> 13:32:21.291638 ioctl(9, SNDCTL_DSP_SETFMT,
> 0xbffff35c) = 0
> 13:32:21.291686 ioctl(9, SNDCTL_DSP_STEREO,
> 0xbffff358) = 0
> 13:32:21.291728 ioctl(9, SNDCTL_DSP_SPEED,
> 0xbffff354) = 0
> 13:32:21.292276 ioctl(9, SNDCTL_DSP_SETFRAGMENT,
> 0xbffff350) = 0
> 13:32:21.292320 ioctl(9, SNDCTL_DSP_GETOSPACE,
> 0xbffff378) = 0
> 13:32:21.292518 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> 13:32:21.292629 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> 13:32:21.292715 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> 13:32:21.292801 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> 13:32:21.292887 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> 13:32:21.292973 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> 13:32:21.293058 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> 13:32:21.293144 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> 13:32:21.293230 write(9,
>
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 512) = 512
> .....
> 
> Sound seems to work mostly Ok under GNOME and also
> with Mozilla-0.95+RealPlayer
> 
> Andris
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com

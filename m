Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275527AbRJVKhE>; Mon, 22 Oct 2001 06:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278490AbRJVKgz>; Mon, 22 Oct 2001 06:36:55 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:63494 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S278489AbRJVKgg>;
	Mon, 22 Oct 2001 06:36:36 -0400
Message-Id: <200110221036.f9MAaDt03374@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.12-ac5: i810_audio does not work
Date: Mon, 22 Oct 2001 13:36:13 +0300
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15vZiZ-00010n-00@the-village.bc.nu>
In-Reply-To: <E15vZiZ-00010n-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 October 2001 10:41, Alan Cox wrote:
> > i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, IRQ 10
> > i810_audio: Audio Controller supports 2 channels.
> > ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
> > i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not
> > present), total channels = 2
>
> The messages seem ok. It found a 2 channel device with no surround support.
> What part of the system then fails ?

Rechecked more carefully with original drivers/sound/i810_audio.c from 2.4.12-ac5.

Sound practically doesn't work under KDE-2.2.1. For example I'm getting only 
some garbled sound for a very short time when I'm trying sound test in kcontrol. 
Maybe these problems are due to non blocking output to /dev/sound/dsp 
which artsd is using. Here is fragment from strace output for artsd

13:32:21.290449 access("/dev/dsp", F_OK) = 0
13:32:21.290799 access("/dev/dsp", F_OK) = 0
13:32:21.290949 open("/dev/dsp", O_WRONLY|O_NONBLOCK) = 9
13:32:21.291551 ioctl(9, SNDCTL_DSP_GETCAPS, 0xbffff360) = 0
13:32:21.291638 ioctl(9, SNDCTL_DSP_SETFMT, 0xbffff35c) = 0
13:32:21.291686 ioctl(9, SNDCTL_DSP_STEREO, 0xbffff358) = 0
13:32:21.291728 ioctl(9, SNDCTL_DSP_SPEED, 0xbffff354) = 0
13:32:21.292276 ioctl(9, SNDCTL_DSP_SETFRAGMENT, 0xbffff350) = 0
13:32:21.292320 ioctl(9, SNDCTL_DSP_GETOSPACE, 0xbffff378) = 0
13:32:21.292518 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
13:32:21.292629 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
13:32:21.292715 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
13:32:21.292801 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
13:32:21.292887 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
13:32:21.292973 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
13:32:21.293058 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
13:32:21.293144 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
13:32:21.293230 write(9, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
.....

Sound seems to work mostly Ok under GNOME and also with Mozilla-0.95+RealPlayer

Andris

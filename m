Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263931AbRFRMYB>; Mon, 18 Jun 2001 08:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263932AbRFRMXv>; Mon, 18 Jun 2001 08:23:51 -0400
Received: from mta23-acc.tin.it ([212.216.176.76]:48777 "EHLO fep23-svc.tin.it")
	by vger.kernel.org with ESMTP id <S263931AbRFRMXk>;
	Mon, 18 Jun 2001 08:23:40 -0400
From: "Delio Brignoli" <nordkyn@tin.it>
Date: Mon, 18 Jun 2001 14:17:15 +0200
To: linux-kernel@vger.kernel.org
Subject: i810 audio problem
Message-ID: <20010618141715.A534@argo.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switching from 2.4.2 to 2.4.5 breaks i810_audio on my intel MX440 based notebook:

After some (in fact a few) seconds of playback it gets stuck until the app closes and reopens /dev/dsp. (I do NOT use esd)

I tried 2.4.4 and 2.4.5 (and the ac patches on both) but it does't work anyway.

Jun 18 13:45:50 argo kernel: Intel 810 + AC97 Audio, version 0.03, 13:40:09 Jun 18 2001
Jun 18 13:45:50 argo kernel: PCI: Setting latency timer of device 00:00.1 to 64
Jun 18 13:45:50 argo kernel: i810: Intel 440MX found at IO 0x1500 and 0x1600, IRQ 5
Jun 18 13:45:50 argo kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5934 (Cirrus Logic CS4299 rev D)
Jun 18 13:45:50 argo kernel: i810_audio: called i810_set_dac_rate : rate = 48000/48000
Jun 18 13:45:50 argo kernel: i810_audio: allocated 65536 (order = 4) bytes at cb660000
Jun 18 13:45:50 argo kernel: i810_audio: prog_dmabuf, sample rate = 48000, format = 3,
Jun 18 13:45:50 argo kernel: ^Inumfrag = 32, fragsize = 2048 dmasize = 65536
Jun 18 13:45:50 argo kernel: i810_audio: 17768 bytes in 50 milliseconds
Jun 18 13:45:50 argo kernel: i810_audio: setting clocking to 25934
Jun 18 13:58:06 argo kernel: i810_audio: called i810_set_dac_rate : rate = 14806/8000

[snip]

Here starts the playback

Jun 18 13:58:06 argo kernel: i810_audio: i810_ioctl, arg=0x0, cmd=SNDCTL_DSP_RESET
Jun 18 13:58:06 argo kernel: i810_audio: i810_ioctl, arg=0x20000c, cmd=SNDCTL_DSP_SETFRAGMENT 0x10000, 4096, 16
Jun 18 13:58:06 argo kernel: i810_audio: i810_ioctl, arg=0x10, cmd=SNDCTL_DSP_SETFMT
Jun 18 13:58:06 argo kernel: i810_audio: i810_ioctl, arg=0x10, cmd=SNDCTL_DSP_SETFMT
Jun 18 13:58:06 argo kernel: i810_audio: i810_ioctl, arg=0x1, cmd=SNDCTL_DSP_STEREO
Jun 18 13:58:06 argo kernel: i810_audio: i810_ioctl, arg=0xac44, cmd=SNDCTL_DSP_SPEED
Jun 18 13:58:06 argo kernel: i810_audio: called i810_set_dac_rate : rate = 40811/22050
Jun 18 13:58:06 argo kernel: i810_audio: i810_ioctl, arg=0x0, cmd=i810_audio: allocated 65536 (order = 4) bytes at c7880000
Jun 18 13:58:06 argo kernel: i810_audio: prog_dmabuf, sample rate = 40811, format = 3,
Jun 18 13:58:06 argo kernel: ^Inumfrag = 32, fragsize = 2048 dmasize = 65536
Jun 18 13:58:06 argo kernel: SNDCTL_DSP_GETBLKSIZE 4096
Jun 18 13:58:07 argo kernel: i810_audio: i810_write called, count = 3788
Jun 18 13:58:07 argo kernel: i810_audio: i810_ioctl, arg=0x0, cmd=SNDCTL_DSP_GETOSPACE 61748, 4096, 15, 16
Jun 18 13:58:07 argo kernel: i810_audio: i810_write called, count = 3788
Jun 18 13:58:07 argo kernel: i810_audio: i810_ioctl, arg=0xf, cmd=SNDCTL_DSP_GETOSPACE 60080, 4096, 14, 16
Jun 18 13:58:07 argo kernel: i810_audio: i810_write called, count = 3788
Jun 18 13:58:07 argo kernel: i810_audio: i810_ioctl, arg=0xe, cmd=SNDCTL_DSP_GETOSPACE 56340, 4096, 13, 16

[snip]

Jun 18 13:58:07 argo kernel: i810_audio: i810_write called, count = 3788
Jun 18 13:58:07 argo kernel: i810_audio: i810_ioctl, arg=0x1, cmd=SNDCTL_DSP_GETOSPACE 3732, 4096, 0, 16
Jun 18 13:58:07 argo kernel: i810_audio: i810_write called, count = 3788
Jun 18 13:58:07 argo kernel: i810_audio: i810_ioctl, arg=0x0, cmd=SNDCTL_DSP_GETOSPACE 4074, 4096, 0, 16
Jun 18 13:58:07 argo kernel: i810_audio: i810_write called, count = 3788
Jun 18 13:58:07 argo kernel: i810_audio: i810_ioctl, arg=0x0, cmd=SNDCTL_DSP_GETOSPACE 286, 4096, 0, 16
Jun 18 13:58:07 argo kernel: i810_audio: i810_write called, count = 3788
Jun 18 13:58:07 argo kernel: i810_audio: playback schedule timeout, dmasz 65536 fragsz 2048 count 65536 hwptr 4294842946 swptr 6722
Jun 18 13:58:38 argo last message repeated 77 times
Jun 18 13:59:39 argo last message repeated 152 times
Jun 18 13:59:40 argo last message repeated 4 times

It goes on until I kill the app, then it says:

Jun 18 13:59:42 argo kernel: i810_audio: drain_dac, dma timeout?

Any idea(s), suggestions ...

Thank you

--
Delio

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286991AbRL1TWm>; Fri, 28 Dec 2001 14:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286990AbRL1TWg>; Fri, 28 Dec 2001 14:22:36 -0500
Received: from maila.telia.com ([194.22.194.231]:31737 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S286989AbRL1TWT>;
	Fri, 28 Dec 2001 14:22:19 -0500
Date: Fri, 28 Dec 2001 20:27:00 +0100
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Sound stops while playing DVD with via82cxxx_audio driver
Message-ID: <20011228192700.GA7346@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

[Since Jeff isn't the maintainer of the VIA audio driver I'm sending
this to linux-kernel]

Hi folks,

As the subject says, the audio is silenced a few minutes into playing
any DVD on my computer, using the via82cxxx_audio driver. My sound chip
is:


00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 21)
	Subsystem: Sigmatel Inc: Unknown device 7600
	Flags: medium devsel, IRQ 9
	I/O ports at dc00 [size=256]
	I/O ports at e000 [size=4]
	I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2

It is 100% reproducable, and it usually happens around 4-6 minutes into
a DVD. After that has happened sounds in other programs will be silent
too. To get sound back I have to use a mixer app and just move the
master or pcm volume control one notch up and then back.

I have defined debugging in the VIA driver, and below is the output
written to /var/log/debug from the via driver when the sound silenced in
the movie. I have seen it happen once or twice while playing a mp3 too,
but with a DVD it's much easier to reproduce.

>From /var/log/debug:

Dec 28 19:40:35 sledgehammer kernel: via_dsp_write: ENTER, file=ce01c9a0, buffer=082cccf0, count=8192, ppos=0
Dec 28 19:40:35 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:35 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:35 sledgehammer kernel: via_chan_buffer_init: ENTER
Dec 28 19:40:35 sledgehammer kernel: via_chan_buffer_init: EXIT
Dec 28 19:40:35 sledgehammer kernel: via_dsp_do_write: Flushed block 6, sw_ptr now 7, n_frags now 1
Dec 28 19:40:35 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100048 00000568 009A0000 00001000
Dec 28 19:40:35 sledgehammer kernel: via_dsp_do_write: Flushed block 7, sw_ptr now 8, n_frags now 0
Dec 28 19:40:35 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100048 00000538 009A0000 00001000
Dec 28 19:40:35 sledgehammer kernel: via_dsp_write: EXIT, returning 8192
Dec 28 19:40:35 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:35 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100050, chan->hw_ptr=9
Dec 28 19:40:35 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
Dec 28 19:40:35 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:35 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 123420 bytes
Dec 28 19:40:35 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:35 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:35 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100058, chan->hw_ptr=10
Dec 28 19:40:35 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 2
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 119424 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETOSPACE
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl_space: EXIT, returning fragstotal=32, fragsize=4096, fragments=2, bytes=8192
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100060, chan->hw_ptr=11
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 3
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: ENTER, file=ce01c9a0, buffer=082cccf0, count=8192, ppos=0
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 8, sw_ptr now 9, n_frags now 2
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100060 00000E58 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 9, sw_ptr now 10, n_frags now 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100060 00000E28 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: EXIT, returning 8192
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100068, chan->hw_ptr=12
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 2
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 121732 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 120280 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETOSPACE
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl_space: EXIT, returning fragstotal=32, fragsize=4096, fragments=2, bytes=8192
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: ENTER, file=ce01c9a0, buffer=082cccf0, count=8192, ppos=0
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 10, sw_ptr now 11, n_frags now 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100068 00000350 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 11, sw_ptr now 12, n_frags now 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100068 00000320 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: EXIT, returning 8192
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100070, chan->hw_ptr=13
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100078, chan->hw_ptr=14
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 2
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 121920 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 120472 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETOSPACE
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl_space: EXIT, returning fragstotal=32, fragsize=4096, fragments=2, bytes=8192
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: ENTER, file=ce01c9a0, buffer=082cccf0, count=8192, ppos=0
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 12, sw_ptr now 13, n_frags now 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100078 00000268 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 13, sw_ptr now 14, n_frags now 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100078 0000023C 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: EXIT, returning 8192
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100080, chan->hw_ptr=15
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 122920 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100088, chan->hw_ptr=16
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 2
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 121440 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETOSPACE
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl_space: EXIT, returning fragstotal=32, fragsize=4096, fragments=2, bytes=8192
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: ENTER, file=ce01c9a0, buffer=082cccf0, count=8192, ppos=0
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 14, sw_ptr now 15, n_frags now 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100088 000003EC 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 15, sw_ptr now 16, n_frags now 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100088 000003B8 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: EXIT, returning 8192
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100090, chan->hw_ptr=17
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 123308 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD100098, chan->hw_ptr=18
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 2
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 121780 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETOSPACE
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl_space: EXIT, returning fragstotal=32, fragsize=4096, fragments=2, bytes=8192
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: ENTER, file=ce01c9a0, buffer=082cccf0, count=8192, ppos=0
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 16, sw_ptr now 17, n_frags now 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100098 00000958 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 17, sw_ptr now 18, n_frags now 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D100098 0000092C 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: EXIT, returning 8192
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD1000A0, chan->hw_ptr=19
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 123744 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD1000A8, chan->hw_ptr=20
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 2
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 122212 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETOSPACE
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl_space: EXIT, returning fragstotal=32, fragsize=4096, fragments=2, bytes=8192
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: ENTER, file=ce01c9a0, buffer=082cccf0, count=8192, ppos=0
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_set_buffering: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_init: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 18, sw_ptr now 19, n_frags now 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D1000A8 00000A18 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: Flushed block 19, sw_ptr now 20, n_frags now 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_do_write: regs==80 00 B7 0D1000A8 000009E8 009A0000 00001000
Dec 28 19:40:36 sledgehammer kernel: via_dsp_write: EXIT, returning 8192
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD1000B0, chan->hw_ptr=21
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 125032 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_interrupt: intr, status32 == 0x00001001
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xD1000B8, chan->hw_ptr=22
Dec 28 19:40:36 sledgehammer kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 2
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_GETODELAY
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: GETODELAY EXIT, val = 120956 bytes
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: DSP_RESET
Dec 28 19:40:36 sledgehammer kernel: via_chan_clear: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_free: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_ac97_wait_idle: ENTER/EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_free: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_clear: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_ioctl: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_release: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_dsp_drain_playback: ENTER, nonblock = 0
Dec 28 19:40:36 sledgehammer kernel: via_dsp_drain_playback: EXIT, returning 0
Dec 28 19:40:36 sledgehammer kernel: via_chan_free: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_chan_free: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_free: ENTER
Dec 28 19:40:36 sledgehammer kernel: via_ac97_wait_idle: ENTER/EXIT
Dec 28 19:40:36 sledgehammer kernel: via_chan_buffer_free: EXIT
Dec 28 19:40:36 sledgehammer kernel: via_dsp_release: EXIT, returning 0

Let me know if more data from the log is needed. I have attached some
additional system information with this mail.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.4.17"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=y
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=y
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
# CONFIG_FBCON_MFB is not set
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
CONFIG_FBCON_CFB8=y
# CONFIG_FBCON_CFB16 is not set
# CONFIG_FBCON_CFB24 is not set
# CONFIG_FBCON_CFB32 is not set
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
# CONFIG_FBCON_VGA_PLANES is not set
# CONFIG_FBCON_VGA is not set
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=m
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ver_linux

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux sledgehammer 2.4.17 #6 Fri Dec 28 17:02:50 CET 2001 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.11
e2fsprogs              1.25
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ide-cd cdrom via82cxxx_audio ac97_codec

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 44)
	Flags: bus master, medium devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e7ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 1b)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 0e) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 0e) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 20)
	Flags: medium devsel

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 21)
	Subsystem: Sigmatel Inc: Unknown device 7600
	Flags: medium devsel, IRQ 9
	I/O ports at dc00 [size=256]
	I/O ports at e000 [size=4]
	I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2

00:0d.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev 42)
	Subsystem: D-Link System Inc: Unknown device 1401
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at e800 [size=256]
	Memory at e9000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at e8000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
	Subsystem: CardExpert Technology: Unknown device 8888
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at e5000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0


--+QahgC5+KEYLbs62--

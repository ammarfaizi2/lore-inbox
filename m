Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRBZObF>; Mon, 26 Feb 2001 09:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130238AbRBZO3O>; Mon, 26 Feb 2001 09:29:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130227AbRBZO2l>;
	Mon, 26 Feb 2001 09:28:41 -0500
Date: Mon, 26 Feb 2001 15:04:37 +0100 (CET)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: <gc1007@fb07-calculator.math.uni-giessen.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        <linux-via@gtf.org>
Subject: Problems with via82cxxx_audio
Message-Id: <Pine.LNX.4.31.0102261456410.21121-100000@fb07-calculator.math.uni-giessen.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


high!

here is my problem:
  The sound is playing (much) too fast.
  sometimes using xmms1.2.4 locks up the whole machine (without any log messages,
  even a previously initiated shutdown +1 do not complete) .

Configuration:

Im using the 2.4.2 kernel with the via82cxxx_audio from 2.4.2 (but I also
tried the driver from 2.4.1, 2.4.0 and 2.4.0-test10).

I also tried to apply your rate-lock-patch to clean 2.4.1 and to
2.4.1-ac20, which has the same via82cxxx_audio.c as 2.4.2.
in both cases the patch rejected HUNKS 4 and 6 (4 is a comment anyway)
HUNK 6 I didn't find by hand also...

you can find some configuration/debug info below. mail me for further
details.

Thanks in advance

        Sergei

--------------------------------------------------------------------
         eMail:       Sergei.Haller@math.uni-giessen.de
      WWW-page:     http://www.hrz.uni-giessen.de/~gc1007/
--------------------------------------------------------------------
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain

--------------------------------------------------------------------


these are the commands I execute:
(on a 2.4.2 with via82cxxx_audio from 2.4.2
 with enabled VIA_DEBUG and VIA_PROC_FS)

$ modprobe via82cxxx_audio
$ cat alarm.wav >/dev/dsp
$ cat /proc/driver/via/0/ac97 >/tmp/ac97
$ cat /proc/driver/via/0/info >/tmp/info
$ modprobe -r via82cxxx_audio
$ ./via-audio-diag -aps
$ lspci -xv

/proc/driver/via/0/ac97:
Vendor name      : SigmaTel STAC9721/23
Vendor id        : 8384 7609
AC97 Version     : 2.0 or later
Capabilities     :
DAC resolutions  : -16-bit- -18-bit-
ADC resolutions  : -16-bit- -18-bit-
3D enhancement   : SigmaTel 3D Enhancement
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
MIC select       : MIC1
ADC/DAC loopback : off
Ext Capabilities : -slot/DAC mappings-
Front DAC rate   : 0

/proc/driver/via/0/info:
VIA 82Cxxx Audio driver 1.1.14a

Via 82Cxxx PCI registers:

40  Codec Ready: yes
    Codec Low-power: no
    Secondary Codec Ready: no

41  Interface Enable: enable
    De-Assert Reset: yes
    Force SYNC high: no
    Force SDO high: no
    Variable Sample Rate On-Demand Mode: enable
    SGD Read Channel PCM Data Out: enable
    FM Channel PCM Data Out: disable
    SB PCM Data Out: disable

42  Game port enabled: no
    SoundBlaster enabled: no
    FM enabled: no
    MIDI enabled: no

44  AC-Link Interface Access: yes
    Secondary Codec Support: no

these are the kernel-log-messages:

kernel: via_init_proc: ENTER
kernel: via_init_proc: EXIT, returning 0
kernel: via_init_one: ENTER
kernel: Via 686a audio driver 1.1.14a
kernel: PCI: Found IRQ 10 for device 00:07.5
kernel: PCI: The same IRQ used for device 00:0a.0
kernel: via_ac97_init: ENTER
kernel: via_ac97_reset: ENTER
kernel: via_ac97_reset: PCI config: 01 CC 40 1C 80 05
kernel: via_ac97_reset: regs==00 00 00 00000000 00000024 00AC0000 00000000
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x22a0080, retval=0x80
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_reset: EXIT, returning 0
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_wait_idle: ENTER/EXIT
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2006940, retval=0x6940
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x23c0000, retval=0x0
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x27c8384, retval=0x8384
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x27e7609, retval=0x7609
kernel: ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2006940, retval=0x6940
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2021f1f, retval=0x1f1f
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x22a0080, retval=0x80
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_init: EXIT, returning 0
kernel: via_dsp_init: ENTER
kernel: via_stop_everything: ENTER
kernel: via_stop_everything: EXIT
kernel: via_dsp_init: EXIT, returning 0
kernel: via_card_init_proc: ENTER
kernel: via_card_init_proc: EXIT, returning 0
kernel: via_interrupt_init: ENTER
kernel: via_interrupt_disable: ENTER
kernel: via_interrupt_disable: EXIT
kernel: via_interrupt_init: EXIT, returning 0
kernel: via_init_one: IRQ reg 0x3c==0x0a, irq==10
kernel: via82cxxx: board #1 at 0xAC00, IRQ 10
kernel: via_init_one: EXIT, returning 0
kernel: init_via82cxxx_audio: EXIT, returning 0
kernel: via_dsp_open: ENTER, minor=3, file->f_mode=0x2
kernel: via_dsp_open: dev_dsp = 3, minor = 3, assn = 0
kernel: via_dsp_open: file->f_mode == 0x2
kernel: via_chan_init: ENTER
kernel: via_chan_clear: ENTER
kernel: via_chan_buffer_free: ENTER
kernel: via_ac97_wait_idle: ENTER/EXIT
kernel: via_chan_buffer_free: EXIT
kernel: via_chan_clear: EXIT
kernel: via_chan_pcm_fmt: ENTER, pcm_fmt=0x30, reset=yes
kernel: via_chan_pcm_fmt: EXIT, pcm_fmt = 0x87, reg = 0x87
kernel: via_chan_init: EXIT
kernel: via_chan_pcm_fmt: ENTER, pcm_fmt=0x87, reset=no
kernel: via_chan_pcm_fmt: EXIT, pcm_fmt = 0x87, reg = 0x87
kernel: via_set_rate: ENTER, rate = 8000
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x226000f, retval=0xf
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x226020d, retval=0x20d
kernel: via_ac97_write_reg: ENTER
kernel: via_ac97_write_reg: EXIT
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x22c0000, retval=0x0
kernel: via_set_rate: EXIT, returning rate 0 Hz
kernel: via_dsp_open: EXIT, returning 0
kernel: via_dsp_write: ENTER, file=cbaef380, buffer=0804cea8, count=4096, ppos=0
kernel: via_chan_set_buffering: ENTER
kernel: via_chan_set_buffering:
kernel: via_chan_set_buffering: setting default values 1 25
kernel: via_chan_set_buffering: EXIT
kernel: via_chan_buffer_init: ENTER
kernel: via_chan_buffer_init: dmabuf_pg #0 (h=24b6000, v2p=24b6000, a=c24b6000)
kernel: via_chan_buffer_init: dmabuf #0 (32(h)=24b6000)
kernel: via_chan_buffer_init: dmabuf #1 (32(h)=24b6040)
kernel: via_chan_buffer_init: dmabuf #2 (32(h)=24b6080)
kernel: via_chan_buffer_init: dmabuf #3 (32(h)=24b60c0)
kernel: via_chan_buffer_init: dmabuf #4 (32(h)=24b6100)
kernel: via_chan_buffer_init: dmabuf #5 (32(h)=24b6140)
kernel: via_chan_buffer_init: dmabuf #6 (32(h)=24b6180)
kernel: via_chan_buffer_init: dmabuf #7 (32(h)=24b61c0)
kernel: via_chan_buffer_init: dmabuf #8 (32(h)=24b6200)
kernel: via_chan_buffer_init: dmabuf #9 (32(h)=24b6240)
kernel: via_chan_buffer_init: dmabuf #10 (32(h)=24b6280)
kernel: via_chan_buffer_init: dmabuf #11 (32(h)=24b62c0)
kernel: via_chan_buffer_init: dmabuf #12 (32(h)=24b6300)
kernel: via_chan_buffer_init: dmabuf #13 (32(h)=24b6340)
kernel: via_chan_buffer_init: dmabuf #14 (32(h)=24b6380)
kernel: via_chan_buffer_init: dmabuf #15 (32(h)=24b63c0)
kernel: via_chan_buffer_init: dmabuf #16 (32(h)=24b6400)
kernel: via_chan_buffer_init: dmabuf #17 (32(h)=24b6440)
kernel: via_chan_buffer_init: dmabuf #18 (32(h)=24b6480)
kernel: via_chan_buffer_init: dmabuf #19 (32(h)=24b64c0)
kernel: via_chan_buffer_init: dmabuf #20 (32(h)=24b6500)
kernel: via_chan_buffer_init: dmabuf #21 (32(h)=24b6540)
kernel: via_chan_buffer_init: dmabuf #22 (32(h)=24b6580)
kernel: via_chan_buffer_init: dmabuf #23 (32(h)=24b65c0)
kernel: via_chan_buffer_init: dmabuf #24 (32(h)=24b6600)
kernel: via_chan_buffer_init: dmabuf #25 (32(h)=24b6640)
kernel: via_chan_buffer_init: dmabuf #26 (32(h)=24b6680)
kernel: via_chan_buffer_init: dmabuf #27 (32(h)=24b66c0)
kernel: via_chan_buffer_init: dmabuf #28 (32(h)=24b6700)
kernel: via_chan_buffer_init: dmabuf #29 (32(h)=24b6740)
kernel: via_chan_buffer_init: dmabuf #30 (32(h)=24b6780)
kernel: via_chan_buffer_init: dmabuf #31 (32(h)=24b67c0)
kernel: via_chan_buffer_init: outl (0xCB35000, 0xAC04)
kernel: via_ac97_wait_idle: ENTER/EXIT
kernel: via_ac97_wait_idle: ENTER/EXIT
kernel: via_chan_buffer_init: inl (0xAC04) = cb35000
kernel: via_chan_buffer_init: EXIT
kernel: via_chan_maybe_start: starting channel PCM-OUT
kernel: via_dsp_do_write: Flushed block 0, sw_ptr now 1, n_frags now 31
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 00000040 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 1, sw_ptr now 2, n_frags now 30
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 0000002E 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 2, sw_ptr now 3, n_frags now 29
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 00000022 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 3, sw_ptr now 4, n_frags now 28
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 00000016 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 4, sw_ptr now 5, n_frags now 27
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 0000000A 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35010, chan->hw_ptr=1
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 28
kernel: via_dsp_do_write: Flushed block 5, sw_ptr now 6, n_frags now 27
kernel: via_dsp_do_write: regs==80 00 87 0CB35010 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 6, sw_ptr now 7, n_frags now 26
kernel: via_dsp_do_write: regs==80 00 87 0CB35010 0000001F 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 7, sw_ptr now 8, n_frags now 25
kernel: via_dsp_do_write: regs==80 00 87 0CB35010 00000013 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 8, sw_ptr now 9, n_frags now 24
kernel: via_dsp_do_write: regs==80 00 87 0CB35010 00000007 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35018, chan->hw_ptr=2
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 25
kernel: via_dsp_do_write: Flushed block 9, sw_ptr now 10, n_frags now 24
kernel: via_dsp_do_write: regs==80 00 87 0CB35018 00000025 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 10, sw_ptr now 11, n_frags now 23
kernel: via_dsp_do_write: regs==80 00 87 0CB35018 00000019 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 11, sw_ptr now 12, n_frags now 22
kernel: via_dsp_do_write: regs==80 00 87 0CB35018 0000000A 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35020, chan->hw_ptr=3
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 23
kernel: via_dsp_do_write: Flushed block 12, sw_ptr now 13, n_frags now 22
kernel: via_dsp_do_write: regs==80 00 87 0CB35020 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 13, sw_ptr now 14, n_frags now 21
kernel: via_dsp_do_write: regs==80 00 87 0CB35020 0000001F 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 14, sw_ptr now 15, n_frags now 20
kernel: via_dsp_do_write: regs==80 00 87 0CB35020 00000013 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 15, sw_ptr now 16, n_frags now 19
kernel: via_dsp_do_write: regs==80 00 87 0CB35020 00000007 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35028, chan->hw_ptr=4
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 20
kernel: via_dsp_do_write: Flushed block 16, sw_ptr now 17, n_frags now 19
kernel: via_dsp_do_write: regs==80 00 87 0CB35028 00000029 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 17, sw_ptr now 18, n_frags now 18
kernel: via_dsp_do_write: regs==80 00 87 0CB35028 0000001C 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 18, sw_ptr now 19, n_frags now 17
kernel: via_dsp_do_write: regs==80 00 87 0CB35028 00000010 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 19, sw_ptr now 20, n_frags now 16
kernel: via_dsp_do_write: regs==80 00 87 0CB35028 00000004 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35030, chan->hw_ptr=5
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 17
kernel: via_dsp_do_write: Flushed block 20, sw_ptr now 21, n_frags now 16
kernel: via_dsp_do_write: regs==80 00 87 0CB35030 00000026 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 21, sw_ptr now 22, n_frags now 15
kernel: via_dsp_do_write: regs==80 00 87 0CB35030 0000001A 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 22, sw_ptr now 23, n_frags now 14
kernel: via_dsp_do_write: regs==80 00 87 0CB35030 0000000E 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35038, chan->hw_ptr=6
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 15
kernel: via_dsp_do_write: Flushed block 23, sw_ptr now 24, n_frags now 14
kernel: via_dsp_do_write: regs==80 00 87 0CB35038 0000002D 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 24, sw_ptr now 25, n_frags now 13
kernel: via_dsp_do_write: regs==80 00 87 0CB35038 00000021 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 25, sw_ptr now 26, n_frags now 12
kernel: via_dsp_do_write: regs==80 00 87 0CB35038 00000012 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 26, sw_ptr now 27, n_frags now 11
kernel: via_dsp_do_write: regs==80 00 87 0CB35038 00000006 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35040, chan->hw_ptr=7
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 12
kernel: via_dsp_do_write: Flushed block 27, sw_ptr now 28, n_frags now 11
kernel: via_dsp_do_write: regs==80 00 87 0CB35040 00000027 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 28, sw_ptr now 29, n_frags now 10
kernel: via_dsp_do_write: regs==80 00 87 0CB35040 0000001B 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 29, sw_ptr now 30, n_frags now 9
kernel: via_dsp_do_write: regs==80 00 87 0CB35040 0000000F 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 30, sw_ptr now 31, n_frags now 8
kernel: via_dsp_do_write: regs==80 00 87 0CB35040 00000003 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35048, chan->hw_ptr=8
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 9
kernel: via_dsp_do_write: Flushed block 31, sw_ptr now 0, n_frags now 8
kernel: via_dsp_do_write: regs==80 00 87 0CB35048 00000025 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 0, sw_ptr now 1, n_frags now 7
kernel: via_dsp_do_write: regs==80 00 87 0CB35048 00000019 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 1, sw_ptr now 2, n_frags now 6
kernel: via_dsp_do_write: regs==80 00 87 0CB35048 0000000D 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 2, sw_ptr now 3, n_frags now 5
kernel: via_dsp_do_write: regs==80 00 87 0CB35048 00000001 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35050, chan->hw_ptr=9
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 6
kernel: via_dsp_do_write: Flushed block 3, sw_ptr now 4, n_frags now 5
kernel: via_dsp_do_write: regs==80 00 87 0CB35050 00000024 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 4, sw_ptr now 5, n_frags now 4
kernel: via_dsp_do_write: regs==80 00 87 0CB35050 00000017 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 5, sw_ptr now 6, n_frags now 3
kernel: via_dsp_do_write: regs==80 00 87 0CB35050 00000007 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35058, chan->hw_ptr=10
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 4
kernel: via_dsp_do_write: Flushed block 6, sw_ptr now 7, n_frags now 3
kernel: via_dsp_do_write: regs==80 00 87 0CB35058 00000026 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 7, sw_ptr now 8, n_frags now 2
kernel: via_dsp_do_write: regs==80 00 87 0CB35058 0000001A 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 8, sw_ptr now 9, n_frags now 1
kernel: via_dsp_do_write: regs==80 00 87 0CB35058 0000000E 00AC0000 00001000
kernel: via_dsp_do_write: Flushed block 9, sw_ptr now 10, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35058 00000002 00AC0000 00001000
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35060, chan->hw_ptr=11
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 10, sw_ptr now 11, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35060 00000024 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 11, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35068, chan->hw_ptr=12
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 11, sw_ptr now 12, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35068 0000002D 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 12, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35070, chan->hw_ptr=13
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 12, sw_ptr now 13, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35070 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 13, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35078, chan->hw_ptr=14
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 13, sw_ptr now 14, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35078 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 14, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35080, chan->hw_ptr=15
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 14, sw_ptr now 15, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35080 0000001F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 15, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35088, chan->hw_ptr=16
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 15, sw_ptr now 16, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35088 00000026 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 16, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35090, chan->hw_ptr=17
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 16, sw_ptr now 17, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35090 00000023 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 17, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35098, chan->hw_ptr=18
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 17, sw_ptr now 18, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35098 00000025 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 18, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A0, chan->hw_ptr=19
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 18, sw_ptr now 19, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350A0 00000024 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 19, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A8, chan->hw_ptr=20
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 19, sw_ptr now 20, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350A8 00000024 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 20, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B0, chan->hw_ptr=21
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 20, sw_ptr now 21, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350B0 00000025 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 21, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B8, chan->hw_ptr=22
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 21, sw_ptr now 22, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350B8 00000018 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 22, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C0, chan->hw_ptr=23
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 22, sw_ptr now 23, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350C0 00000024 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 23, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C8, chan->hw_ptr=24
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 23, sw_ptr now 24, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350C8 00000025 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 24, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D0, chan->hw_ptr=25
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 24, sw_ptr now 25, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350D0 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 25, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D8, chan->hw_ptr=26
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 25, sw_ptr now 26, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350D8 00000022 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 26, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E0, chan->hw_ptr=27
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 26, sw_ptr now 27, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350E0 00000024 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 27, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E8, chan->hw_ptr=28
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 27, sw_ptr now 28, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350E8 00000023 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 28, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F0, chan->hw_ptr=29
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 28, sw_ptr now 29, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350F0 00000028 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 29, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F8, chan->hw_ptr=30
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 29, sw_ptr now 30, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350F8 00000023 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 30, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35100, chan->hw_ptr=31
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 30, sw_ptr now 31, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35100 00000024 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 31, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001010
kernel: via_intr_channel: PCM-OUT intr, status=0x02, hwptr=0xCB35008, chan->hw_ptr=0
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 31, sw_ptr now 0, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 00000023 00AC0000 00001000
kernel: via_dsp_write: EXIT, returning 4096
kernel: via_dsp_write: ENTER, file=cbaef380, buffer=0804cea8, count=4096, ppos=0
kernel: via_chan_set_buffering: ENTER
kernel: via_chan_set_buffering: EXIT
kernel: via_chan_buffer_init: ENTER
kernel: via_chan_buffer_init: EXIT
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35010, chan->hw_ptr=1
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 0, sw_ptr now 1, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35010 0000001D 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 1, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35018, chan->hw_ptr=2
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 1, sw_ptr now 2, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35018 00000029 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 2, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35020, chan->hw_ptr=3
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 2, sw_ptr now 3, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35020 00000017 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 3, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35028, chan->hw_ptr=4
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 3, sw_ptr now 4, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35028 0000002A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 4, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35030, chan->hw_ptr=5
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 4, sw_ptr now 5, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35030 00000021 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 5, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35038, chan->hw_ptr=6
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 5, sw_ptr now 6, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35038 00000026 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 6, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35040, chan->hw_ptr=7
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 6, sw_ptr now 7, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35040 00000021 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 7, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35048, chan->hw_ptr=8
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 7, sw_ptr now 8, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35048 00000029 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 8, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35050, chan->hw_ptr=9
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 8, sw_ptr now 9, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35050 00000029 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 9, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35058, chan->hw_ptr=10
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 9, sw_ptr now 10, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35058 0000002A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 10, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35060, chan->hw_ptr=11
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 10, sw_ptr now 11, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35060 0000002A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 11, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35068, chan->hw_ptr=12
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 11, sw_ptr now 12, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35068 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 12, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35070, chan->hw_ptr=13
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 12, sw_ptr now 13, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35070 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 13, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35078, chan->hw_ptr=14
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 13, sw_ptr now 14, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35078 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 14, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35080, chan->hw_ptr=15
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 14, sw_ptr now 15, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35080 0000002A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 15, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35088, chan->hw_ptr=16
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 15, sw_ptr now 16, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35088 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 16, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35090, chan->hw_ptr=17
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 16, sw_ptr now 17, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35090 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 17, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35098, chan->hw_ptr=18
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 17, sw_ptr now 18, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35098 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 18, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A0, chan->hw_ptr=19
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 18, sw_ptr now 19, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350A0 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 19, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A8, chan->hw_ptr=20
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 19, sw_ptr now 20, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350A8 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 20, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B0, chan->hw_ptr=21
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 20, sw_ptr now 21, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350B0 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 21, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B8, chan->hw_ptr=22
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 21, sw_ptr now 22, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350B8 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 22, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C0, chan->hw_ptr=23
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 22, sw_ptr now 23, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350C0 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 23, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C8, chan->hw_ptr=24
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 23, sw_ptr now 24, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350C8 0000002A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 24, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D0, chan->hw_ptr=25
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 24, sw_ptr now 25, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350D0 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 25, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D8, chan->hw_ptr=26
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 25, sw_ptr now 26, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350D8 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 26, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E0, chan->hw_ptr=27
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 26, sw_ptr now 27, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350E0 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 27, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E8, chan->hw_ptr=28
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 27, sw_ptr now 28, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350E8 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 28, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F0, chan->hw_ptr=29
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 28, sw_ptr now 29, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350F0 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 29, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F8, chan->hw_ptr=30
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 29, sw_ptr now 30, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350F8 00000022 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 30, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35100, chan->hw_ptr=31
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 30, sw_ptr now 31, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35100 00000027 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 31, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001010
kernel: via_intr_channel: PCM-OUT intr, status=0x02, hwptr=0xCB35008, chan->hw_ptr=0
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 31, sw_ptr now 0, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 0, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35010, chan->hw_ptr=1
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 0, sw_ptr now 1, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35010 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 1, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35018, chan->hw_ptr=2
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 1, sw_ptr now 2, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35018 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 2, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35020, chan->hw_ptr=3
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 2, sw_ptr now 3, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35020 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 3, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35028, chan->hw_ptr=4
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 3, sw_ptr now 4, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35028 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 4, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35030, chan->hw_ptr=5
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 4, sw_ptr now 5, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35030 00000023 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 5, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35038, chan->hw_ptr=6
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 5, sw_ptr now 6, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35038 00000029 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 6, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35040, chan->hw_ptr=7
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 6, sw_ptr now 7, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35040 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 7, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35048, chan->hw_ptr=8
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 7, sw_ptr now 8, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35048 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 8, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35050, chan->hw_ptr=9
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 8, sw_ptr now 9, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35050 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 9, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35058, chan->hw_ptr=10
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 9, sw_ptr now 10, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35058 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 10, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35060, chan->hw_ptr=11
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 10, sw_ptr now 11, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35060 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 11, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35068, chan->hw_ptr=12
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 11, sw_ptr now 12, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35068 00000022 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 12, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35070, chan->hw_ptr=13
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 12, sw_ptr now 13, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35070 00000026 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 13, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35078, chan->hw_ptr=14
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 13, sw_ptr now 14, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35078 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 14, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35080, chan->hw_ptr=15
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 14, sw_ptr now 15, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35080 0000002D 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 15, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35088, chan->hw_ptr=16
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 15, sw_ptr now 16, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35088 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 16, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35090, chan->hw_ptr=17
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 16, sw_ptr now 17, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35090 0000002C 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 17, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35098, chan->hw_ptr=18
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 17, sw_ptr now 18, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35098 0000002D 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 18, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A0, chan->hw_ptr=19
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 18, sw_ptr now 19, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350A0 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 19, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A8, chan->hw_ptr=20
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 19, sw_ptr now 20, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350A8 0000002B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 20, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B0, chan->hw_ptr=21
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 20, sw_ptr now 21, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350B0 0000003B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 21, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B8, chan->hw_ptr=22
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 21, sw_ptr now 22, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350B8 0000003A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 22, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C0, chan->hw_ptr=23
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 22, sw_ptr now 23, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350C0 0000003A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 23, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C8, chan->hw_ptr=24
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 23, sw_ptr now 24, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350C8 0000003B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 24, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D0, chan->hw_ptr=25
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 24, sw_ptr now 25, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350D0 0000003A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 25, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D8, chan->hw_ptr=26
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 25, sw_ptr now 26, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350D8 0000003A 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 26, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E0, chan->hw_ptr=27
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 26, sw_ptr now 27, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350E0 0000003B 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 27, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E8, chan->hw_ptr=28
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 27, sw_ptr now 28, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350E8 00000039 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 28, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F0, chan->hw_ptr=29
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 28, sw_ptr now 29, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350F0 0000003F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 29, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F8, chan->hw_ptr=30
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 29, sw_ptr now 30, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350F8 0000003F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 30, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35100, chan->hw_ptr=31
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 30, sw_ptr now 31, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35100 0000003F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 31, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001010
kernel: via_intr_channel: PCM-OUT intr, status=0x02, hwptr=0xCB35008, chan->hw_ptr=0
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 31, sw_ptr now 0, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 0000003F 00AC0000 00001000
kernel: via_dsp_write: EXIT, returning 4096
kernel: via_dsp_write: ENTER, file=cbaef380, buffer=0804cea8, count=2366, ppos=0
kernel: via_chan_set_buffering: ENTER
kernel: via_chan_set_buffering: EXIT
kernel: via_chan_buffer_init: ENTER
kernel: via_chan_buffer_init: EXIT
kernel: via_dsp_do_write: Sleeping on page 0, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35010, chan->hw_ptr=1
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 0, sw_ptr now 1, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35010 0000002F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 1, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35018, chan->hw_ptr=2
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 1, sw_ptr now 2, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35018 0000003F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 2, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35020, chan->hw_ptr=3
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 2, sw_ptr now 3, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35020 0000003F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 3, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35028, chan->hw_ptr=4
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 3, sw_ptr now 4, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35028 0000003F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 4, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35030, chan->hw_ptr=5
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 4, sw_ptr now 5, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35030 0000003F 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 5, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35038, chan->hw_ptr=6
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 5, sw_ptr now 6, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35038 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 6, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35040, chan->hw_ptr=7
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 6, sw_ptr now 7, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35040 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 7, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35048, chan->hw_ptr=8
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 7, sw_ptr now 8, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35048 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 8, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35050, chan->hw_ptr=9
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 8, sw_ptr now 9, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35050 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 9, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35058, chan->hw_ptr=10
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 9, sw_ptr now 10, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35058 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 10, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35060, chan->hw_ptr=11
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 10, sw_ptr now 11, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35060 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 11, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35068, chan->hw_ptr=12
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 11, sw_ptr now 12, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35068 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 12, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35070, chan->hw_ptr=13
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 12, sw_ptr now 13, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35070 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 13, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35078, chan->hw_ptr=14
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 13, sw_ptr now 14, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35078 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 14, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35080, chan->hw_ptr=15
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 14, sw_ptr now 15, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35080 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 15, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35088, chan->hw_ptr=16
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 15, sw_ptr now 16, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35088 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 16, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35090, chan->hw_ptr=17
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 16, sw_ptr now 17, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35090 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 17, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35098, chan->hw_ptr=18
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 17, sw_ptr now 18, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35098 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 18, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A0, chan->hw_ptr=19
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 18, sw_ptr now 19, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350A0 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 19, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A8, chan->hw_ptr=20
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 19, sw_ptr now 20, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350A8 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 20, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B0, chan->hw_ptr=21
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 20, sw_ptr now 21, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350B0 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 21, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B8, chan->hw_ptr=22
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 21, sw_ptr now 22, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350B8 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 22, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C0, chan->hw_ptr=23
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 22, sw_ptr now 23, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350C0 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 23, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C8, chan->hw_ptr=24
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 23, sw_ptr now 24, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350C8 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 24, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D0, chan->hw_ptr=25
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 24, sw_ptr now 25, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350D0 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 25, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D8, chan->hw_ptr=26
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 25, sw_ptr now 26, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350D8 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 26, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E0, chan->hw_ptr=27
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 26, sw_ptr now 27, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350E0 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 27, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E8, chan->hw_ptr=28
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 27, sw_ptr now 28, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350E8 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 28, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F0, chan->hw_ptr=29
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 28, sw_ptr now 29, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350F0 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 29, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F8, chan->hw_ptr=30
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 29, sw_ptr now 30, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB350F8 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 30, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35100, chan->hw_ptr=31
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 30, sw_ptr now 31, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35100 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 31, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001010
kernel: via_intr_channel: PCM-OUT intr, status=0x02, hwptr=0xCB35008, chan->hw_ptr=0
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 31, sw_ptr now 0, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35008 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 0, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35010, chan->hw_ptr=1
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 0, sw_ptr now 1, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35010 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 1, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35018, chan->hw_ptr=2
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 1, sw_ptr now 2, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35018 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 2, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35020, chan->hw_ptr=3
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 2, sw_ptr now 3, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35020 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 3, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35028, chan->hw_ptr=4
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_do_write: Flushed block 3, sw_ptr now 4, n_frags now 0
kernel: via_dsp_do_write: regs==80 00 87 0CB35028 0000003E 00AC0000 00001000
kernel: via_dsp_do_write: Sleeping on page 4, tmp==0, ir==0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35030, chan->hw_ptr=5
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_write: EXIT, returning 2366
kernel: via_dsp_release: ENTER
kernel: via_dsp_drain_playback: ENTER, nonblock = 0
kernel: via_chan_flush_frag: ENTER
kernel: via_chan_flush_frag: EXIT
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35030 0000002D 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=0
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35038, chan->hw_ptr=6
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 1
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35038 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=1
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35040, chan->hw_ptr=7
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 2
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35040 0000003F 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=2
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35048, chan->hw_ptr=8
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 3
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35048 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=3
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35050, chan->hw_ptr=9
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 4
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35050 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=4
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35058, chan->hw_ptr=10
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 5
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35058 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=5
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35060, chan->hw_ptr=11
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 6
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35060 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=6
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35068, chan->hw_ptr=12
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 7
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35068 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=7
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35070, chan->hw_ptr=13
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 8
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35070 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=8
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35078, chan->hw_ptr=14
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 9
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35078 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=9
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35080, chan->hw_ptr=15
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 10
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35080 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=10
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35088, chan->hw_ptr=16
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 11
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35088 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=11
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35090, chan->hw_ptr=17
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 12
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35090 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=12
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35098, chan->hw_ptr=18
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 13
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35098 0000003D 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=13
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A0, chan->hw_ptr=19
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 14
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350A0 0000003D 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=14
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350A8, chan->hw_ptr=20
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 15
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350A8 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=15
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B0, chan->hw_ptr=21
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 16
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350B0 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=16
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350B8, chan->hw_ptr=22
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 17
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350B8 0000003F 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=17
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C0, chan->hw_ptr=23
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 18
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350C0 0000003F 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=18
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350C8, chan->hw_ptr=24
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 19
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350C8 0000003F 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=19
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D0, chan->hw_ptr=25
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 20
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350D0 0000003C 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=20
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350D8, chan->hw_ptr=26
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 21
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350D8 0000003C 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=21
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E0, chan->hw_ptr=27
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 22
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350E0 00000039 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=22
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350E8, chan->hw_ptr=28
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 23
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350E8 0000003D 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=23
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F0, chan->hw_ptr=29
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 24
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350F0 0000003D 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=24
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB350F8, chan->hw_ptr=30
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 25
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB350F8 0000003F 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=25
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35100, chan->hw_ptr=31
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 26
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35100 0000003B 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=26
kernel: via_interrupt: intr, status32 == 0x00001010
kernel: via_intr_channel: PCM-OUT intr, status=0x02, hwptr=0xCB35008, chan->hw_ptr=0
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 27
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35008 00000039 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=27
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35010, chan->hw_ptr=1
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 28
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35010 00000039 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=28
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35018, chan->hw_ptr=2
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 29
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35018 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=29
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35020, chan->hw_ptr=3
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 30
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35020 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=30
kernel: via_interrupt: intr, status32 == 0x00001001
kernel: via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0xCB35028, chan->hw_ptr=4
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 31
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35028 0000003C 00AC0000 00001000
kernel: via_dsp_drain_playback: sleeping, nbufs=31
kernel: via_interrupt: intr, status32 == 0x00001110
kernel: via_intr_channel: PCM-OUT intr, status=0x06, hwptr=0xCB35008, chan->hw_ptr=5
kernel: via_intr_channel: PCM-OUT intr, channel n_frags == 32
kernel: via_dsp_drain_playback: PCI config: 01 CC 40 1C 80 05
kernel: via_dsp_drain_playback: regs==80 00 87 0CB35008 0000003E 00AC0000 00001000
kernel: via_dsp_drain_playback: final nbufs=32
kernel: via_dsp_drain_playback: EXIT, returning 0
kernel: via_chan_free: ENTER
kernel: via_chan_pcm_fmt: ENTER, pcm_fmt=0x87, reset=yes
kernel: via_chan_pcm_fmt: EXIT, pcm_fmt = 0x87, reg = 0x87
kernel: via_chan_free: EXIT
kernel: via_chan_buffer_free: ENTER
kernel: via_ac97_wait_idle: ENTER/EXIT
kernel: via_chan_buffer_free: EXIT
kernel: via_dsp_release: EXIT, returning 0
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x27c8384, retval=0x8384
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x27e7609, retval=0x7609
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2280200, retval=0x200
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2006940, retval=0x6940
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2200000, retval=0x0
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2280200, retval=0x200
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x22c0000, retval=0x0
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x27c8384, retval=0x8384
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x27e7609, retval=0x7609
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2280200, retval=0x200
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2006940, retval=0x6940
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2200000, retval=0x0
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2280200, retval=0x200
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x22c0000, retval=0x0
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x27c8384, retval=0x8384
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x27e7609, retval=0x7609
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2280200, retval=0x200
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2006940, retval=0x6940
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2200000, retval=0x0
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x2280200, retval=0x200
kernel: via_ac97_read_reg: ENTER
kernel: via_ac97_read_reg: EXIT, success, data=0x22c0000, retval=0x0
kernel: via_info_read_proc: ENTER
kernel: via_info_read_proc: EXIT, returning 557
kernel: via_info_read_proc: ENTER
kernel: via_info_read_proc: EXIT, returning 557
kernel: via_info_read_proc: ENTER
kernel: via_info_read_proc: EXIT, returning 557
kernel: cleanup_via82cxxx_audio: ENTER
kernel: via_remove_one: ENTER
kernel: via_interrupt_cleanup: ENTER
kernel: via_interrupt_disable: ENTER
kernel: via_interrupt_disable: EXIT
kernel: via_interrupt_cleanup: EXIT
kernel: via_card_cleanup_proc: ENTER
kernel: via_card_cleanup_proc: EXIT
kernel: via_dsp_cleanup: ENTER
kernel: via_stop_everything: ENTER
kernel: via_stop_everything: EXIT
kernel: via_dsp_cleanup: EXIT
kernel: via_ac97_cleanup: ENTER
kernel: via_ac97_cleanup: EXIT
kernel: via_remove_one: EXIT
kernel: via_cleanup_proc: ENTER
kernel: via_cleanup_proc: EXIT
kernel: cleanup_via82cxxx_audio: EXIT

$ ./via-audio-diag -aps
via-audio-diag.c:v1.00 05/06/2000 Jeff Garzik (jgarzik@mandrakesoft.com)
Index #1: Found a via 686a audio adapter at 0xac00.
AC97 RESET = 0x6940 (26944)
AC97 MASTER_VOL_STEREO = 0x0A0A (2570)
AC97 HEADPHONE_VOL = 0x8000 (32768)
AC97 MASTER_VOL_MONO = 0x000A (10)
AC97 MASTER_TONE = 0x0000 (0)
AC97 PCBEEP_VOL = 0x000A (10)
AC97 PHONE_VOL = 0x000A (10)
AC97 MIC_VOL = 0x8000 (32768)
AC97 LINEIN_VOL = 0x0A0A (2570)
AC97 CD_VOL = 0x0A0A (2570)
AC97 VIDEO_VOL = 0x0A0A (2570)
AC97 AUX_VOL = 0x0A0A (2570)
AC97 PCMOUT_VOL = 0x0A0A (2570)
AC97 RECORD_SELECT = 0x0000 (0)
AC97 RECORD_GAIN = 0x0A0A (2570)
AC97 RECORD_GAIN_MIC = 0x0000 (0)
AC97 GENERAL_PURPOSE = 0x0000 (0)
AC97 3D_CONTROL = 0x0000 (0)
AC97 MODEM_RATE = 0x0000 (0)
AC97 POWER_CONTROL = 0x000F (15)
AC97 EXTENDED_ID = 0x0200 (512)
AC97 EXTENDED_STATUS = 0x0080 (128)
AC97 PCM_FRONT_DAC_RATE = 0x0000 (0)
AC97 PCM_SURR_DAC_RATE = 0x0000 (0)
AC97 PCM_LFE_DAC_RATE = 0x0000 (0)
AC97 PCM_LR_ADC_RATE = 0x0000 (0)
AC97 PCM_MIC_ADC_RATE = 0x0000 (0)
AC97 CENTER_LFE_MASTER = 0x0000 (0)
AC97 SURROUND_MASTER = 0x0000 (0)
AC97 RESERVED_3A = 0x0000 (0)
SGD Playback            : 00 00 00 00000000 00000024
SGD Record              : 00 00 00 00000000 00000000
SGD FM                  : 00 00 00 00000000 00000000
SGD Modem Playback      : 00 00 00 00000000 00000000
SGD Modem Record        : 00 00 00 00000000 00000000
SGD reg 0x80 = 0x00BA0000
SGD reg 0x84 = 0x00000000
SGD reg 0x88 = 0x00000000
SGD reg 0x8C = 0x00000000
PCI reg 0x10 = 0xD0000008
PCI reg 0x3C = 0x00
PCI reg 0x40 = 0x00
PCI reg 0x41 = 0x00
PCI reg 0x42 = 0x00
PCI reg 0x43 = 0x00
PCI reg 0x44 = 0x00
PCI reg 0x48 = 0x00

Some Infos on PCI:

$ lspci -xv
note, that  eepro100 and via82cxxx_audio are using th same IRQ (but
this shouldn't be the problem, I think. (?))

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Flags: bus master, medium devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 91 06 06 00 10 22 c4 00 00 06 00 00 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d4000000-d7ffffff
	Capabilities: [80] Power Management version 2
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 90 90 00 00
20: 00 d8 f0 d9 00 d4 f0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
00: 06 11 86 06 87 00 10 02 22 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at a000 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 10 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a400 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 07 00 10 02 10 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 04 00 00

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 30 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
	Subsystem: Sigmatel Inc: Unknown device 7609
	Flags: medium devsel, IRQ 10
	I/O ports at ac00 [size=256]
	I/O ports at b000 [size=4]
	I/O ports at b400 [size=4]
	Capabilities: [c0] Power Management version 2
00: 06 11 58 30 01 00 10 02 20 00 01 04 00 00 00 00
10: 01 ac 00 00 01 b0 00 00 01 b4 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 dd 15 09 76
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 03 00 00

00:09.0 SCSI storage controller: Adaptec 7892B (rev 02)
	Subsystem: Adaptec: Unknown device 62a1
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	BIST result: 00
	I/O ports at bc00 [size=256]
	Memory at db101000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
00: 05 90 81 00 07 00 b0 02 02 00 00 01 08 20 00 80
10: 01 bc 00 00 04 10 10 db 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 a1 62
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 28 19

00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at db100000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at c000 [size=64]
	Memory at db000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
00: 86 80 29 12 07 00 90 02 08 00 00 02 08 20 00 00
10: 00 00 10 db 01 c0 00 00 00 00 00 db 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 08 38

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 9
	Memory at d4000000 (32-bit, prefetchable) [size=64M]
	I/O ports at 9000 [size=256]
	Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2
00: 02 10 46 50 87 00 b0 02 00 00 00 03 08 20 00 00
10: 08 00 00 d4 01 90 00 00 00 00 00 d9 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 08 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 08 00




